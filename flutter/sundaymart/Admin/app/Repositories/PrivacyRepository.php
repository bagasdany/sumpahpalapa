<?php

namespace App\Repositories;


use App\Models\Admin;
use App\Models\Languages;
use App\Models\Privacy as Model;
use App\Models\PrivacyLanguage;
use App\Models\Shops;
use App\Repositories\Interfaces\PrivacyInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class PrivacyRepository extends CoreRepository implements PrivacyInterface
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
        $privacy = Model::updateOrCreate([
            "id_shop" => $collection["id_shop"],
        ], [
            "active" => 1,
            "id_shop" => $collection["id_shop"]
        ]);

        if ($privacy) {
            $privacy_id = $privacy->id;
            foreach ($collection['privacy_content'] as $key => $value) {
                $language = Languages::getByShortName($key);

                PrivacyLanguage::updateOrCreate([
                    "id_privacy" => $privacy_id,
                    "id_lang" => $language->id,
                ], [
                    "id_lang" => $language->id,
                    "content" => $value,
                ]);
            }
        }

        return $this->successResponse("success");
    }

    public function datatable($collection = [])
    {
        $whereQuery = [
            "active" => 1
        ];

        $id_shop = Admin::getUserShopId();
        if($id_shop > 0)
            $whereQuery["id"] = $id_shop;

        $totalData = Shops::where($whereQuery)->count();
        $filteredData = $totalData;

        $language = Languages::getDefaultLanguage();

        $datas = Shops::where($whereQuery)->with([
            "language",
            "privacy.language" => function ($query) use ($language) {
                $query->id_lang = $language->id;
            }
        ])
            ->take($collection['length'])
            ->skip($collection['start'])
            ->get();

        $responseData = array();
        foreach ($datas as $data) {
            $nestedData['id_shop'] = $data['id'];
            $nestedData['shop'] = $data['language']['name'];
            $nestedData['context'] = $data['privacy'] == null ? "" : $data['privacy']['language']['content'];
            $nestedData['options'] = [
                'edit' => 1
            ];

            $responseData[] = $nestedData;
        }

        return $this->responseJsonDatatable($totalData, $filteredData, $responseData);
    }

    public function delete($id)
    {

    }

    public function get($id_shop)
    {
        $data = Model::where("id_shop", $id_shop)->with([
            "languages",
            "languages.language",
        ])->first();

        return $this->successResponse("success", $data);
    }
}
