<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\Languages;
use App\Models\ShopsCurriencies as Model;
use App\Repositories\Interfaces\ShopCurrencyInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class ShopCurrencyRepository extends CoreRepository implements ShopCurrencyInterface
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
            "id" => $collection["id"] ?? null,
            "id_currency" => $collection["id_currency"]
        ], [
            "id_shop" => $collection["id_shop"],
            "default" => $collection["default"] ?? 0,
            "value" => $collection["value"],
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
            "currency.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
            "shop.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
        ])
            ->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {

                $nestedData['id'] = $data->id;
                $nestedData['shop_name'] = $data->shop->language->name;
                $nestedData['currency_name'] = $data->currency->language->name;
                $nestedData['default'] = $data->default;
                $nestedData['id_shop'] = $data->id_shop;
                $nestedData['value'] = $data->value . " " . $data->currency->symbol;

                $nestedData['options'] = [
                    'delete' => 1,
                    'edit' => 1
                ];
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function getShopCurrencies($shop_id)
    {
        $shops_currency = Model::with([
            "currency"
        ])->where([
            'id_shop' => $shop_id,
            "default" => 1
        ])
            ->first();

        return $this->successResponse("success", $shops_currency);
    }

    public function get($id)
    {
        $shops_currency = Model::find($id);

        return $this->successResponse("success", $shops_currency);
    }

    public function delete($id)
    {
        Model::find($id)->delete();

        return $this->successResponse("success");
    }

    public function change($collection = [])
    {
        // change default to 0
        Model::updateOrCreate([
            "id_shop" => $collection['shop_id'],
            "default" => 1
        ], [
            "default" => 0
        ]);

        $shops_currency = Model::where([
            'id_shop' => $collection['shop_id'],
            'id' => $collection['id_shop_currency']
        ])
            ->first();

        $default_value = $shops_currency->value;

        // change default to 1
        Model::updateOrCreate([
            "id_shop" => $collection['shop_id']
        ], [
            "default" => 1,
            "value" => 1
        ]);

        $shops = Model::where([
            'id_shop' => $collection['shop_id'],
            ['id', '<>', $collection['id_shop_currency']]
        ])
            ->get();

        foreach ($shops as $single_shop) {
            $shop = Model::findOrFail($single_shop->id);

            $shop->value = $shop->value / $default_value;
            $shop->save();
        }

//        $products = Products::where('id_shop', $id_shop)->get();
//
//        foreach($products as $single_product){
//
//            $price = $single_product->price / $default_value;
//            $product = Products::findOrFail($single_product->id);
//            $product->value = $price;
//            $product->save();
//        }

        return $this->successResponse("success");
    }
}
