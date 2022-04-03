<?php

namespace App\Repositories;

use App\Models\Addresses as Model;
use App\Repositories\Interfaces\AddressInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class AddressRepository extends CoreRepository implements AddressInterface
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

    public function delete($id)
    {
        Model::find($id)->delete();

        return $this->successResponse("success", []);
    }

    public function datatable($collection = [])
    {
        $totalData = Model::count();
        $totalFiltered = $totalData;

        $datas = Model::with([
            "client"
        ])
            ->skip($collection['start'])
            ->take($collection['length'])
            ->get();


        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['address'] = $data->address;
                $nestedData['client'] = $data->client->name . " " . $data->client->surname . " (ID: " . $data->client->id . ")";
                $nestedData['latitude'] = $data->latitude;
                $nestedData['longtitude'] = $data->longtitude;
                $nestedData['default'] = $data->default;
                $nestedData['active'] = $data->active;
                $nestedData['options'] = [
                    'delete' => 1,
                ];
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function get($id_shop)
    {
        // TODO: Implement get() method.
    }

    public function createOrUpdate($collection = [])
    {
        Model::updateOrCreate([
            "id" => !isset($collection["id"]) ? 0 : $collection["id"]
        ], [
            "address" => $collection["address"],
            "latitude" => $collection["latitude"],
            "longtitude" => $collection["longitude"],
            "default" => 1,
            "id_user" => $collection["client_id"],
            "active" => 1
        ]);

        return $this->successResponse("success", []);
    }

    public function active($client_id)
    {
        $addresses = Model::where([
            "active" => 1,
            "id_user" => $client_id
        ])->get();

        return $this->successResponse("success", $addresses);
    }
}
