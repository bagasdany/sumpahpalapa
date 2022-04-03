<?php

namespace App\Repositories;

use App\Models\ShopSocial as Model;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class ShopSocialRepository extends CoreRepository
{

    use ApiResponse;
    use DatatableResponse;

    protected function getModelClass()
    {
        return Model::class;
    }

    public function datatable($array) {

        $shop = $array['shop_id'] ?? null;
        $length = $array['length'] ?? null;
        $start = $array['start'] ?? 0;
        $social = $array['social_id'] ?? null;

        $totalData = $this->getTotal($shop);
        $filtered = $length > $totalData ? $totalData : $length;

        $socials = $this->startCondition()->with('social')
            ->when($length, function ($q) use ($length, $start)  {
                $q->skip($start)->take($length);
            })
            ->when($shop, function ($q) use ($shop)  {
                $q->where('shop_id', $shop);
            })
            ->when($social, function ($q) use ($social)  {
                $q->where('social_id', $social);
            })
            ->when(isset($array['active']) && $array['active'] != 0, function ($q) {
                $q->whereActive(1);
            })
            ->orderByDesc('id')
            ->get();

        return $this->responseJsonDatatable($totalData, $filtered, $socials);
    }

    public function createOrUpdate($array){

        $social = $this->startCondition()->updateOrCreate(['id' => $array['id'] ?? null], [
            'social_id' => $array['social_id'],
            'shop_id' => $array['shop_id'],
            'link' => $array['link'],
            'active' => $array['active'] ?? 0,
        ]);

        return $this->successResponse('Shop Social saved', $social);
    }

    public function get($id){

        $social = $this->startCondition()->with('social')->find($id);
        if ($social) {
            return $this->successResponse('Shop Social found', $social);
        }
        return $this->errorResponse('Shop Social not found');
    }

    public function active(){
        $socials = $this->startCondition()->with('social')
            ->whereActive(1)
            ->orderByDesc('id')
            ->get();

        return $this->successResponse('Shop Social found', $socials);
    }
}
