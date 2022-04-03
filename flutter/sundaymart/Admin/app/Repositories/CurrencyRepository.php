<?php

namespace App\Repositories;

use App\Models\Currency as Model;
use App\Models\CurrencyLanguage;
use App\Models\Languages;
use App\Models\ShopsCurriencies;
use App\Repositories\Interfaces\CurrencyInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class CurrencyRepository extends CoreRepository implements CurrencyInterface
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
        $currency = Model::with([
            "languages.language"
        ])->where("id", $id)->first();

        return $this->successResponse("success", $currency);
    }

    public function createOrUpdate($collection = [])
    {
        $default = (Model::count() == 0 || (Model::count() == 1 && $collection['id'] > 0)) ? 1 : 0;

        $currency = Model::updateOrCreate([
            "id" => $collection['id'] ?? null
        ], [
            "symbol" => $collection['symbol'],
            "default" => $default,
            "active" => $collection['active'],
            "rate" => $collection['rate']
        ]);
        if ($currency) {
            $currency_id = $currency->id;
            foreach ($collection['name'] as $key => $value) {
                $language = Languages::where("short_name", $key)->first();

                CurrencyLanguage::updateOrCreate([
                    "id_currency" => $currency_id,
                    "id_lang" => $language->id
                ], [
                    "name" => $value,
                    "id_currency" => $currency_id,
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

    public function getAllActiveCurrenciesForRest($collection = [])
    {
        $currency = ShopsCurriencies::where([
            "id_shop" => $collection['id_shop']
        ])
            ->with([
                "currency.language" => function ($query) use ($collection) {
                    $query->id_lang = $collection['id_lang'];
                }
            ])
            ->get();

        return $this->successResponse("success", $currency);
    }

    public function active()
    {
        $defaultLanguage = Languages::where("default", 1)->first();

        $currencies = Model::with([
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])
            ->where("active", 1)
            ->get();

        return $this->successResponse("success", $currencies);
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
                $nestedData['symbol'] = $data->symbol;
                $nestedData['active'] = $data->active;
                $nestedData['rate'] = $data->rate;
                $nestedData['name'] = $data->language->name;
                $nestedData['options'] = [
                    'delete' => 1,
                    'edit' => 1
                ];
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function default(){
        $defaultLanguage = Languages::where("default", 1)->first();

        $currencies = Model::with([
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])
            ->where("default", 1)
            ->first();

        return $this->successResponse("success", $currencies);
    }
}
