<?php

namespace App\Repositories;

use App\Models\Languages;
use App\Models\ProductExtras as Model;
use App\Models\ProductExtrasLanguage;
use App\Repositories\Interfaces\ExtraInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class ExtraRepository extends CoreRepository implements ExtraInterface
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

    public function get($id)
    {
        $extras = Model::with([
            "extrasGroup",
            "languages.language"
        ])
            ->where("id", $id)
            ->first();

        return $this->successResponse("success", $extras);
    }

    public function createOrUpdate($collection = [])
    {
        $extras = Model::updateOrCreate([
            "id" => $collection["id"]
        ], [
            "background_color" => $collection["background_color"],
            "price" => $collection['price'],
            "quantity" => $collection["quantity"],
            "image_url" => $collection["image_url"],
            "active" => $collection["active"],
            "id_extra_group" => $collection["extra_group_id"]
        ]);


        if ($extras) {
            $extras_id = $extras->id;
            foreach ($collection["name"] as $key => $value) {
                $language = Languages::where("short_name", $key)->first();

                ProductExtrasLanguage::updateOrCreate([
                    "id_extras" => $extras_id,
                    "id_lang" => $language->id
                ], [
                    "name" => $value,
                    "description" => $collection["description"][$key],
                    "id_extras" => $extras_id,
                    "id_lang" => $language->id
                ]);
            }
        }

        return $this->successResponse("success");
    }

    public function delete($id)
    {
        Model::find($id)->delete();

        return $this->successResponse("success");
    }

    public function datatable($collection = [])
    {
        $totalData = Model::with([
            "extrasGroup" => function ($query) use ($collection) {
                $query->id_product = $collection['product_id'];
            }
        ])->whereHas("extrasGroup", function($query) use ($collection) {
            $query->where("id_product", $collection['product_id']);
        })->count();
        $totalFiltered = $totalData;

        $defaultLanguage = Languages::where("default", 1)->first();

        $datas = Model::with([
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
            "extrasGroup" => function ($query) use ($collection) {
                $query->id_product = $collection['product_id'];
            },
            "extrasGroup.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
        ])->whereHas("extrasGroup", function($query) use ($collection) {
            $query->where("id_product", $collection['product_id']);
        })
            ->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {

                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->language->name;
                $nestedData['description'] = $data->language->description;
                $nestedData['group'] = $data->extrasGroup->language->name;
                $nestedData['price'] = $data->price;
                $nestedData['image_url'] = $data->image_url;
                $nestedData['background_color'] = $data->background_color;
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
}
