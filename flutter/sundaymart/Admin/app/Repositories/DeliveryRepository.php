<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\DeliveryType as Model;
use App\Models\Languages;
use App\Traits\DatatableResponse;

class DeliveryRepository extends CoreRepository implements Interfaces\DeliveryInterface
{
    use DatatableResponse;
    public function __construct()
    {
        parent::__construct();
    }

    protected function getModelClass()
    {
        return Model::class;
    }

    public function datatable($array = [])
    {
         $shop_id = Admin::getUserShopId();
        if ($shop_id == -1)
            $totalData = $this->startCondition()->count();
        else
            $totalData = $this->startCondition()->where("id_shop", $shop_id)->count();

        $filtered = $array['length'] > $totalData ? $totalData : $array['length'];

        $data = $this->startCondition()->with(
            'languages',
            'languages.language'
        )->skip($array['start'])
            ->take($array['length'])
            ->orderBy("id", "desc")
            ->get();

        $data = $data->map(function ($value){
            return collect($value)->merge(['options' => [
                'delete' => 1,
                'edit' => 1
            ]]);
        });

        return $this->responseJsonDatatable($totalData, $filtered, $data);
    }

    public function save($array = [])
    {
        $result = $this->startCondition()->updateOrCreate(['id' => $array['id'] ?? null],[
            'status' => $array['status'] ?? 0
        ]);

        if ($result){
            $languages = Languages::select('id', 'short_name')->get();
            foreach ($languages as $lang){
                $result->languages()->updateOrCreate(['lang_id' => $lang->id],[
                    'name' => $array['name'][$lang->short_name] ?? null,
                    'description' => $array['description'][$lang->short_name] ?? null,
                ]);
            }
        }
        return $result;
    }
}
