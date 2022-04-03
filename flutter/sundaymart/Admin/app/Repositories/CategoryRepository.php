<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\CategoriesLanguage;
use App\Models\Languages;
use App\Models\Products;
use App\Models\Categories as Model;
use App\Models\TaxCategory;
use App\Repositories\Interfaces\CategoryInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class CategoryRepository extends CoreRepository implements CategoryInterface
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
        if (is_array($id)) {
            Model::whereIn("id", $id)->delete();
        } else {
            Model::find($id)->delete();
        }

        return $this->successResponse("success", []);
    }

    public function createOrUpdate($collection = [])
    {
        $category = Model::updateOrCreate([
            "id" => $collection["id"]
        ], [
            "parent" => $collection['parent'],
            "image_url" => $collection['image_path'],
            "active" => $collection["active"],
            "id_shop" => $collection["shop_id"]
        ]);

        if ($category) {
            $category_id = $category->id;
            foreach ($collection['name'] as $key => $value) {
                $language = Languages::where("short_name", $key)->first();

                CategoriesLanguage::updateOrCreate([
                    "id_category" => $category_id,
                    "id_lang" => $language->id
                ], [
                    "name" => $value,
                    "id_category" => $category_id,
                    "id_lang" => $language->id]);
            }
        }

        return $this->successResponse("success", []);
    }

    public function get($id_category)
    {
        $categories = Model::with([
            "languages.language", 'taxes',
        ])
            ->where("id", $id_category)
            ->first();

        return $this->successResponse("success", $categories);
    }

    public function getCategoryProductsForRest($collection = [])
    {
        $whereQuery = [
            "active" => 1,
            ["price", ">=", $collection['min_price']],
            ["price", "<=", $collection['max_price']],
        ];

        if ($collection['type'] != 0 && $collection['type'] != 3)
            $whereQuery['show_type'] = $collection['type'] + 1;

        $products = Products::with(["images",
            "category.taxes",
            "coupon",
            "units.language",
            "actualDiscount",
            "language" => function ($query) use ($collection) {
                $query->where([
                    'id_lang' => $collection['id_lang'],
                    ['name', '!=', null]
                ]);
                $query->orWhere([
                    ['name', '!=', null]
                ]);
            }])
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
            ->where(function ($query) use ($collection) {
                $query->orWhereHas(
                    "category", function ($query) use ($collection) {
                    $query->where("id", $collection['id_category']);
                });
                $query->orWhereHas(
                    "category.parentcategory", function ($query) use ($collection) {
                    $query->where("id", $collection['id_category']);
                });
            })
            ->where($whereQuery);

        if (strlen($collection['brands']) > 0) {
            $products = $products->whereIn("id_brand", explode(",", $collection['brands']));
        }

        $products = $products
            ->skip($collection['offset'])
            ->take($collection['limit'])
            ->orderBy("price", $collection['sort_type'] == 0 ? "asc" : "desc")
            ->get();

        $products = $products->map(function ($item){
            $rate = $this->getShopCurrencyRate();
            $item->price =  $item->price * $rate;

            return collect($item)->merge([
                'price' => $item->commission_price,
                'origin_price' => $item->price,
                'commission' => $item->commission
            ]);
        });

        return $this->successResponse("success", $products);
    }

    public function getCategoriesForRest($collection = [])
    {
        $categories = Model::where([
            "id_shop" => $collection['id_shop'],
            "parent" => $collection['id_category'],
            "active" => 1
        ]);

        if ($collection['id_category'] == -1)
            $categories = $categories->has("subcategories.products");
        else
            $categories = $categories->has("products");

        $categories = $categories->with([
            "taxes",
            "language" => function ($query) use ($collection) {
                $query->where([
                    'id_lang' => $collection['id_lang'],
                    ['name', '!=', null]
                ]);
                $query->orWhere([
                    ['name', '!=', null]
                ]);
            }
        ]);
        if ($collection['limit'] > 0) {
            $categories = $categories->skip($collection['offset'])
                ->take($collection['limit']);
        }
        $categories = $categories->get();

        return $this->successResponse("success", $categories);
    }

    public function datatable($collection = [])
    {
        $shop_id = Admin::getUserShopId();
        if ($shop_id == -1) {
            if (isset($collection['shop_id']))
                $totalData = Model::where("id", $collection['shop_id'])->count();
            else
                $totalData = Model::count();
        } else {
            if (isset($collection['shop_id']))
                $totalData = Model::where("id", $collection['shop_id'])->count();
            else
                $totalData = Model::where("id", $shop_id)->count();
        }

        $totalFiltered = $totalData;

        $defaultLanguage = Languages::where("default", 1)->first();

        $datas = Model::with([
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
            "shop.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
            "parentcategory.language"
        ]);

        if ($shop_id > 0)
            $datas = $datas->where("id_shop", $shop_id);
        if (isset($collection['shop_id']))
            $datas = $datas->where("id_shop", $collection['shop_id']);

        $datas = $datas->skip($collection['start'])
            ->take($collection['length'])
            ->orderBy("categories.id", "desc")
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {

                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->language->name;
                $nestedData['shop'] = $data->shop->language->name;
                if ($data->parentcategory != null) {
                    $nestedData['parent'] = $data->parentcategory->language->name;
                } else
                    $nestedData['parent'] = "-";

                $nestedData['image_url'] = $data->image_url;
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

    public function active($shop_id)
    {
        $defaultLanguage = Languages::where("default", 1)->first();

        $categories = Model::with([
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])
            ->where([
                'active' => 1,
                'id_shop' => $shop_id,
                [
                    "parent", "!=", -1
                ]
            ])
            ->get();

        $categoriesArra = [];

        foreach ($categories as $category) {
            $categoriesArra[] = [
                'id' => $category->id,
                'name' => $category->language->name,
            ];
        }

        return $this->successResponse("success", $categoriesArra);
    }

    public function parent($shop_id)
    {
        $defaultLanguage = Languages::where("default", 1)->first();

        $categories = Model::with([
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])
            ->where([
                'parent' => -1,
                'active' => 1,
                'id_shop' => $shop_id
            ])
            ->get();

        $categoriesArra = [
            [
                'id' => -1,
                'name' => 'No parent'
            ]
        ];

        foreach ($categories as $category) {
            $categoriesArra[] = [
                'id' => $category->id,
                'name' => $category->language->name,
            ];
        }

        return $this->successResponse("success", $categoriesArra);
    }

    public function setCategoryTax($array = [])
    {
        $result = TaxCategory::updateOrCreate(['id' => $array['id'] ?? null],
            [
                'category_id' => $array['category_id'],
                'tax_id' => $array['tax_id']
            ]);

        return $this->successResponse("success", $result);
    }
}
