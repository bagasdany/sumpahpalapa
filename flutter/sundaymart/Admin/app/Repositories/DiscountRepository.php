<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\DiscountProducts;
use App\Models\Languages;
use App\Repositories\Interfaces\DiscountInterface;
use App\Models\Discount as Model;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class DiscountRepository extends CoreRepository implements DiscountInterface
{
    use ApiResponse;
    use DatatableResponse;

    public function __construct()
    {
        parent::__construct();
    }

    protected function getModelClass()
    {
        $this->model = Model::class;
    }

    public function getDiscountProducts($collection = [])
    {
        $products = DiscountProducts::whereHas('product', function ($q) {
            $q->where('quantity', '>', 0);
        })->with([
            "product.actualDiscount",
            "product" => function ($query) {
                $query->where('active', 1);
            },
            "product.taxes" => function ($query) {
                $query->where('active', 1);
            },
            "product.images",
            "product.units.language" => function ($query) use ($collection) {
                $query->id_lang = $collection['id_lang'];
            },
            "product.language" => function ($query) use ($collection) {
                $query->where([
                    'id_lang' => $collection['id_lang'],
                    ['name', '!=', null]
                ]);
                $query->orWhere([
                    ['name', '!=', null]
                ]);
            },
        ])
            ->withCount([
                "comments" => function ($query) {
                    $query->where('active', 1);
                }
            ])
            ->withSum("comments", "star")
            ->skip($collection['offset'])
            ->take($collection['limit'])
            ->get();

        $products = $products->map(function ($item){
            if ($item->product) {
                $rate = $this->getShopCurrencyRate();
                $item->product->price = $item->product->price*$rate;
                collect($item->product)->merge([
                    'price' => $item->product->commission_price,
                    'origin_price' => $item->product->price,
                    'commission' => $item->product->commission
                ]);
            }
            return $item;
        });

        return $this->successResponse("success", $products);
    }

    public function delete($id)
    {
        Model::find($id)->delete();

        return $this->successResponse("success");
    }

    public function get($id)
    {
        $defaultLanguage = Languages::where("default", 1)->first();

        $discount = Model::with([
            "products.product.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])->where("id", $id)
            ->first();

        return $this->successResponse("success", $discount);
    }

    public function datatable($collection = [])
    {
        $shop_id = Admin::getUserShopId();

        if ($shop_id == -1)
            $totalData = Model::count();
        else
            $totalData = Model::where("id_shop", $shop_id)->count();

        $totalFiltered = $totalData;

        $defaultLanguage = Languages::where("default", 1)->first();

        $datas = Model::with([
            "shop.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])->where("active", 1);

        if ($shop_id != -1)
            $datas = $datas->where("id_shop", $shop_id);

        $datas = $datas->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['is_count_down'] = $data->is_count_down;
                $nestedData['discount_type'] = $data->discount_type;
                $nestedData['discount_amount'] = $data->discount_amount;
                $nestedData['start_time'] = $data->start_time;
                $nestedData['end_time'] = $data->end_time;
                $nestedData['active'] = $data->active;
                $nestedData['shop_name'] = $data->shop_name;
                $nestedData['options'] = [
                    'delete' => 1,
                    'edit' => 1
                ];
                $responseData[] = $nestedData;
            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function createOrUpdate($collection = [])
    {
        $discount = Model::updateOrCreate([
            "id" => $collection["id"]
        ], [
            "is_count_down" => $collection["is_count_down"],
            "discount_type" => $collection["discount_type"],
            "discount_amount" => $collection["discount_amount"],
            "start_time" => $collection["start_time"] ?? now(),
            "end_time" => $collection["end_time"] ?? now()->addCentury(),
            "active" => $collection["active"] ?? 0,
            "id_shop" => $collection["id_shop"]
        ]);

        if ($discount) {
            $discount_id = $discount->id;

            DiscountProducts::where('id_discount', $discount_id)->delete();

            foreach ($collection['product_ids'] as $product_id) {
                DiscountProducts::create([
                    "id_product" => $product_id,
                    "id_discount" => $discount_id
                ]);
            }
        }

        return $this->successResponse("success");
    }
}
