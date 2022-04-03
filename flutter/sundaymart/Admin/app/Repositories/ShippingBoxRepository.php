<?php

namespace App\Repositories;

use App\Models\Languages;
use App\Models\ShippingBox as Model;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;


class ShippingBoxRepository extends CoreRepository implements Interfaces\ShippingBoxRepoInterface
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
                "language" => function ($query) use ($lang) {
                    $query->where('lang_id', $lang->id);
                }])
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
                'active' => $collection['active'] ?? 0,
                'type' => $collection['type'] ?? null
            ]);

        if ($box){
            $languages = Languages::select('id', 'short_name')->get();
            foreach ($languages as $lang){
                $box->languages()->updateOrCreate(['lang_id' => $lang->id, "shipping_box_id" => $box->id], [
                    'name' => $collection['name'][$lang->short_name] ?? null,
                    'description' => $collection['description'][$lang->short_name] ?? null,
                ]);
            }
            return $this->successResponse("Box Saved!", $box);
        } else{
            return $this->errorResponse("Error during saving!");
        }
    }

    public function get($id)
    {
        $box = $this->startCondition()->with("languages.language")->find($id);
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
            ->with(["language" => function ($query) use ($lang) {
                    $query->where('lang_id', $lang->id);
                }])
            ->whereActive(1)
            ->orderBy('id', 'desc')
            ->get();

        return $this->successResponse("Active Boxes found", $data);
    }

}
