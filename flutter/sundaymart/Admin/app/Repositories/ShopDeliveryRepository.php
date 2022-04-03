<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\Languages;
use App\Models\ShopDelivery;
use App\Models\Shops;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;
use App\Models\ShopDelivery as Model;
class ShopDeliveryRepository extends CoreRepository implements Interfaces\ShopDeliveryInterface
{
    use DatatableResponse;
    use ApiResponse;
    public function __construct()
    {
        parent::__construct();
    }

    protected function getModelClass()
    {
        return Model::class;
    }

    public function datatable($collection = [])
    {
        $shop_id = Admin::getUserShopId();
        if ($shop_id == -1)
            $totalData = $this->startCondition()->count();
        else
            $totalData = $this->startCondition()->where("id_shop", $shop_id)->count();

        $filtered = $collection['length'] > $totalData ? $totalData : $collection['length'];

        $defaultLanguage = Languages::where("default", 1)->first();

        $data = $this->startCondition()->with([
            'deliveryType' => function ($q) use ($defaultLanguage) {
                $q->where('lang_id', $defaultLanguage->id);
            },
            "shop" => function ($query) {
                $query->select('id', 'logo_url', 'active', 'id_shop_category');
            },
            "shop.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
        ])->skip($collection['start'])
            ->take($collection['length'])
            ->orderBy("id", "desc")
            ->get();

        $data = $data->map(function ($value){
            return collect($value)->merge([
                // 'type' => $value->type.':'.ShopDelivery::TYPES[$value->type],
                'options' => [
                    'delete' => 1,
                    'edit' => 1
                ]
            ]);
        });

        return $this->responseJsonDatatable($totalData, $filtered, $data);
    }

    public function save($params, $id = null)
    {
        $shop = Shops::find($params['shop_id']);
        if ($shop) {
            return $this->startCondition()->updateOrCreate(['id' => $params['id'] ?? null],
                [
                    'shop_id' => $params['shop_id'],
                    'delivery_type_id' => $params['delivery_type_id'],
                    'type' => $params['type'],
                    'start' => $params['start'],
                    'end' => $params['end'] ?? null,
                    'amount' => $params['amount'],
                    'active' => $params['active'] ?? 0
                ]);
        }
         return false;
    }

    public function getByShopId($shop_id, $collection = [])
    {
        $start = $collection['start'] ?? 0;
        $length = $collection['length'] ?? null;
        $total =  $this->startCondition()->where('shop_id', $shop_id)->count();
        $lang = Languages::where('default', 1)->pluck('id')->first();

        $response = $this->startCondition()->with([
            'deliveryType' => function ($q) use ($lang) {
                $q->where('lang_id', $lang);
            },
        ])->where('shop_id', $shop_id)
            ->when($length, function ($q) use ($length, $start) {
                $q->skip($start)->take($length);
            })
            ->orderByDesc('id')->get();

        return $this->responseJsonDatatable($total, $length, $response);
    }

    public function getActiveShopDeliveries($shop_id) {

        $lang = Languages::where('default', 1)->pluck('id')->first();

        $response = $this->startCondition()->with([
            'deliveryType' => function ($q) use ($lang) {
                $q->where('lang_id', $lang);
            },
        ])->where([
            'shop_id' => $shop_id,
            'active' => 1
        ])->get();

        return $this->successResponse("success", $response);
    }
}
