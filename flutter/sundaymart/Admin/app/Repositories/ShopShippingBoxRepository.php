<?php

namespace App\Repositories;

use App\Models\Languages;
use App\Models\ShopShippingBox as Model;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class ShopShippingBoxRepository extends CoreRepository implements Interfaces\ShopShippingBoxRepoInterface
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
                "shippingBox" => function ($query) use ($lang) {
                    $query->where('lang_id', $lang->id);
                }])
            ->when($shop, function ($query) use ($shop) {
                $query->where('shop_id', $shop);
            })
            ->when($length, function ($query) use ($length, $start) {
                $query->skip($start)->take($length);
            })
            ->orderBy('id', $sort)
            ->get();

        $data = $data->map(function ($value){
            return collect($value)->merge([
                'options' => [
                    'delete' => 1,
                    'edit' => 1
                ]]);
        });

        return $this->responseJsonDatatable($totalData, $filtered, $data);
    }

    public function save($collection = [])
    {
        $box = $this->startCondition()->updateOrCreate(['id' => $collection['id'] ?? null],
            [
                'shop_id' => $collection['shop_id'],
                'shipping_box_id' => $collection['shipping_box_id'],
                'start' => $collection['start'] ?? 0,
                'end' => $collection['end'] ?? null,
                'price' => $collection['price'],
                'active' => $collection['active'] ?? 0
            ]);

        if ($box){
            return $this->successResponse("Box Saved!", $box);
        } else{
            return $this->errorResponse("Error during saving!");
        }
    }

    public function get($id)
    {
        $box = $this->startCondition()->with("shippingBoxes")->find($id);
        if ($box) {
            return $this->successResponse("Box found", $box);
        } else {
            return $this->errorResponse("Box not found");
        }
    }

    public function active($collection = [])
    {
        $lang = Languages::where("default", 1)->first();
        $data = $this->startCondition()
            ->with(["shippingBox" => function ($query) use ($lang) {
                $query->where('lang_id', $lang->id);
            }])
            ->where('shop_id', $collection['shop_id'])
            ->whereActive(1)
            ->orderBy('id', 'desc')
            ->get();

        return $this->successResponse("Active Boxes found", $data);
    }

}
