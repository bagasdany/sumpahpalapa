<?php

namespace App\Repositories;

use App\Jobs\SendSingleNotificationJob;
use App\Models\Addresses;
use App\Models\Admin;
use App\Models\Clients;
use App\Models\Coupon;
use App\Models\Currency;
use App\Models\DeliveryBoyOrder;
use App\Models\DeliveryBoyPayout;
use App\Models\DeliveryPayoutHistory;
use App\Models\Languages;
use App\Models\Orders as Model;
use App\Models\OrdersComment;
use App\Models\OrderShippingDetail;
use App\Models\OrdersStatus;
use App\Models\ProductExtras;
use App\Models\Products;
use App\Models\ShopPoint;
use App\Models\Shops;
use App\Models\ShopsCurriencies;
use App\Repositories\Interfaces\OrderInterface;
use App\Repositories\Interfaces\TransactionInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;
use App\Traits\SendNotification;
use Carbon\Carbon;
use DB;

class OrderRepository extends CoreRepository implements OrderInterface
{
    use ApiResponse;
    use DatatableResponse;
    use SendNotification;

    protected $transaction;
    protected $product;

    public function __construct(TransactionInterface $transaction, Products $product)
    {
        parent::__construct();
        $this->transaction = $transaction;
        $this->product = $product;
    }

    protected function getModelClass()
    {
        return Model::class;
    }

    public function delete($id)
    {
        Model::find($id)->delete();

        return $this->successResponse("success");
    }

    public function createOrUpdateForRest($collection = [])
    {
        // Check Shop AmountLimit before create Order
        $amount_limit = Shops::amountLimit($collection['shop']);
        if ($amount_limit > $collection['total_amount']) {
            return $this->errorResponse("Minimum amount for order is " . $amount_limit);
        }

        // Check products in stock and Set for Order
        $products = $this->setOrderProducts($collection['product_details']);
        if($products->contains('tag', true)){
            return  $this->successResponse('Some product not enough in stock', ['missed_products' =>  $products]);
        }

        try {
            $defaultAddress = Addresses::where([
                "id_user" => $collection['user'],
                "default" => 1
            ])->first();

            if ($defaultAddress) {
                $defaultAddress->default = 0;
                $defaultAddress->save();
            }

            $address = Addresses::updateOrCreate([
                "latitude" => round($collection['address']['lat'], 4),
                "longtitude" => round($collection['address']['lng'], 4),
                "id_user" => $collection['user'],
            ], [
                'latitude' => round($collection['address']['lat'], 4),
                'longtitude' => round($collection['address']['lng'], 4),
                'address' => $collection['address']['address'],
                'default' => 1,
                'active' => 1,
                'id_user' => $collection['user']
            ]);

            if ($address) {
                $id_address = $address->id;
                $currency = Currency::find($collection['currency_id']);
                $rate = $currency->rate;

                $order = Model::create([
                    'tax' => round($collection['tax'] / $rate, 2),
                    "total_sum" => $summa ?? round($collection['total_amount'] / $rate, 2),
                    "total_discount" => round($collection['total_discount'] /$rate, 2),
                    'delivery_date' => $collection['delivery_date'],
                    'delivery_time_id' => $collection['delivery_time_id'],
                    "delivery_fee" => round($collection['delivery_fee'] / $rate, 2),
                    'active' => 1,
                    'type' => $collection['delivery_type'],
                    'comment' => $collection['comment'],
                    'id_user' => $collection['user'],
                    'order_status' => 1,
                    'id_shop' => $collection['shop'],
                    'id_delivery_address' => $id_address,
                    'coupon_amount' => $coupon_amount ?? 0,
                    'currency_id' => $collection['currency_id'] ?? $currency->id,
                    'currency_rate' => 1
                ]);


                if ($order) {
                    // Check coupon for order
                    $this->checkCoupon($collection, $order);

                    // Create Order Products for details
                    if (count($products) > 0) {
                        $productIds = $this->setOrderProductDetails($order, $products);
                        // Set Order Deleted Product quantity
                        $this->setOrderDeleteProducts($order, $productIds);
                    }

                    OrderShippingDetail::create([
                        'order_id' => $order->id,
                        'delivery_type_id' => $collection['delivery_type_id'] ?? 0,
                        'delivery_transport_id' => $collection['delivery_transport_id'] ?? 0,
                        'shipping_box_id' => $collection['shipping_box_id'] ?? 0,
                    ]);
                    return $this->successResponse("success", $order);
                }
            }
            return $this->errorResponse("error in saving faq");
        } catch (\Exception $e) {
            return $this->errorResponse($e->getMessage());
        }
    }

