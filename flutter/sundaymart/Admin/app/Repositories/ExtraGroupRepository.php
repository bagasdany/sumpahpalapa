<?php

namespace App\Repositories;

use App\Models\ExtrasGroupTypes;
use App\Models\Languages;
use App\Models\ProductExtrasGroup as Model;
use App\Models\ProductExtrasGroupLanguage;
use App\Repositories\Interfaces\ExtraGroupInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class ExtraGroupRepository extends CoreRepository implements ExtraGroupInterface
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
        $lang = Languages::whereDefault(1)->first();

        $extras_group = $this->startCondition()->with([
            "languages.language",
            "extras.language" => function($query) use($lang) {
                return $query->where('id_lang', $lang->id);
            }
        ])->where("id", $id)->first();

        return $this->successResponse("success", $extras_group);
    }

    public function delete($id)
    {
        Model::findOrFail($id)->delete();

        return $this->successResponse("success");
    }

    public function createOrUpdate($collection = [])
    {
        $extrasGroup = Model::updateOrCreate([
            "id" => $collection["id"]
        ], [
            "id_product" => $collection["product_id"],
            "active" => $collection["active"],
            "type" => $collection["type"]
        ]);

        if ($extrasGroup) {
            $extras_group_id = $extrasGroup->id;
            foreach ($collection["name"] as $key => $value) {
                $language = Languages::where("short_name", $key)->first();

                ProductExtrasGroupLanguage::updateOrCreate([
                    "id_extra_group" => $extras_group_id,
                    "id_lang" => $language->id
                ], [
                    "name" => $value,
                    "id_extra_group" => $extras_group_id,
                    "id_lang" => $language->id
                ]);
            }
        }

        return $this->successResponse("success");
    }

    public function getExtraGroupType()
    {
        $extrasTypes = ExtrasGroupTypes::where("active", 1)->get();

        return $this->successResponse("success", $extrasTypes);
    }

    public function datatable($collection = [])
    {
        $totalData = Model::where([
            "id_product" => $collection['product_id']
        ])->count();

        $totalFiltered = $totalData;

        $defaultLanguage = Languages::where("default", 1)->first();

        $datas = Model::with([
            "types",
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])
            ->where("id_product", $collection['product_id'])
            ->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {

                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->language->name;
                $nestedData['type'] = $data->types->name;
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

    public function active($product_id) {
        $defaultLanguage = Languages::where("default", 1)->first();

        $data = Model::with([
            "language" => function($query) use($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])
            ->where("id_product", $product_id)
            ->get();

        return $this->successResponse("success", $data);
    }
}
