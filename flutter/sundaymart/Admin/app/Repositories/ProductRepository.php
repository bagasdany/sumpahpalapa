<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\Languages;
use App\Models\Orders;
use App\Models\OrdersDetail;
use App\Models\Products;
use App\Models\Products as Model;
use App\Models\ProductsComment;
use App\Models\ProductsImages;
use App\Models\ProductsLanguage;
use App\Models\ShopsCurriencies;
use App\Repositories\Interfaces\ProductInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;
use DB;
use Symfony\Component\Process\Process;

class ProductRepository extends CoreRepository implements ProductInterface
{
    use ApiResponse;
    use DatatableResponse;

    public function __construct()
    {
        parent::__construct();
    }

    protected function getModelClass()
    {
        return Model::class;
    }

    public function delete($id)
    {
        if (is_array($id)) {
            Model::whereIn("id", $id)->delete();
        } else {
            Model::find($id)->delete();
        }

        return $this->successResponse("success", []);
    }

    public function createOrUpdate($collection = [])
    {
        try {
            $product = Model::updateOrCreate([
                "id" => $collection["id"]
            ], [
                "quantity" => $collection['quantity'],
                "pack_quantity" => $collection['package_count'],
                "price" => $collection['price'],
                "show_type" => $collection['feature_type'],
                "active" => $collection['active'],
                "id_unit" => $collection['unit'],
                "id_category" => $collection['category_id'],
                "id_shop" => $collection['shop_id'],
                "id_brand" => $collection['brand_id'],
            ]);

            if ($product) {
                $product_id = $product->id;
                foreach ($collection['names'] as $key => $value) {
                    $language = Languages::where("short_name", $key)->first();

                    ProductsLanguage::updateOrCreate([
                        "id_product" => $product_id,
                        "id_lang" => $language->id
                    ], [
                        "name" => $value,
                        "description" => $collection['descriptions'][$key],
                        "id_product" => $product_id,
                        "id_lang" => $language->id,
                    ]);
                }

                ProductsImages::where("id_product", $product_id)->delete();

                foreach ($collection['images'] as $key => $image) {
                    ProductsImages::create([
                        "image_url" => $image['name'],
                        "id_product" => $product_id,
                        "main" => $key == 0 ? 1 : 0,
                    ]);
                }
            }

            return $this->successResponse("success", []);
        } catch (\Exception $e) {
            return $this->errorResponse($e->getMessage());
        }
    }

    public function get($id_product)
    {
        $lang = Languages::whereDefault(1)->first();

        $product = $this->startCondition()->with([
            "languages.language",
            "taxes",
            "images",
            "extras.language" => function ($query) use ($lang) {
                $query->where('id_lang', $lang->id);
            },
            "extras.extras.language" => function ($query) use ($lang) {
                $query->where('id_lang', $lang->id);
            },
        ])
            ->where("id", $id_product)
            ->first();

        return $this->responseProductShow($product);
    }

    public function saveProductComment($collection = [])
    {
        $comment = ProductsComment::updateOrCreate([
            'id_product' => $collection['id_product'],
            'id_user' => $collection['id_user'],
        ], [
            'comment_text' => $collection['comment'],
            'star' => $collection['star'],
            'id_user' => $collection['id_user'],
            'id_product' => $collection['id_product'],
            'active' => 1
        ]);

        if ($comment) {
            $product = Model::withCount([
                "comments" => function ($query) {
                    $query->active = 1;
                }
            ])
                ->withSum("comments", "star")
                ->where([
                    'id' => $collection['id_product'],
                ])->first();

            return $this->successResponse("success", $product);
        }

        return $this->errorResponse("error");
    }

    public function getProductExtrasForRest($id_product, $id_lang)
    {
        $data = Model::where("id", $id_product)
            ->with([
                "actualDiscount",
                "comments" => function ($query) {
                    $query->take(10)->skip(0);
                    $query->orderBy("star");
                },
                "comments.user",
                "description.language" => function ($query) use ($id_lang) {
                    $query->id_lang = $id_lang;
                },
                "extras" => function ($query) {
                    $query->active = 1;
                },
                "extras.extras" => function ($query) {
                    $query->active = 1;
                },
                "extras.language" => function ($query) use ($id_lang) {
                    $query->id_lang = $id_lang;
                },
                "extras.extras.language" => function ($query) use ($id_lang) {
                    $query->id_lang = $id_lang;
                },
            ])
            ->where('quantity', '>', 0)
            ->withCount([
                "comments" => function ($query) {
                    $query->active = 1;
                }
            ])
            ->first();

        return $this->responseProductShow($data);
    }