    public function get($id)
    {
        $defaultLanguage = Languages::where("default", 1)->first();

        $order = Model::with([
            "details.product.language" => function ($query) use ($defaultLanguage) {
                $query->where('id_lang', $defaultLanguage->id);
            },
            "details.product.taxes",
            "details.extras.language" => function ($query) use ($defaultLanguage) {
                $query->where('id_lang', $defaultLanguage->id);
            },
            "review",
            "orderDeliveryBoy",
            'deliveryType.deliveryType' => function ($q) use ($defaultLanguage) {
                $q->where('lang_id', $defaultLanguage->id);
            },
            'deliveryTransport.deliveryTransport' => function ($q) use ($defaultLanguage) {
                $q->where('lang_id', $defaultLanguage->id);
            },
            'deliveryBox.shippingBox' => function ($q) use ($defaultLanguage) {
                $q->where('lang_id', $defaultLanguage->id);
            },
            "transaction"
        ])->where("id", $id)->first();

        if ($order) {

            foreach ($order['details'] as $key => $value) {
                $order['details'][$key]['name'] = $order['details'][$key]['product']['language']['name'];
                $order['details'][$key]['in_stock'] = $order['details'][$key]['product']['quantity'];
                $order['details'][$key]['product'] = $order['details'][$key]['product']['discount'];
            }

            if ($order->transaction) {
                $transaction = collect($order->transaction)->merge([
                    'payment_type' => $order->transaction->payment->language->name,
                    'payment_status' => $order->transaction->paymentStatus->name
                ]);
                $order = collect($order)->merge([
                    'transaction' => $transaction,
                ]);
            }

            return $this->successResponse("success", $order);
        }
        return $this->errorResponse("Order not found");
    }

    public function changeOrderStatus($id_order, $status)
    {
        $order = Model::with('deliveryRoute', 'orderDeliveryBoy')->findOrFail($id_order);
        if ($order && $status != 5) {
            $order->order_status = $status;

            if ($status == 2)
                $order->processing_date = date("Y-m-d H:i:s");
            else if ($status == 3)
                $order->ready_date = date("Y-m-d H:i:s");
            else if ($status == 4)
                $order->delivered_date = date("Y-m-d H:i:s");

            $order->save();
            $this->deliveryBoyOrderStatus($id_order, $order->id_delivery_boy, 1);
        } else if ($status == 5) {
            $order->order_status = $status;
            $order->save();

            $this->deliveryBoyOrderStatus($id_order, $order->id_delivery_boy, 2);
        }
        if ($status == 4) {
            $params = [
                'shop_id' => $order->id_shop, 'admin_id' => $order->orderDeliveryBoy->id,
                'order_id' => $order->id, 'type' => 'CREDIT',
                'note' => 'Topup for Delivery Order #' . $order->id,
                'amount' => $order->deliveryRoute->price ?? $order->delivery_fee,
                'status' => 1,
                'status_description' => 'Successful',
            ];
            $transaction = $this->transaction->createOrUpdate($params);
            if ($transaction) {
                $deliveryBoy = Admin::find($order->orderDeliveryBoy->id);
                $deliveryBoy->balance()->update([
                    'balance' => $deliveryBoy->balance->balance + ($order->deliveryRoute->price ?? $order->delivery_fee)
                ]);
            }
        }

        return $this->successResponse("success", $order);
    }

    public function getOrderDetailByStatusForRest($collection = [])
    {
        $statuses = [intval($collection['status'])];
        if ($collection['status'] == 2) $statuses = [2, 3];

        $order = Model::with([
            "shop.language" => function ($query) use ($collection) {
                $query->id_lang = $collection['id_lang'];
            },
            "details",
            "details.extras",
            "details.extras.language",
            "timeUnit",
            "address",
            "deliveryBoy",
            "details.product.language" => function ($query) use ($collection) {
                $query->id_lang = $collection['id_lang'];
            },
            "details.product.images",
            "details.product.units.language",
        ])->where([
            "id_user" => $collection['id_user']
        ])
            ->whereIn("order_status", $statuses)
            ->skip($collection['offset'])
            ->take($collection['limit'])
            ->orderBy("id", "DESC")
            ->get();

        return $this->successResponse("success", $order);
    }

