<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\BrandCategories;
use App\Models\Brands as Model;
use App\Models\Languages;
use App\Models\Products;
use App\Repositories\Interfaces\BrandInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class BrandRepository extends CoreRepository implements BrandInterface
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

    public function delete($id)
    {
        Model::find($id)->delete();

        return $this->successResponse("success", []);
    }

    public function createOrUpdate($collection = [])
    {
        Model::updateOrCreate([
            "id" => $collection["id"]
        ], [
            "name" => $collection['name'],
            "image_url" => $collection['image_path'],
            "active" => $collection['active'],
            "id_shop" => $collection['shop_id'],
            "id_brand_category" => $collection['id_brand_category']
        ]);


        return $this->successResponse("success", []);
    }

    public function get($id_brand)
    {
        $brand = Model::findOrFail($id_brand);

        return $this->successResponse("success", $brand);
    }

    public function getBrandCategoriesForRest($id_shop, $id_lang)
    {
        $brand_categories = BrandCategories::with([
            "language" => function ($query) use ($id_lang) {
                $query->id_lang = $id_lang;
            },
        ])->whereHas("brands", function ($query) use ($id_shop) {
            $query->where("id_shop", $id_shop);
        })->get();

        return $this->successResponse("success", $brand_categories);
    }

    public function getBrandProductsForRest($collection = [])
    {
        $whereQuery = [
            "id_brand" => $collection['id_brand'],
            ["price", ">=", $collection['min_price']],
            ["price", "<=", $collection['max_price']],
        ];

        $products = Products::with([
            "category.taxes",
            "images",
            "units.language" => function ($query) use ($collection) {
                $query->id_lang = $collection['id_lang'];
            },
            "actualDiscount",
            "coupon",
            "language" => function ($query) use ($collection) {
                $query->where([
                    'id_lang' => $collection['id_lang'],
                    ['name', '!=', null]
                ]);
                $query->orWhere([
                    ['name', '!=', null]
                ]);
            },
        ])
            ->where('quantity', '>', 0)
            ->withCount([
                "comments" => function ($query) {
                    $query->active = 1;
                }
            ])
            ->withSum("comments", "star")
            ->whereHas("language", function ($query) use ($collection) {
                if (strlen($collection['search']) >= 3) {
                    $query->where("name", "like", "%" . $collection['search'] . "%");
                }
            })
            ->where($whereQuery)
            ->orderBy("price", $collection['sort_type'] == 0 ? "asc" : "desc")
            ->skip($collection['offset'])
            ->take($collection['limit'])
            ->get();

        $products = $products->map(function ($item) {
            $rate = $this->getShopCurrencyRate();
            $item->price = $item->price * $rate;

            return collect($item)->merge([
                'price' => $item->commission_price,
                'origin_price' => $item->price,
                'commission' => $item->commission
            ]);
        });

        return $this->successResponse("success", $products);
    }

    public function getBrandsForRest($collection = [])
    {
        $brands = Model::select("brands.id", "brands.name", "brands.image_url")
            ->where('brands.active', 1)
            ->where('brands.id_shop', $collection['id_shop']);
        if ($collection['id_brand_category'] > 0)
            $brands = $brands->where('brands.id_brand_category', $collection['id_brand_category']);

        if ($collection['limit'] > 0)
            $brands = $brands
                ->offset($collection['offset'])
                ->limit($collection['limit']);

        $brands = $brands->get();

        return $this->successResponse("success", $brands);
    }

    public function active($shop_id)
    {
        $brand = Model::where([
            'id_shop' => $shop_id,
            'active' => 1
        ])->get();

        return $this->successResponse("success", $brand);
    }

    public function datatable($collection = [])
    {
        $shop_id = Admin::getUserShopId();
        if ($shop_id == -1) {
            $totalData = Model::where("active", '>=', 0);
            if (isset($collection['shop_id']))
                $totalData = $totalData->where("id_shop", $collection['shop_id']);

            if (isset($collection['brand_category_id']))
                $totalData = $totalData->where("id_brand_category", $collection['brand_category_id']);

            $totalData = $totalData->count();
        } else {
            $totalData = Model::where("id", $shop_id);
            if (isset($collection['shop_id']))
                $totalData = $totalData->where("id", $collection['shop_id']);

            if (isset($collection['brand_category_id']))
                $totalData = $totalData->where("id_brand_category", $collection['brand_category_id']);

            $totalData = $totalData->count();
        }

        $totalFiltered = $totalData;

        $defaultLanguage = Languages::where("default", 1)->first();

        $datas = Model::with([
            "category.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
            "shop.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ]);

        if ($shop_id > 0) {
            $datas = $datas->where('id_shop', $shop_id);
        }

        if (isset($collection['shop_id'])) {
            $datas = $datas->where('id_shop', $collection['shop_id']);
        }

        if (isset($collection['brand_category_id']))
            $datas = $datas->where("id_brand_category", $collection['brand_category_id']);

        $datas = $datas->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->name;
                $nestedData['shop'] = $data->shop->language->name;
                $nestedData['image_url'] = $data->image_url;
                $nestedData['active'] = $data->active;
                $nestedData['brand_category_name'] = $data->category->language->name;
                $nestedData['options'] = [
                    'delete' => 1,
                    'edit' => 1
                ];
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }
}
