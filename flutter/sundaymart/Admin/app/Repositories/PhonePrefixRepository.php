<?php

namespace App\Repositories;

use App\Models\PhonePrefix as Model;
use App\Repositories\Interfaces\PhonePrefixInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class PhonePrefixRepository extends CoreRepository implements PhonePrefixInterface
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
            "id" => $collection['id']
        ],[
            'prefix' => $collection['phone_prefix'],
            'active' => $collection['active']
        ]);

        return $this->successResponse("success");
    }

    public function datatable($collection = [])
    {
        $totalData = Model::count();
        $totalFiltered = $totalData;

        $datas = Model::skip($collection['start'])
            ->take($collection['length'])
            ->get();


        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['phone_prefix'] = $data->prefix;
                $nestedData['active'] = $data->active;
                $nestedData['options'] = [
                    'delete' => 1,
                    'edit' => 1
                ];
                $responseData[] = $nestedData;
            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function get($id)
    {
       $phone_prefix = Model::find($id);

       return $this->successResponse("success", $phone_prefix);
    }

    public function delete($id)
    {
        Model::find($id)->delete();

        return $this->successResponse("success");
    }

    public function active()
    {
        $activePhonePrefix = Model::where('active', 1)->get();

        return $this->successResponse("success", $activePhonePrefix);
    }
}