    public function getOrderCountByStatusAndClient($collection = [])
    {
        if (is_array($collection['status']))
            $order = Model::where([
                "id_user" => $collection['id_user']
            ])->whereIn("order_status", $collection['status'])->count();
        else
            $order = Model::where([
                "id_user" => $collection['id_user']
            ])->where("order_status", $collection['status'])->count();

        return $this->successResponse("success", $order);
    }

    public function createOrUpdate($collection = [])
    {
        $amount_limit = Shops::amountLimit($collection['id_shop']);
        if ($amount_limit > $collection['total_amount']) {
            return $this->errorResponse("Minimum amount for order is " . $amount_limit);
        }

        // Check products in stock and Set for Order
        if(isset($collection["id"]) && $collection["id"] > 0){
            $order = $this->startCondition()->find($collection["id"]);
            $prodId = $order->details->pluck('id_product');
        }
        $orderProducts =  $prodId ?? [];
        $products = $this->setOrderProducts($collection['product_details'], $orderProducts);

        if($products->contains('tag', true)){
            return $this->successResponse('Some product not enough in stock', ['missed_products' =>  $products]);
        }

        $order = Model::updateOrCreate([
            "id" => $collection["id"] ?? null
        ], [
            'tax' => $collection['tax'],
            "total_sum" => $summa ?? $collection['total_amount'],
            "total_discount" => $collection['total_discount'],
            "delivery_date" => date("y-m-d", strtotime($collection['delivery_date'])),
            "delivery_time_id" => $collection["delivery_time_id"],
            "delivery_fee" => $collection['delivery_fee'],
            "comment" => $collection["comment"] ?? "",
            "active" => 1,
            "type" => $collection["type"],
            "id_user" => $collection["id_user"],
            "order_status" => $collection["order_status"],
            "id_shop" => $collection["id_shop"],
            "id_delivery_address" => $collection["id_delivery_address"],
            "id_delivery_boy" => $collection['delivery_boy'] ?? null,
            "processing_date" => $collection["order_status"] == 2 ? date("Y-m-d H:i:s") : "",
            "ready_date" => $collection["order_status"] == 3 ? date("Y-m-d H:i:s") : "",
            "delivered_date" => $collection["order_status"] == 4 ? date("Y-m-d H:i:s") : "",
            "cancel_date" => $collection["order_status"] == 5 ? date("Y-m-d H:i:s") : "",
            "commission" => $products->sum('commission'),
            "coupon_amount" => $coupon_amount ?? 0,
        ]);

        if ($order) {
            // Add coupon to Order
            $this->checkCoupon($collection, $order);

            // Change Order transaction status
            if (isset($collection['payment_status'])) {
               $order->transaction()->update(['status' => $collection['payment_status']]);
            }

            $user = Clients::find($collection['id_user']);

            $message = "";
            if ($collection["order_status"] == 1) {
                $message = $user->name . ", Your order accepted";
            } else if ($collection["order_status"] == 2) {
                $message = $user->name . ", Your order ready to delivery";
            } else if ($collection["order_status"] == 3) {
                $message = $user->name . ", Your order is in a way";
            } else if ($collection["order_status"] == 4) {
                if (isset($collection["delivery_boy"])) {
                    // Charge DeliveryBoy balance balance
                    if (!$order->deliveryPayoutHistory) {
                        $payout = Admin::deliveryBoyPayout($collection["delivery_boy"], $order->delivery_fee);
                        if ($payout) {
                            DeliveryPayoutHistory::updateOrcreate(
                                ['admin_id' => $collection["delivery_boy"], 'order_id' => $order->id],
                                ['amount' => $payout, 'status' => 'success']
                            );
                        }
                    }
                }
                $message = $user->name . ", Your order delivered";
            } else if ($collection["order_status"] == 5) {
                $message = $user->name . ", Your order canceled";
            }

            if ($user)
                 SendSingleNotificationJob::dispatch($user->push_token, $message);
            $order_id = $order->id;

            if (isset($collection['comment']) && strlen($collection['comment']) > 1) {
                $order_review = OrdersComment::updateOrCreate([
                    "id_order" => $order_id
                ], [
                    "comment_text" => $collection['comment'],
                    "active" => 1,
                    "star" => $collection['star'],
                    "id_user" => $collection["id_user"],
                    "id_order" => $order_id
                ]);

                if ($order_review) {
                    $id_order_review = $order_review->id;
                    $order->id_review = $id_order_review;
                    $order->save();
                }
            }

            // Create Order Products for details
            if (count($products) > 0) {
                $productIds = $this->setOrderProductDetails($order, $products);
                // Set Order Deleted Product quantity
                $this->setOrderDeleteProducts($order, $productIds);
            }

            OrderShippingDetail::create([
                'order_id' => $order_id,
                'delivery_type_id' => $collection['id_shipping'] ?? 0,
                'delivery_transport_id' => $collection['id_shipping_transport'] ?? 0,
                'shipping_box_id' => $collection['id_shipping_box'] ?? 0,
            ]);

            //Set order delivery boy
            if (isset($collection['delivery_boy'])) {
                $delivery = DeliveryBoyOrder::firstWhere(['admin_id' => $collection['delivery_boy'], 'order_id' => $order->id]);
                if (!$delivery) {
                    $deliveryBoy = Admin::find($collection['delivery_boy']);
                    SendSingleNotificationJob::dispatch($deliveryBoy->push_token, 'A new order has been attached to you!');
                }

                DeliveryBoyOrder::updateOrCreate([
                    "admin_id" => $collection['delivery_boy'],
                    "order_id" => $order->id
                ], [
                    "status" => $collection["order_status"]
                ]);
            }

            return $this->successResponse("success", $order);
        }

        return $this->errorResponse("Error in saving");
    }

