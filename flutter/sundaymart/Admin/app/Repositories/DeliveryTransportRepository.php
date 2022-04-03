<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\DeliveryTransport as Model;
use App\Models\Languages;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class DeliveryTransportRepository extends CoreRepository implements Interfaces\DeliveryTransportRepoInterface
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
     * @param array $collection
     * @return mixed
     */
    public function datatable($collection = [])
    {
        $length = $collection['length'] ?? null;
        $sort = $collection['sort'] ?? 'desc';
        $start = $collection['start'] ?? 0;

        $totalData = $this->startCondition()->count();
        $filtered = $length > $totalData ? $totalData : $length;

        $lang = Languages::firstWhere('default', 1);
        $data = $this->startCondition()
            ->with(['language' => function($q) use($lang){
                  $q->where('lang_id', $lang->id);
            }])
            ->when($length, function ($q, $length) use($start) {
                $q->take($length)->skip($start);
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

    /**
     * @param array $collection
     * @return mixed
     */
    public function save($collection = [])
    {
        $transport = $this->startCondition()->updateOrCreate(['id' => $collection['id'] ?? null],[
            'active' => $collection['active'] ?? 0
        ]);

        if ($transport){
            $languages = Languages::select('id', 'short_name')->get();
            foreach ($languages as $lang){

                $transport->languages()->updateOrCreate(['lang_id' => $lang->id],[
                    'name' => $collection['name'][$lang->short_name] ?? null,
                    'description' => $collection['description'][$lang->short_name] ?? null,
                ]);

            }
            return $this->successResponse("Saved!", $transport);
        }
    }

    /**
     * @param $id
     * @return mixed
     */
    public function get($id)
    {
        $transport = $this->startCondition()->with('languages.language')->find($id);

        if ($transport) {
            return $this->successResponse("Transport found", $transport);
        } else {
            return $this->errorResponse("Transport not found");
        }
    }

    /**
     * @param array $collection
     * @return mixed
     */
    public function active($collection = [])
    {
        $lang = Languages::firstWhere('default', 1);

        $length = $collection['length'] ?? null;
        $sort = $collection['sort'] ?? 'desc';
        $start = $collection['start'] ?? 0;

        $totalData = $this->startCondition()->count();
        $filtered = $length > $totalData ? $totalData : $length;

        $data = $this->startCondition()
            ->with(['language' => function($q) use($lang){
                $q->where('lang_id', $lang->id);
            }])
            ->whereActive(1)
            ->when($length, function ($q, $length) use($start) {
                $q->skip($start)->take($length);
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


}