    public function datatable($collection = [])
    {
        $shop_id = Admin::getUserShopId();
        if ($shop_id == -1) {
            $totalData = Model::where("active", '>', -1);
        } else {
            $totalData = Model::where("id_shop", $shop_id);
        }

        if (isset($collection['brand_id']) && $collection['brand_id'] > 0) {
            $totalData = $totalData->where('id_brand', $collection['brand_id']);
        }

        if (isset($collection['category_id']) && $collection['category_id'] > 0) {
            $totalData = $totalData->where('id_category', $collection['category_id']);
        }

        if (isset($collection['search']) && strlen($collection['search']) > 0) {
            $totalData = $totalData->whereHas(
                "language", function ($query) use ($collection) {
                $query->where('name', 'LIKE', "%{$collection['search']}%")
                    ->orWhere('description', 'LIKE', "%{$collection['search']}%");
            }
            );
        }

        $totalData = $totalData->count();
        $totalFiltered = $totalData;

        $defaultLanguage = Languages::where("default", 1)->first();

        $shop_id = Admin::getUserShopId();

        $datas = Model::with([
            "actualDiscount",
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
            "category.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
            "shop.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
            "images",
            "brands",
        ]);

        if (isset($collection['shop_id']) && $collection['shop_id'] > 0) {
            $shop_id = $collection['shop_id'];
        }

        if ($shop_id != -1) {
            $datas = $datas->where('id_shop', $shop_id);
        }

        if (isset($collection['brand_id']) && $collection['brand_id'] > 0) {
            $datas = $datas->where('id_brand', $collection['brand_id']);
        }

        if (isset($collection['category_id']) && $collection['category_id'] > 0) {
            $datas = $datas->where('id_category', $collection['category_id']);
        }

        if (isset($collection['search']) && strlen($collection['search']) > 0) {
            $datas = $datas->whereHas(
                "language", function ($query) use ($collection) {
                $query->where('name', 'LIKE', "%{$collection['search']}%")
                    ->orWhere('description', 'LIKE', "%{$collection['search']}%");
            }
            );
        }

        $datas = $datas->skip($collection['start'])
            ->take($collection['length'])
            ->orderBy("id", "desc")
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['name'] = mb_convert_encoding(substr($data->language->name, 0, 50), 'UTF-8', 'UTF-8') . (strlen($data->language->name) > 50 ? "..." : "");
                $nestedData['description'] = $data->language->description;
                $nestedData['image_url'] = count($data->images) > 0 ? $data->images[0]->image_url : "";
                $nestedData['shop'] = $data->shop->language->name;
                $nestedData['category'] = $data->category->language->name;
                $nestedData['brand'] = $data->brands->name;
                $nestedData['amount'] = $data->quantity;
                $nestedData['price'] = $data->commission_price;
                $nestedData['show_type'] = $data->show_type;
                $nestedData['active'] = $data->active;
                $nestedData['taxes'] = $data->category->taxes;
                $nestedData['actual_discount'] = $data->actualDiscount;
                $nestedData['origin_price'] = $data->price;
                $nestedData['commission'] = $data->commission;
                $nestedData['options'] = [
                    'delete' => 1,
                    'edit' => 1
                ];
                $responseData[] = $nestedData;
            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function deleteComment($id)
    {
        ProductsComment::find($id)->delete();

        return $this->successResponse("success", []);
    }

    public function datatableComment($collection = [])
    {
        $totalData = ProductsComment::count();
        $totalFiltered = $totalData;

//        $defaultLanguage = Languages::where("default", 1)->first();
//
//        $datas = ProductsComment::select('products_comments.*', 'products_language.name as product_name', 'clients.name', 'clients.surname')
//            ->join('products_language', 'products_language.id_product', '=', 'products_comments.id_product')
//            ->join('clients', 'clients.id', '=', 'products_comments.id_user')
//            ->where('products_language.id_lang', $defaultLanguage->id)
//            ->skip($collection['start'])
//            ->take($collection['length'])
//            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['client'] = $data->name . " " . $data->surname;
                $nestedData['product'] = $data->product_name;
                $nestedData['text'] = $data->comment_text;
                $nestedData['star'] = $data->star;
                $nestedData['active'] = $data->active;
                $nestedData['options'] = [
                    'delete' => 1,
                ];
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function active($shop_id)
    {
        $defaultLanguage = Languages::where("default", 1)->first();

        $products = Model::with([
            "taxes",
            "actualDiscount",
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])
            ->where("id_shop", $shop_id)
            ->get();

        $data = [];
        foreach ($products as $product) {
            $rate = $this->getShopCurrencyRate();
            $product->price =  $product->price * $rate;

            $data[] = [
                "id" => $product->id,
                "name" => $product->language->name,
                "price" => $product->commission_price,
                "quantity" => $product->quantity,
                "discount_amount" => $product->discount ? $product->discount->discount_amount : 0,
                "taxes" => $product->taxes,
                "discount" => $product->actualDiscount,
                'origin_price' => $product->price,
                'commission' => $product->commission
            ];
        }

        return $this->successResponse("success", $data);
    }

    public function getProductCount()
    {
        $shop_id = Admin::getUserShopId();
        if ($shop_id == -1)
            $count = Model::count();
        else
            $count = Model::where("id_shop", $shop_id)->count();

        return $this->successResponse("success", $count);
    }

    public function getMostSoldProducts(){

        $orders = Orders::with('details')->where('order_status', 4)
            ->latest('delivered_date')->take(1000)->get();

        // mapping Orders collection and take product id from Order Details.
        $productIds = $orders->map(function ($item){
            return$item->details->map(function ($product){
                 return $product->id_product;
             });
        })->flatten()->toArray();

        // count of the same product id.
        $productIds = array_count_values($productIds);
        // sort by desc of count and take 10 highest keys => it's product id
        $productIds = collect($productIds)->sortDesc()->take(10)->keys();

        // Take most popular products with relation "language"
        $products = Products::with([
            'language' => function($q){
            $q->where('id_lang', $this->defaultLanguage());
        }])->whereIn('id', $productIds)->latest()->get();

        return $this->successResponse("success", $products);
    }

    /**
     * @param $product
     * @return \Illuminate\Http\JsonResponse
     */
    private function responseProductShow($product)
    {
       $rate = $this->getShopCurrencyRate();
       $product->price = $product->price * $rate;

        if ($product->actualDiscount) {
            if ($product->actualDiscount->discount_type == 1) {
                $discount = ($product->price / 100) * $product->actualDiscount->discount_amount;
            } else {
                $discount = $product->actualDiscount->discount_amount;
            }
        }

        $product = collect($product)->merge([
            'price' => round($product->commission_price,2),
            'discount_price' => isset($discount) ? round($discount, 2) : 0,
            'origin_price' => round($product->price, 2),
            'commission' => round($product->commission, 2)
        ]);

        return $this->successResponse("success", $product);
    }
}
