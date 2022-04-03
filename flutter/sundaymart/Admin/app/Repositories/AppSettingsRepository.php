<?php

namespace App\Repositories;

use App\Models\Languages;
use App\Models\MobileParams as Model;
use App\Models\MobileParamsLanguage;
use App\Repositories\Interfaces\AppSettingsInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class AppSettingsRepository extends CoreRepository implements AppSettingsInterface
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

    public function appLanguageDatatable($collection = [])
    {
        $totalData = Languages::count();
        $totalFiltered = $totalData;

        $datas = Languages::skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        $params = Model::count();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $paramsLanguage = MobileParamsLanguage::where("id_lang", $data->id)->count();

                $nestedData['id'] = $data->id;
                $nestedData['language'] = $data->name;
                $nestedData['percentage'] = intval(($paramsLanguage * 100) / $params) . " %";
                $nestedData['options'] = [
                    'edit' => 1
                ];
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function appTranslationDatatable($collection = [])
    {
        $totalData = Model::count();
        $totalFiltered = $totalData;

        $datas = Model::with([
            "language" => function ($query) use ($collection) {
                $query->id_lang = $collection['id_lang'];
            }
        ])
            ->skip($collection['start'])
            ->take($collection['length'])
            ->get();


        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['word'] = $data->name;
                $nestedData['translation'] = $data->language ? $data->language->name : "";
                $nestedData['options'] = [
                    'edit' => 1
                ];
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function saveTranslation($collection = [])
    {
        MobileParamsLanguage::updateOrCreate([
            'id_param' => $collection['id_param'],
            'id_lang' => $collection['id_lang']
        ], [
            'id_param' => $collection['id_param'],
            'id_lang' => $collection['id_lang'],
            "name" => $collection["name"]
        ]);

        return $this->successResponse("success", []);
    }
}