    public function orderStatusDatatable($collection = [])
    {
        $totalData = OrdersStatus::count();

        $totalFiltered = $totalData;

        $datas = OrdersStatus::skip($collection['start'])
            ->limit($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->name;
                $nestedData['active'] = $data->active;
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function getActiveStatus()
    {
        $paymentStatus = OrdersStatus::where([
            "active" => 1
        ])->get();

        return $this->successResponse("success", $paymentStatus);
    }

    public function datatable($collection = [])
    {
        $shop_id = Admin::getUserShopId();

        if ($shop_id == -1) {
            if (isset($collection['status']) || (isset($collection['order_date_from']) && isset($collection['order_date_to'])) || isset($collection['id_delivery_boy'])) {
                $totalData = Model::where("active", '>=', 0);

                if (isset($collection['status'])) {
                    $totalData = $totalData->whereIn('order_status', explode(",", $collection['status']));
                }

                if (isset($collection['order_date_from']) && isset($collection['order_date_to'])) {
                    $to = Carbon::parse($collection['order_date_to'])->addDay(); // Add one day to include $collection['order_date_to'] in the interval
                    $totalData = $totalData->whereBetween('created_at', [$collection['order_date_from'], $to]);
                }

                if (isset($collection['id_delivery_boy'])) {
                    $totalData = $totalData->whereHas('deliveryBoy', function ($query) use ($collection) {
                        $query->where('id', $collection['id_delivery_boy']);
                    });
                }

                if (isset($collection['shop_id'])) {
                    $totalData = $totalData->where('id_shop', $collection['shop_id']);
                }

                $totalData = $totalData->count();
            } else
                $totalData = Model::count();
        } else {
            $totalData = Model::where("id_shop", $shop_id);

            if (isset($collection['status'])) {
                $totalData = $totalData->whereIn('order_status', explode(",", $collection['status']));
            }

            if (isset($collection['order_date_from']) && isset($collection['order_date_to'])) {
                $to = Carbon::parse($collection['order_date_to'])->addDay(); // Add one day to include $collection['order_date_to'] in the interval
                $totalData = $totalData->whereBetween('created_at', [$collection['order_date_from'], $to]);
            }

            if (isset($collection['id_delivery_boy'])) {
                $totalData = $totalData->whereHas('deliveryBoy', function ($query) use ($collection) {
                    $query->where('id', $collection['id_delivery_boy']);
                });
            }

            if (isset($collection['shop_id'])) {
                $totalData = $totalData->where('id_shop', $collection['shop_id']);
            }

            $totalData = $totalData->count();
        }

        $totalFiltered = $collection['length'] ?? 0;

        $defaultLanguage = Languages::where("default", 1)->first();

        $datas = Model::with([
            "shop.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
            "orderStatus",
            "paymentStatus",
            "paymentMethod",
            "timeUnit",
            "address",
            "clients",
            "deliveryRoute",
            "deliveryBoy",
            "transaction.payment.language",
            "transaction.paymentStatus",
        ]);

        if ($shop_id != -1) {
            $datas = $datas->where('orders.id_shop', $shop_id);
        }

        // Filter orders by request params
        //$query = isset($collection['status']) ? ['order_status' => $status] : [];
        $sort = isset($collection['sort']) && $collection['sort'] == 'desc';
        if (isset($collection['order_date_from']) && isset($collection['order_date_to'])) {
            $to = Carbon::parse($collection['order_date_to'])->addDay(); // Add one day to include $collection['order_date_to'] in the interval
            $datas = $datas->whereBetween('created_at', [$collection['order_date_from'], $to]);
        }
        if (isset($collection['id_delivery_boy'])) {
            $datas = $datas->whereHas('deliveryBoy', function ($query) use ($collection) {
                $query->where('id', $collection['id_delivery_boy']);
            });
        }

        if (isset($collection['status'])) {
            $datas = $datas->whereIn('order_status', explode(",", $collection['status']));
        }

        if (isset($collection['shop_id'])) {
            $datas = $datas->where('id_shop', $collection['shop_id']);
        }

        $datas = $datas
            ->orderByDesc('id')
            ->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        if (isset($collection['sort'])) {
            $datas = $datas->sortBy('order_status', 1, $sort);
        }

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['amount'] = $data->total_sum;
                $nestedData['order_status'] = $data->orderStatus->name;
                $nestedData['order_status_id'] = $data->order_status;
                $nestedData['delivery_date'] = $data->delivery_date . " " . $data->timeUnit != null ? $data->timeUnit->name : "";
                $nestedData['delivery_boy'] = $data->deliveryBoy != null ? $data->deliveryBoy->name . " " . $data->deliveryBoy->surname : "";
                $nestedData['order_date'] = date("Y-m-d H:i:s", strtotime($data->created_at));
                $nestedData['user'] = $data->clients->name . " " . $data->clients->surname;
                $nestedData['shop'] = $data['id_shop'] != null && $data->shop ? $data->shop->language->name : "-";
                $nestedData['shop_lng_lat'] = $data['id_shop'] != null && $data->shop ? $data->shop->longtitude . "," . $data->shop->latitude : "";
                $nestedData['address_lng_lat'] = $data->address->longtitude . "," . $data->address->latitude;
                $nestedData['active'] = $data->active;
                $nestedData['payment_method'] = $data->transaction ? $data->transaction->payment == null ? "" : $data->transaction->payment->language->name : 'no payment';
                $nestedData['payment_status'] = $data->transaction ? $data->transaction->paymentStatus->name : 'In process';
                $nestedData['options'] = [
                    'delete' => 1,
                    'edit' => 1
                ];
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function orderCommentCreate($array)
    {
        $comment = OrdersComment::updateOrCreate(['id_order' => $array['order_id']],[
           'comment_text' => $array['comment'],
           'id_user' => $array['user_idd'],
           'star' => $array['star'] ?? 5.0,
        ]);

        $this->successResponse('Comment added', $comment);
    }

    public function commentsDatatable($collection = [])
    {
        $id_shop = Admin::getUserShopId();
        if ($id_shop == -1)
            $totalData = OrdersComment::count();
        else
            $totalData = OrdersComment::with([
                "order" => function ($query) use ($id_shop) {
                    $query->id_shop = $id_shop;
                }
            ])->has("order")->count();

        $totalFiltered = $totalData;

        $datas = OrdersComment::with([
            "order" => function ($query) use ($id_shop) {
                $query->id_shop = $id_shop;
            },
            "order.clients"
        ]);

        if ($id_shop != -1)
            $datas = $datas->has("order");

        $datas = $datas->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['client'] = $data->clients != null ? ($data->clients->name . " " . $data->clients->surname) : "";
                $nestedData['text'] = $data->comment_text;
                $nestedData['order'] = $data->id_order;
                $nestedData['active'] = $data->active;
                $nestedData['options'] = [
                    'delete' => 1,
                ];
                $responseData[] = $nestedData;
            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function getActiveClients()
    {
        $id_shop = Admin::getUserShopId();
        if ($id_shop == -1)
            $count = Model::groupBy("id_user")->count();
        else
            $count = Model::where("id_shop", $id_shop)->groupBy("id_user")->count();

        return $this->successResponse("success", $count);
    }

    public function getTotalOrdersCount()
    {
        $id_shop = Admin::getUserShopId();
        if ($id_shop == -1)
            $count = Model::count();
        else
            $count = Model::where("id_shop", $id_shop)->count();

        return $this->successResponse("success", $count);
    }

    public function getOrdersStaticByStatus()
    {
        $id_shop = Admin::getUserShopId();

        $canceled = [];
        $delivered = [];

        for ($i = 9; $i >= 0; $i--) {
            $date = date('Y-m-d', strtotime("-" . $i . " days"));

            if ($id_shop == -1)
                $canceledCount = Model::where([
                    "order_status" => 5,
                    ["created_at", ">=", $date . " 00:00:00"],
                    ["created_at", "<=", $date . " 23:59:59"]
                ])->count();
            else
                $canceledCount = Model::where([
                    "id_shop" => $id_shop,
                    "order_status" => 5,
                    ["created_at", ">=", $date . " 00:00:00"],
                    ["created_at", "<=", $date . " 23:59:59"]
                ])->count();

            if ($id_shop == -1)
                $deliveredCount = Model::where([
                    "order_status" => 4,
                    ["created_at", ">=", $date . " 00:00:00"],
                    ["created_at", "<=", $date . " 23:59:59"]
                ])->count();
            else
                $deliveredCount = Model::where([
                    "id_shop" => $id_shop,
                    "order_status" => 4,
                    ["created_at", ">=", $date . " 00:00:00"],
                    ["created_at", "<=", $date . " 23:59:59"]
                ])->count();

            $canceled[] = ["time" => date("m-d", strtotime($date)), "value" => $canceledCount, "type" => 'Canceled'];
            $delivered[] = ["time" => date("m-d", strtotime($date)), "count" => $deliveredCount, "name" => 'Delivered'];
        }

        return $this->successResponse("success", [
            $canceled,
            $delivered
        ]);
    }

    public function getShopsSalesInfo()
    {
        $id_shop = Admin::getUserShopId();

        $defaultLanguage = Languages::where("default", 1)->first();

        $data = [];
        if ($id_shop == -1)
            $ordersData = Model::groupBy("id_shop")->with(
                [
                    "shop.language" => function ($query) use ($defaultLanguage) {
                        $query->id_lang = $defaultLanguage->id;
                    }
                ]
            )->selectRaw('*, sum(total_sum) as totalSum')->get();
        else
            $ordersData = Model::groupBy("id_shop")->with(
                [
                    "shop.language" => function ($query) use ($defaultLanguage) {
                        $query->id_lang = $defaultLanguage->id;
                    }
                ]
            )
                ->where("id_shop", $id_shop)
                ->selectRaw('*, sum(total_sum) as totalSum')->get();

        foreach ($ordersData as $order) {
            $data[] = [
                "shop" => $order['shop']['language']['name'],
                "value" => $order['totalSum']
            ];
        }

        return $this->successResponse("success", $data);
    }

    public function getOrderForDeliveryBoy($collection = [])
    {
        $where = [
            "id_delivery_boy" => $collection['id_delivery_boy']
        ];

        if ($collection['status'] < 5) {
            $where["order_status"] = $collection['status'];
        }

        $order = Model::with([
            "shop.language" => function ($query) use ($collection) {
                $query->id_lang = $collection['id_lang'];
            },
            "timeUnit",
            "details",
            "clients",
            "address",
            "deliveryBoy",
            "details.product.language" => function ($query) use ($collection) {
                $query->id_lang = $collection['id_lang'];
            },
            "details.product.images"
        ])->whereHas(
            "deliveryBoyOrder", function ($query) use ($collection) {
            $status = 0;
            if ($collection['status'] >= 1 && $collection['status'] < 5) $status = 1;
            else if ($collection['status'] == 5) $status = 2;

            $query->where([
                "admin_id" => $collection['id_delivery_boy'],
                "status" => $status
            ]);
        })
            ->where($where)
            ->skip($collection['offset'])
            ->take($collection['limit'])
            ->get();

        return $this->successResponse("success", $order);
    }

    public function getDeliveryBoyStatistics($id_delivery_boy)
    {
        $newOrder = Model::where([
            "id_delivery_boy" => $id_delivery_boy,
            "order_status" => 1
        ])
            ->count();
        $acceptedOrder = Model::where([
            "id_delivery_boy" => $id_delivery_boy,
            "order_status" => 2
        ])
            ->count();
        $onAWayOrder = Model::where([
            "id_delivery_boy" => $id_delivery_boy,
            "order_status" => 3
        ])
            ->count();
        $deliveredOrder = Model::where([
            "id_delivery_boy" => $id_delivery_boy,
            "order_status" => 4
        ])
            ->count();
        $cancelOrder = Model::where([
            "id_delivery_boy" => $id_delivery_boy,
        ])->whereHas(
            "deliveryBoyOrder", function ($query) use ($id_delivery_boy) {
            $query->where([
                "admin_id" => $id_delivery_boy,
                "status" => 2
            ]);
        })
            ->count();

        return $this->successResponse("success", [
            'new' => $newOrder,
            'accepted' => $acceptedOrder,
            'onaway' => $onAWayOrder,
            'delivered' => $deliveredOrder,
            'cancel' => $cancelOrder,
            'measure' => max([$newOrder, $acceptedOrder, $onAWayOrder, $deliveredOrder, $cancelOrder]),
            'deliveredPercentage' => $cancelOrder == 0 ? 100 : intval(($deliveredOrder * 100) / ($cancelOrder + $deliveredOrder))
        ]);
    }

    public function deliveryBoyOrderStatus($order_id, $admin_id, $status)
    {
        $result = DeliveryBoyOrder::where(['order_id' => $order_id, 'status' => 1])->first();
        if ($result) {
            return $this->errorResponse('Order already accepted');
        }
        $deliveryStatus = DeliveryBoyOrder::where(['order_id' => $order_id, 'admin_id' => $admin_id])->first();

        if ($deliveryStatus) {
            $deliveryStatus->update(['status' => $status]);
            return $this->successResponse('Success', $deliveryStatus);
        }

        return $this->errorResponse('Record not found');
    }


    /**
     * Refund order Transaction and cancel Order
     */
    public function refundOrderTransaction($array = [])
    {
        $order = $this->startCondition()->find($array['id']);

        if($order->order_status != 5){
            if ($order->transaction) {
                $order->transaction()->update(['status' => 3, 'status_description' => 'Canceled', 'refund_time' => now()]);
                if ($order->transaction->payment_sys_id == 99) {
                    $order->clients->balance()->update(['balance' => $order->clients->balance->balance + $order->total_sum ]);
                }
            }
            $order->update(['order_status' => 5, 'cancel_date' => now()]);
        }  else {
            return $this->errorResponse('Order already canceled');
        }
        return $this->successResponse('Order', $order);
    }

    /**
     * Return products by ID for Mobile before add to Cart.
     */
    public function checkoutForRest($array = [])
    {
        $products = $this->product->with([
            'actualDiscount', 'extras.extras',
            'extras.extras' => function ($q) {
                $q->where('active', 1);
            },
            'taxes' => function ($q) {
                $q->where('active', 1);
            },
        ])->whereIn('id', $array['products'])->get();

        $products = $products->map(function ($item){
            return collect($item)->merge([
                'price' => $item->commission_price,
                'origin_price' => $item->price,
                'commission' => $item->commission
            ]);
        });

        return $this->successResponse('Success', $products);
    }

    public function getDeliveryPayoutHistory($array = [])
    {
        $length = $array['length'] ?? null;
        $start = $array['start'] ?? 0;

        $histories = DeliveryPayoutHistory::when(isset($length), function ($q) use ($length, $start) {
                $q->take($length)->skip($start);
            })->where('admin_id', $array['delivery_boy_id'])->latest()->get();

        return $this->successResponse('Delivery payouts history list', $histories);
    }

    /**
     * Check product quantity in stock and return for Order
     */
    private function setOrderProducts($array = [], $orderProducts = [])
    {
        if (isset($array) && count($array) > 0) {
            $productsId = [];
            foreach ($array as $product) {
                array_push($productsId, [$product['id']]);
            }
            $products = $this->product
                ->whereIn('id', $productsId)
                ->select('id', 'quantity', 'price', 'id_category', 'id_shop')->get();

            if (count($products) > 0) {
                $products->map(function ($product) use ($array, $orderProducts) {
                    foreach ($array as $item) {
                        if ($product->id == $item['id']) {
                            if (!$product->is_replaced && $product->quantity < $item['quantity'] && (count($orderProducts) > 0 && !in_array($item['id'], $orderProducts->toArray()))) {
                                    $product->price = 0;
                                    $product->message = "Not enough products in stock";
                                    $product->tag = true;
                            } else {
                                $product->quantity = (int)$item['quantity'];
                                $product->discount = $item['discount'] ?? 0;
                                $product->extras = $item['extras'] ?? [];
                                $product->commission;
                            }
                            $product->is_replaced = $item['is_replaced'] ?? 0;
                            $product->id_replace_product = $item['id_replace_product'] ?? null;

                            if ($product->is_replaced) {
                                $product->price = 0;
                                $product->discount = 0;
                                $product->quantity = 0;
                            }
                        }
                    }
                });
            }

            // Check products in stock and send MissedProducts
            $missed = collect();
            foreach ($products as $product){
                if (!$product->is_replaced && $product->quantity == 0) {
                    $missed = $missed->push($product);
                }

            }
            return count($missed) > 0 ? $missed : $products;
        } else {
            return false;
        }
    }

    /**
     * Set quantity of Product Model before deleting unnecessary Order products
     */
    private function setOrderDeleteProducts(Model $order, $ids)
    {
        $deleted = $order->details()->whereNotIn('id_product', $ids)->get();
        if (count($deleted) > 0) {
            foreach ($deleted as $delete) {
                $product = $this->product->find($delete->id_product);
                $product->update(['quantity' => $product->quantity + $delete->quantity]);
                $delete->delete();
            }
        }
        return true;
    }

    /**
     * Set and save Order products details to 'order_details'
     */
    private function setOrderProductDetails($order, $collections)
    {
        $productIds = [];
        foreach ($collections as $product) {

            $productDetail = $order->details()->where('id_product', $product->id)->first();

            $detail = $order->details()->updateOrCreate(['id_product' => $product->id ?? null], [
                "quantity" => $product->quantity,
                "discount" => $product->discount,
                "price" => $product->commission_price,
                "origin_price" => $product->price,
                "is_replaced" => $product->is_replaced,
                "id_replace_product" => $product->id_replace_product,
            ]);
            array_push($productIds, $product->id);

            if ($detail) {
                $detail->extras()->delete();
                if (count($product["extras"]) > 0) {
                    foreach($product["extras"] as $extra) {
                        $detail->extras()->create([
                            'id_extras' => $extra["id"],
                            'price' => $extra['price'],
                            'id_extras_group' => $extra['extras_group_id'] ?? null
                        ]);
                    }
                }
            }

            // Set Product Model quantity
            if (!$productDetail) {
                $prod = $this->product->find($detail->id_product);
                $prod->update(['quantity' => $prod->quantity - $detail->quantity]);
            } else {
                if ($product->is_replaced) {
                    $qty = $productDetail->quantity;
                    $prod = $this->product->find($detail->id_product);
                    $prod->update(['quantity' => $prod->quantity + $qty]);
                    $productDetail->update(['quantity' => 0]);
                } else {
                    if ($productDetail->quantity > $product->quantity) {
                        $qty = $productDetail->quantity - $product->quantity;
                        $prod = $this->product->find($detail->id_product);
                        $prod->update(['quantity' => $prod->quantity + $qty]);

                    } elseif ($productDetail->quantity < $product->quantity) {
                        $qty = $product->quantity - $productDetail->quantity;
                        $prod = $this->product->find($detail->id_product);
                        $prod->update(['quantity' => $prod->quantity - $qty]);
                    }
                }

            }
        }
        return $productIds;
    }

    /**
     * Check coupon amount for order
     * @param $collection
     * @param $order
     * @return mixed
     */
    private function checkCoupon($collection, $order)
    {
        if (isset($collection['coupon']) && is_string($collection['coupon'])) {
            // check Coupon and calculate it with Order price
            $orderCoupon = $order->coupon()->first();
            if (!$orderCoupon) {
                $coupon = Coupon::CheckCoupon($collection['coupon'])->first();
                if ($coupon && $order->total_sum > $coupon['discount']) {
                    $summa = $order->total_sum - $coupon['discount'];
                    $coupon->update(['usage_time' => $coupon->usage_time - 1]);
                    $coupon->details()->updateOrCreate(['order_id' => $order->id], [
                        'used_time' => $order->created_at,
                        'client_id' => $collection["id_user"],
                    ]);
                    $order->update(['total_sum' => $summa, 'coupon_amount' => $coupon['discount']]);
                }
            }
        }
        return $collection;
    }
}
