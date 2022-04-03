<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\Languages;
use App\Repositories\Interfaces\TimeUnitInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;
use App\Models\TimeUnits as Model;

class TimeUnitRepository extends CoreRepository implements TimeUnitInterface
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
        Model::updateOrCreate([
            "id" => $collection["id"]
        ], [
            "name" => $collection['name'],
            "sort" => $collection['sort'],
            "active" => $collection['active'],
            "id_shop" => $collection['shop_id'],
        ]);

        return $this->successResponse("success");
    }

    public function datatable($collection = [])
    {
        $id_shop = Admin::getUserShopId();
        if ($id_shop == -1)
            $totalData = Model::count();
        else
            $totalData = Model::where("id_shop", $id_shop)->count();

        $totalFiltered = $totalData;

        $defaultLanguage = Languages::where("default", 1)->first();

        $datas = Model::with([
            "shop.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ]);
        if ($id_shop != -1)
            $datas = $datas->where("id_shop", $id_shop);

        $datas = $datas->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->name;
                $nestedData['shop'] = $data->shop->language->name;
                $nestedData['sort'] = $data->sort;
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
        $timeUnit = Model::find($id);

        return $this->successResponse("success", $timeUnit);
    }

    public function delete($id)
    {
        Model::find($id)->delete();

        return $this->successResponse("success");
    }

    public function active($shop_id)
    {
        $timeUnits = Model::where([
            "id_shop" => $shop_id,
            "active" => 1
        ])->get();

        return $this->successResponse("success", $timeUnits);
    }
}
