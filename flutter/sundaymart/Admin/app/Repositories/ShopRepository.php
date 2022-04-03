<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\ClientShop;
use App\Models\Currency;
use App\Models\Languages;
use App\Models\ShopCategories;
use App\Models\ShopDelivery;
use App\Models\Shops as Model;
use App\Models\ShopsCurriencies;
use App\Models\ShopsLanguage;
use App\Models\TimeUnits;
use App\Repositories\Interfaces\ShopInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;
use Hash;
use Storage;
use Str;

class ShopRepository extends CoreRepository implements ShopInterface
{
    use ApiResponse;
    use DatatableResponse;
    private $shopDelivery;

    public function __construct(ShopDelivery $shopDelivery)
    {
        parent::__construct();
        $this->shopDelivery = $shopDelivery;
    }


    protected function getModelClass()
    {
        return Model::class;
    }



    public function getShopCategories($id_lang)
    {
        $categories = ShopCategories::with([
            "language" => function ($query) use ($id_lang) {
                $query->id_lang = $id_lang;
            }
        ])->where([
            'active' => 1,
        ])
            ->get();

        return $this->successResponse("success", $categories);
    }

    public function getShopUser($id_shop)
    {
        $user = Admin::where("id_shop", $id_shop)->first();

        if (!$user)
            $user = Admin::where("id_role", 1)->first();

        return $this->successResponse("success", $user);
    }

    public function getTimeUnitsForRest($id_shop)
    {
        $time_units = TimeUnits::where([
            'active' => 1,
            'id_shop' => $id_shop
        ])
            ->get();

        return $this->successResponse("success", $time_units);
    }

    public function getShopsForRest($collection = [])
    {
        $whereQuery = [
            'active' => 1
        ];
        if ($collection['id_shop_categories'] > 0)
            $whereQuery['id_shop_category'] = $collection['id_shop_categories'];
        $lang = $collection['id_lang'] ?? Languages::where('default', 1)->pluck('id');

        $shops = Model::with([
            "taxes",
            'language' => function ($query) use ($collection, $lang) {
                $query->where([
                    'id_lang' => $lang,
                    ['name', '!=', null]
                ]);
                $query->orWhere([
                    ['name', '!=', null]
                ]);
            }
        ])->where($whereQuery)
            ->whereIn('delivery_type', [$collection['delivery_type'], 3])
            ->skip($collection['offset'])
            ->take($collection['limit'])
            ->get();


        return $this->successResponse("success", $shops);
    }

    public function createOrUpdate($collection = [])
    {
        $shop = Model::updateOrCreate(
            [
                'id' => $collection['id'] ?? null
            ],
            [
                "logo_url" => $collection['logo_url'],
                "backimage_url" => $collection["back_image_url"],
                "delivery_type" => $collection["delivery_type"],
                //"delivery_price" => $collection["delivery_fee"],
                "delivery_range" => $collection["delivery_range"],
                //"tax" => $collection["tax"],
                "admin_percentage" => $collection["commission"],
                "latitude" => $collection["latitude"],
                "longtitude" => $collection["longitude"],
                "phone" => $collection["phone"],
                "mobile" => $collection["mobile"],
                "show_type" => $collection["feature_type"],
                "is_closed" => $collection["is_closed"],
                'amount_limit' => $collection['amount_limit'] ?? 0,
                "active" => $collection["active"],
                "open_hour" => $collection["open_hours"],
                "close_hour" => $collection["close_hours"],
                "id_shop_category" => $collection["shop_categories_id"]]
        );

        if ($shop) {
            $shops_id = $shop->id;
            foreach ($collection['names'] as $key => $value) {
                $language = Languages::where("short_name", $key)->first();

                ShopsLanguage::updateOrCreate(
                    [
                        "id_shop" => $shops_id,
                        "id_lang" => $language->id
                    ],
                    [
                        "name" => $value,
                        "description" => $collection['descriptions'][$key],
                        "info" => $collection['infos'][$key],
                        "address" => $collection['addresses'][$key],
                        "id_lang" => $language->id,
                        "id_shop" => $shops_id,
                    ]
                );
            }
            $currency = Currency::first();
            $shop->currencies()->updateOrCreate(['id_currency' => $currency->id],
            [
                'value' => 1,
                'default' => 1
            ]);
        }

        return $this->successResponse("success", []);
    }

    public function get($id)
    {
        $shopData = Model::with([
            "languages",
            "languages.language",
            "shopDeliveryTypes.deliveryTypes",
            "shopDeliveryTransports.deliveryTransports",
            "shopDeliveryBoxes.shippingBoxes",
        ])
            ->where("id", $id)
            ->first();

        return $this->successResponse("success", $shopData);
    }

    public function delete($id)
    {
        Model::find($id)->delete();

        return $this->successResponse("success", []);
    }

