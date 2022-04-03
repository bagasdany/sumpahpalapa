<?php

namespace App\Repositories;

use App\Models\Languages;
use App\Models\ShopTransport as Model;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class ShopTransportRepository extends CoreRepository implements Interfaces\ShopTransportRepoInterface
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

    public function datatable($collection = [])
    {
        $length = $collection['length'] ?? null;
        $shop = $collection['shop_id'] ?? null;
        $sort = $collection['sort'] ?? 'desc';
        $start = $collection['start'] ?? 0;

        $totalData = $this->getTotal($shop);
        $filtered = $length > $totalData ? $totalData : $length;

        $lang = Languages::where("default", 1)->first();

        $data = $this->startCondition()
            ->with([
                "deliveryTransport" => function ($query) use ($lang) {
                    $query->where('lang_id', $lang->id);
                },
                'shop.language' => function ($query) use ($lang) {
                $query->where('id_lang', $lang->id);
            }])
            ->where('shop_id', $shop)
            ->when($length, function ($query) use ($length, $start) {
                $query->skip($start)->take($length);
            })
            ->orderBy('id', $sort)
            ->get();


        $data = $data->map(function ($value){
            return collect($value)->merge([
                'shop' => $value->shop->language->name,
                'options' => [
                    'delete' => 1,
                    'edit' => 1
                ]]);
        });

        return $this->responseJsonDatatable($totalData, $filtered, $data);
    }

    public function save($collection = [])
    {
        $transport = $this->startCondition()->updateOrCreate(
            ['shop_id' => $collection['shop_id'], 'delivery_transport_id' => $collection['delivery_transport_id']],
            [
                'price' => $collection['price'] ?? 0,
                'active' => $collection['active'] ?? 0,
                'default' => $collection['default'] ?? 0,
            ]);

        if ($transport){
            return $this->successResponse("Saved!", $transport);
        } else{
            return $this->errorResponse("Error during saving!");
        }
    }

    public function get($id)
    {
        $lang = Languages::where("default", 1)->first();

        $transport = $this->startCondition() ->with([
            "deliveryTransports",
            'shop.language' => function ($query) use ($lang) {
                $query->where('id_lang', $lang->id);
            }])->find($id);

        if ($transport) {
            $transport = collect($transport)->merge([
                    'shop' => $transport->shop->language->name,
                ]);

            return $this->successResponse("Transport found", $transport);
        } else {
            return $this->errorResponse("Transport not found");
        }
    }

    public function active($collection = [])
    {

        $lang = Languages::where("default", 1)->first();
        $data = $this->startCondition()
            ->with([
                "deliveryTransport" => function ($query) use ($lang) {
                    $query->where('lang_id', $lang->id);
                },
                'shop.language' => function ($query) use ($lang) {
                    $query->where('id_lang', $lang->id);
                }])
            ->where('shop_id', $collection['shop_id'])
            ->whereActive(1)
            ->orderBy('id', 'desc')
            ->get();


        $data = $data->map(function ($value){
            return collect($value)->merge([
                    'shop' => $value->shop->language->name
                ]);
        });

        return $this->successResponse("Transport found", $data);
    }

    public function default($collection = [])
    {
        $lang = Languages::where("default", 1)->first();
        $data = $this->startCondition()
            ->with([
                "deliveryTransport" => function ($query) use ($lang) {
                    $query->where('lang_id', $lang->id);
                },
                'shop.language' => function ($query) use ($lang) {
                    $query->where('id_lang', $lang->id);
                }])
            ->where('shop_id', $collection['shop_id'])
            ->whereDefault(1)
            ->orderBy('id', 'desc')
            ->get();


        $data = $data->map(function ($value){
            return collect($value)->merge([
                'shop' => $value->shop->language->name
            ]);
        });

        return $this->successResponse("Transport found", $data);
    }

}
