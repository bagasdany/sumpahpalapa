<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\Tax as Model;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class TaxRepository extends CoreRepository implements Interfaces\TaxRepoInterface
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

    /**
     * @param array $array
     * @return mixed
     */
    public function datatable($collection = [])
    {
        $shop_id = Admin::getUserShopId();
        if ($shop_id == -1) {
            if (isset($collection['shop_id']))
                $totalData = $this->startCondition()->where("shop_id", $collection['shop_id'])->count();
            else
                $totalData = $this->startCondition()->count();
        } else {
            if (isset($collection['shop_id']))
                $totalData = $this->startCondition()->where("shop_id", $collection['shop_id'])->count();
            else
                $totalData =  $this->startCondition()->where("shop_id", $shop_id)->count();
        }

        $length = $collection['length'] ?? null;
        $shop = $collection['shop_id'] ?? null;
        $sort = $collection['sort'] ?? 'desc';

        $filtered = $length > $totalData ? $totalData : $length;

        $data = $this->startCondition()
            ->skip($collection['start'])
            ->when($length, function ($q, $length) {
                 $q->take($length);
            })
            ->when($shop, function ($q, $shop) {
                $q->where('shop_id', $shop);
            })
            ->orderBy('id', $sort)
            ->get();


        $data = $data->map(function ($value){
            return collect($value)->merge([
                'shop_name' => $value->shop->language->name,
                'options' => [
                    'delete' => 1,
                    'edit' => 1
            ]]);
        });

        return $this->responseJsonDatatable($totalData, $filtered, $data);
    }

    public function updateOrCreate($array = []){

        $tax = $this->startCondition()->updateOrCreate(['id' => $array['id'] ?? null], [
            'name' => $array['name'],
            'shop_id' => $array['shop_id'],
            'description' => $array['description'],
            'percent' => $array['percent'] ?? 0,
            'active' => $array['active'] ?? 0,
            'default' => $array['default'] ?? 0,
        ]);

        return $this->successResponse("Tax was successfully saved", $tax);

    }
    /**
     * Get Tax by $id
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function get($id)
    {
        $shop_id = Admin::getUserShopId();

        if ($shop_id == -1) {
           $tax = $this->startCondition()->find($id);
        } else {
            $tax = $this->startCondition()->where('shop_id', $shop_id)->where('id', $id)->first();
        }

        if ($tax) {
            $tax = collect($tax)->merge(['shop_name' => $tax->shop->language->name]);
            return $this->successResponse("Tax number found", $tax);
        } else {
            return $this->errorResponse("Tax not found");
        }

    }

    /**
     * @param array $array
     * @return mixed
     */
    public function active($shop_id, $array = [])
    {
        $user_shop = Admin::getUserShopId();
        $sort = $array['sort'] ?? 'desc';

        if ($user_shop == -1 || $user_shop == $shop_id) {
            $data = $this->startCondition()
                ->where('shop_id', $shop_id)
                ->whereActive(1)
                ->orderBy('id', $sort)
                ->get();
        } else {
            return $this->errorResponse('You don\'t have permission');
        }

        return $this->successResponse('Found ' . $data->count() . ' active taxes', $data);
    }

    /**
     * @return mixed
     */
    public function getDefaultTaxes($shop_id, $array = [])
    {
        $user_shop = Admin::getUserShopId();
        $sort = $array['sort'] ?? 'desc';

        if ($user_shop == -1 || $user_shop == $shop_id) {
            $data = $this->startCondition()
                ->where('shop_id', $shop_id)
                ->whereDefault(1)
                ->whereActive(1)
                ->orderBy('id', $sort)
                ->get();
        } else {
            return $this->errorResponse('You don\'t have permission');
        }

        return $this->successResponse('Found ' . $data->count() . ' default and active taxes', $data);
    }
}
