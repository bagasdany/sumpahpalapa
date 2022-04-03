<?php

namespace App\Repositories;

use App\Models\Languages;
use App\Models\Point as Model;
use App\Models\PointRate;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class PointRepository extends CoreRepository implements Interfaces\PointInterface
{
    use ApiResponse;
    use DatatableResponse;
    protected function getModelClass()
    {
        return Model::class;
    }

    public function datatable($array)
    {
        $length = $array['length'] ?? null;
        $start = $array['start'] ?? 0;
        $total = $this->getTotal(null);

        $points = $this->startCondition()->with([
            'language' => function($q)  {
                $q->where('lang_id',  $this->defaultLanguage());
            }])
            ->when(isset($length), function ($q) use ($length, $start) {
                $q->take($length)->skip($start);
            })->when(isset($array['active']), function ($q) use ($array) {
                $q->where('active', $array['active']);
            })->get();

        return $this->responseJsonDatatable($total, $length, $points);
    }

    public function createOrUpdate($array)
    {
        $point = $this->startCondition()->updateOrCreate(['id' => $array['id'] ?? null],[
            'type' => $array['type'] ?? 1,
            'amount' => $array['amount'] ?? 0,
            'range' => $array['range'] ?? null,
            'position' => $array['position'] ?? $this->startCondition()->count() + 1,
            'active' => $array['active'] ?? 0,
        ]);

        if ($point){
            $languages = Languages::select('id', 'short_name')->get();
            foreach ($languages as $lang){
                $point->languages()->updateOrCreate(['lang_id' => $lang->id],[
                    'name' => $array['name'][$lang->short_name] ?? null,
                    'description' => $array['description'][$lang->short_name] ?? null,
                ]);
            }
        }

        return $this->successResponse('Point save', $point);
    }

    public function get($id)
    {
        $point = $this->startCondition()->with('languages')->find($id);
        if (!$point) {
            return $this->errorResponse('Point not found');
        }
        return $this->successResponse('Point found', $point);
    }

    public function active($array)
    {
        $length = $array['length'] ?? null;
        $start = $array['start'] ?? 0;

        $points = $this->startCondition()->with([
            'language' => function($q) {
                $q->where('lang_id', $this->defaultLanguage());
            }])
            ->when(isset($length), function ($q) use ($length, $start) {
                $q->take($length)->skip($start);
            })->whereActive(1)->get();

        return $this->successResponse('Points found', $points);
    }

    /**
     * @param $array
     * @return mixed
     */
    public function pointRateSave($array)
    {
        $rate = PointRate::updateOrCreate(['id' => $array['id'] ?? null],[
            'rate' => $array['rate'],
            'amount' => $array['amount'] ?? 1,
        ]);
        return $this->successResponse('Point Rate not found', $rate);
    }

    /**
     * @return mixed
     */
    public function pointRateShow()
    {
        $rate = PointRate::first();
        if ($rate) {
            return $this->successResponse('Point Rate found', $rate);
        }
        return $this->errorResponse('Point Rate');
    }
}
