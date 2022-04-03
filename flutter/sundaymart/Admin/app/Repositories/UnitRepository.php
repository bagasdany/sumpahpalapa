<?php

namespace App\Repositories;

use App\Models\Languages;
use App\Models\UnitsLanguage;
use App\Repositories\Interfaces\UnitInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;
use App\Models\Units as Model;

class UnitRepository extends CoreRepository implements UnitInterface
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
        $unit = Model::updateOrCreate([
            "id" => $collection["id"]
        ], [
            "active" => $collection["active"]
        ]);

        if ($unit) {
            $unit_id = $unit->id;
            foreach ($collection['name'] as $key => $value) {
                $language = Languages::where("short_name", $key)->first();

                UnitsLanguage::updateOrCreate([
                    "id_unit" => $unit_id,
                    "id_lang" => $language->id
                ], [
                    "name" => $value,
                    "id_unit" => $unit_id,
                    "id_lang" => $language->id
                ]);
            }

            return $this->successResponse("success");
        }

        return $this->errorResponse("error");
    }

    public function datatable($collection = [])
    {
        $totalData = Model::count();
        $totalFiltered = $totalData;

        $defaultLanguage = Languages::where("default", 1)->first();

        $datas = Model::with([
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])
            ->skip($collection['start'])
            ->take($collection['length'])
            ->get();


        $responseData = array();
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

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function get($id)
    {
        $units = Model::with([
            "languages.language"
        ])->where("id", $id)->first();

        return $this->successResponse("success", $units);
    }

    public function delete($id)
    {
        Model::find($id)->delete();

        return $this->successResponse("success");
    }

    public function active()
    {
        $defaultLanguage = Languages::where("default", 1)->first();

        $units = Model::with([
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])->where("active", 1)->get();

        $unitsArra = [];

        foreach ($units as $unit) {
            $unitsArra[] = [
                'id' => $unit->id,
                'name' => $unit->language->name,
            ];
        }

        return $this->successResponse("success", $unitsArra);
    }
}
