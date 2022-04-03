<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\CouponLanguage;
use App\Models\CouponProducts;
use App\Models\Languages;
use App\Models\Coupon as Model;
use App\Models\Products;
use App\Repositories\Interfaces\CouponInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class CouponRepository extends CoreRepository implements CouponInterface
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

    public function get($id)
    {
        $coupon = $this->model->with('languages.language', 'details', 'shop')->find($id);
        if ($coupon) {
            return $this->successResponse("success", $coupon);
        }
        return $this->errorResponse("Coupon not found");
    }

    public function createOrUpdate($collection = [])
    {
        $coupon = Model::updateOrCreate([
            "id" => $collection["id"] ?? null
        ], [
            "name" => $collection["name"],
            "discount_type" => $collection['discount_type'],
            "discount" => $collection["discount"],
            "usage_time" => $collection["usage_time"],
            "valid_until" => date("Y-m-d H:i:s", strtotime($collection["valid"])),
            "active" => $collection["active"] ?? 0,
            "id_shop" => $collection["shop_id"]
        ]);

        if ($coupon) {
            $languages = Languages::select('id', 'short_name')->get();
            foreach ($languages as $lang) {
                $coupon->languages()->updateOrCreate(['id_lang' => $lang->id], [
                    'description' => $collection['description'][$lang->short_name] ?? null,
                ]);
            }
            return $this->successResponse("success", $coupon);
        }

        return $this->errorResponse("Error during save");
    }

    public function delete($id)
    {
        $this->model->find($id)->delete();

        return $this->successResponse("success");
    }

    /* NOt used, should delete */
    public function getCouponProducts($collection = [])
    {

        $products = CouponProducts::whereHas('product', function ($q) {
            $q->where('quantity', '>', 0);
        })->with([
            "coupon" => function ($query) use ($collection) {
                $query->where('active', 1);
                $query->id_shop = $collection['id_shop'];
            },
            "product" => function ($query) {
                $query->where('active', 1);
            },
            "product.actualDiscount",
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

        $products = $products->map(function ($item) {
            if ($item->product) {
                $rate = $this->getShopCurrencyRate();
                $item->product->price = $item->product->price * $rate;
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
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
            "shop.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ]);

        if ($shop_id != -1) {
            $datas = $datas->where('coupon.id_shop', $shop_id);
        }

        $datas = $datas
            ->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->name;
                $nestedData['description'] = $data->language->description;
                $nestedData['shop'] = $data->shop->language->name;
                $nestedData['discount_type'] = $data->discount_type;
                $nestedData['discount'] = $data->discount;
                $nestedData['usage_time'] = $data->usage_time;
                $nestedData['valid_until'] = $data->valid_until;
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

    public function getByName($name)
    {
        $result = $this->startCondition()->checkCoupon($name)->first();
        if ($result) {
            return $this->successResponse('Coupon is active', $result);
        }
        return $this->errorResponse('Coupon is not active');
    }
}
