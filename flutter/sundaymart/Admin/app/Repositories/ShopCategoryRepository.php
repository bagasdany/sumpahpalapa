<?php

namespace App\Repositories;

use App\Models\Languages;
use App\Models\ShopCategories;
use App\Models\ShopCategories as Model;
use App\Models\ShopCategoriesLanguage;
use App\Repositories\Interfaces\ShopCategoryInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class ShopCategoryRepository extends CoreRepository implements ShopCategoryInterface
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

    public function createOrUpdate($collection = [])
    {
        try {
            $shopCategories = Model::updateOrCreate([
                "id" => $collection["id"]
            ], [
                "active" => $collection["active"]
            ]);

            if ($shopCategories) {
                if ($collection['id'] > 0)
                    ShopCategoriesLanguage::where("id_shop_category", $collection['id'])->delete();

                $shop_category_id = $shopCategories->id;
                foreach ($collection["name"] as $key => $value) {
                    $language = Languages::where("short_name", $key)->first();

                    ShopCategoriesLanguage::updateOrCreate([
                        "id_shop_category" => $collection["id"],
                        "id_lang" => $language->id
                    ], [
                        "name" => $value,
                        "id_shop_category" => $shop_category_id,
                        "id_lang" => $language->id]);
                }
            }

            return $this->successResponse("success", []);
        } catch (\Exception $e) {
            return $this->errorResponse($e->getMessage());
        }
    }

    public function get($id)
    {
        $defaultLanguage = Languages::where("default", 1)->first();

        $shopCategories = ShopCategories::with([
            "languages" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
            "languages.language"
        ])->where("id", $id)->first();

        return $this->successResponse("Success", $shopCategories);
    }

    public function delete($id)
    {
        Model::findOrFail($id)->delete();

        return $this->successResponse("Success", []);
    }

    public function active()
    {
        $defaultLanguage = Languages::where("default", 1)->first();

        $whereQuery = [
            'active' => 1
        ];

        $categories = Model::select("id")
            ->with([
                "language" => function ($query) use ($defaultLanguage) {
                    $query->id_lang = $defaultLanguage->id;
                }
            ])
            ->where($whereQuery)
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

    public function datatable($collection = [])
    {
        $totalData = ShopCategories::count();
        $filteredData = $totalData;
        $responseData = [];

        $defaultLanguage = Languages::where("default", 1)->first();

        $datas = Model::with([
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])
            ->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->language->name;
                $nestedData['active'] = $data->active;
                $nestedData['options'] = [
                    'delete' => 1,
                    'edit' => 1
                ];
                $responseData[] = $nestedData;
            }
        }

        return $this->responseJsonDatatable($totalData, $filteredData, $responseData);
    }
}
