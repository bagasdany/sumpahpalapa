<?php

namespace App\Repositories;

use App\Models\Languages;
use App\Models\ProductsCharacterics as Model;
use App\Models\ProductsCharactericsLanguage;
use App\Repositories\Interfaces\PrivacyInterface;
use App\Repositories\Interfaces\ProductCharactericsInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class ProductCharactericsRepository extends CoreRepository implements ProductCharactericsInterface
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

        return $this->successResponse("success");
    }

    public function get($id)
    {
        $products_characterics = Model::with([
            "languages.language"
        ])->where("id", $id)->first();

        return $this->successResponse("success", $products_characterics);
    }

    public function createOrUpdate($collection = [])
    {
        $products_characterics = Model::updateOrCreate([
            "id" => $collection["id"]
        ], [
            "id_product" => $collection["id_product"],
            "active" => $collection["active"]
        ]);

        if ($products_characterics) {
            $products_characterics_id = $products_characterics->id;

            foreach ($collection["value"] as $k => $v) {
                $language = Languages::where("short_name", $k)->first();

                ProductsCharactericsLanguage::updateOrCreate([
                    "id_product_characteristic" => $products_characterics_id,
                    "id_lang" => $language->id
                ], [
                    "id_product_characteristic" => $products_characterics_id,
                    "id_lang" => $language->id,
                    "key" => $collection["key"][$k],
                    "value" => $v
                ]);

            }

            return $this->successResponse("success");
        }

        return $this->errorResponse("error");
    }

    public function datatable($collection = [])
    {
        $totalData = Model::where("id_product", $collection["id_product"])->count();
        $totalFiltered = $totalData;

        $defaultLanguage = Languages::where("default", 1)->first();

        $datas = Model::with([
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])
            ->where('id_product', $collection['id_product'])
            ->skip($collection["start"])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['active'] = $data->active;
                $nestedData['key'] = $data->language->key;
                $nestedData['value'] = $data->language->value;
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
