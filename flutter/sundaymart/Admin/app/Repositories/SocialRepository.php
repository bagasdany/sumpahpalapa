<?php

namespace App\Repositories;

use App\Models\Social as Model;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class SocialRepository extends CoreRepository
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

        $totalData = $this->getTotal($shop);
        $filtered = $length > $totalData ? $totalData : $length;

        $socials = $this->startCondition()->withCount('shopSocials')
            ->when($length, function ($q) use ($length, $start)  {
                $q->skip($start)->take($length);
            })
            ->when(isset($array['active']) && $array['active'] != 0, function ($q) {
                $q->whereActive(1);
            })
            ->orderByDesc('id')
            ->get();

        return $this->responseJsonDatatable($totalData, $filtered, $socials);
    }

    public function createOrUpdate($array){
        $social = $this->startCondition()->updateOrCreate(['id' => $array['id'] ?? null],[
            'tag' => $array['tag'],
            'name' => $array['name'],
            'active' => $array['active'] ?? 0,
        ]);

        return $this->successResponse('Social saved', $social);
    }

    public function get($id){

        $social = $this->startCondition()->find($id);
        if ($social) {
            return $this->successResponse('Social found', $social);
        }
        return $this->errorResponse('Social not found');
    }

    public function active(){
        $socials = $this->startCondition()->withCount('shopSocials')
            ->whereActive(1)
            ->orderByDesc('id')
            ->get();

        return $this->successResponse('Social found', $socials);
    }
}