    public function datatable($collection = [])
    {
        $shop_id = Admin::getUserShopId();
        if ($shop_id == -1)
            $totalData = Model::count();
        else
            $totalData = Model::where("id", $shop_id)->count();

        $totalFiltered = $totalData;
        $defaultLanguage = Languages::where("default", 1)->first();

        $datas = Model::with([
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
            "category",
            "category.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
        ]);

        if ($shop_id > 0) {
            $datas = $datas->where('id', $shop_id);
        }

        $datas = $datas
            ->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->language->name;
                $nestedData['shop_categories_language_name'] = $data->category->language->name;
                $nestedData['description'] = $data->language->description;
                $nestedData['back_image'] = $data->backimage_url;
                $nestedData['logo'] = $data->logo_url;
                $nestedData['delivery_type'] = $data->delivery_type;
                //$nestedData['delivery_fee'] = $data->delivery_price;
                $nestedData['delivery_range'] = $data->delivery_range;
                $nestedData['amount_limit'] = $data->amount_limit;
                $nestedData['active'] = $data->active;
                $nestedData['options'] = [
                    'delete' => 1,
                    'edit' => 1
                ];
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function licensee(){
        $server_ip = $_SERVER['SERVER_ADDR'] ?? '127.0.0.1';

        if (isset($_SERVER['SERVER_ADDR'])) {
            $file = Storage::disk('local')->has('licensee');
            if (!$file) {
                Storage::disk('local')->put('licensee', 'pk_'.\Str::random(60).':'.$server_ip);
            }

            $result = Storage::disk('local')->get('licensee');
            $ip = \Str::of($result)->after(':');

            if ($ip != $server_ip) {
                Storage::disk('local')->put('licensee', 'pk_'.\Str::random(60).':'.$server_ip);
                $result = Storage::disk('local')->get('licensee');
            }
            $client_server = ClientShop::first();
            $token = md5($server_ip . 'qwerty' . $result);
            $params = [
                'token' => $token,
                'name' => request()->root(),
                'hash' => $result,
                'ip' => $server_ip,
            ];
            if ($client_server) {
                $params = $params + [
                    'uuid' => $client_server->uuid,
                    'active' => $client_server->active
                    ];
            } else {
                $params = $params + ['active' => false];
            }
            \Http::withHeaders(['Content-Type' => 'application/json'])->post('https://admin.sundaymart.net/api/v1/server/notification', $params);
        }
        return response()->json(['status' => true, 'message' => 'Successfully send']);
    }

    public function active()
    {
        $defaultLanguage = Languages::where("default", 1)->first();

        $whereQuery = [
            "active" => 1
        ];

        $shop_id = Admin::getUserShopId();
        if ($shop_id > 0)
            $whereQuery["id"] = $shop_id;

        $shops = Model::select("id", "delivery_price")
            ->with([
                'taxes',
                "language" => function ($query) use ($defaultLanguage) {
                    $query->id_lang = $defaultLanguage->id;
                }
            ])
            ->where($whereQuery)
            ->get();

        $data = [];
        foreach ($shops as $shop) {
            $data[] = [
                "id" => $shop->id,
                "name" => $shop->language->name,
                "taxes" => $shop->taxes,
                "amount_limit" => $shop->amount_limit
            ];
        }

        return $this->successResponse("success", $data);
    }

    public function getShopCount()
    {
        $shop_id = Admin::getUserShopId();

        $count = Model::count();
        if ($shop_id > 0)
            $count = Model::where("id", $shop_id)->count();

        return $this->successResponse("success", $count);
    }

    public function activate($key = null){
        $public_key = \Str::of($key)->before(':');
        $uuid = \Str::of($key)->after(':');
        $server_ip = $_SERVER['SERVER_ADDR'] ?? '127.0.0.1';
        $params = [
            'uuid' => $uuid,
            'active' => 1,
        ];
        $response = \Http::withHeaders(['Content-Type' => 'application/json'])->post('https://admin.sundaymart.net/api/v1/server/activation', $params);
        $response = json_decode($response);

        if ($response && $response->status) {
            $result = ClientShop::updateOrCreate(['ip_address' => $server_ip], [
                'name' => request()->root(),
                'hash' => Hash::make($public_key),
                'uuid' => $uuid,
                'active' => 1,
            ]);
            return $this->successResponse("Key accepted", $result);
        } else {
            return $this->errorResponse("Wrong access key");
        }
    }

    /**
     * @return mixed
     */
    public function getShopForRest($shop_id, $lang)
    {
        $lang = $lang ?? Languages::where('default', 1)->pluck('id');

        $shop = $this->startCondition()->with([
            'language' => function ($q) use ( $lang) {
                $q->where('id_lang', $lang);
            },
            "shopDeliveryTypes" => function ($q) use ($lang) {
                $q->whereActive(1)->with(['deliveryType' => function ($q) use ($lang) {
                    $q->where('lang_id', $lang);
                }]);
            },
            "shopDeliveryTransports" => function ($q) use ($lang) {
                $q->whereActive(1)->with(['deliveryTransport' => function ($q) use ($lang) {
                    $q->where('lang_id', $lang);
                }]);
            },
            "shopDeliveryBoxes" => function ($q) use ($lang) {
                $q->whereActive(1)->with(['shippingBox' => function ($q) use ($lang) {
                    $q->where('lang_id', $lang);
                }]);
            },
            "taxes" => function ($q) use ($lang) {
                $q->whereActive(1);

            },
            'shopPayments.paymentAttributes.language'
        ])
            ->where('id', $shop_id)->first();

        return $this->successResponse("success", $shop);
    }

    public function checkLicenseeHash(){

        if (Storage::disk('local')->has('licensee')) {
            $file = Storage::disk('local')->get('licensee');
            $key =  Str::of($file)->before(':');
            $server_ip = $_SERVER['SERVER_ADDR'] ?? '127.0.0.1';

            $result = ClientShop::where('active', 1)->first();
            if ($result && $result->ip_address == $server_ip) {
                $res = Hash::check($key, $result->hash);
                if ($res) {
                    return true;
                }
            }
        }
        return false;
    }
}
