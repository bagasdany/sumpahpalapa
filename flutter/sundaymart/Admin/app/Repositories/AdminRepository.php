<?php

namespace App\Repositories;

use App\Models\Admin as Model;
use App\Models\Currency;
use App\Models\Languages;
use App\Repositories\Interfaces\AdminInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;
use Carbon\Carbon;
use Illuminate\Support\Facades\Hash;

class AdminRepository extends CoreRepository implements AdminInterface
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

    public function delete($id)
    {
        Model::find($id)->delete();

        return $this->successResponse("success", []);
    }

    public function datatable($collection = [])
    {
        $totalData = Model::where("is_confirmed", 1)->count();
        $totalFiltered = $totalData;

        $defaultLanguage = Languages::where("default", 1)->first();

        $datas = Model::with([
            'shop' => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])->where("is_confirmed", 1)
            ->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->name;
                $nestedData['surname'] = $data->surname;
                $nestedData['shop'] = $data['id_shop'] != null && $data->shop ? $data->shop->name : "-";
                $nestedData['role'] = $data->role_name;
                $nestedData['id_role'] = $data->id_role;
                $nestedData['image_url'] = $data->image_url;
                $nestedData['is_requested'] = $data->is_requested;
                $nestedData['phone'] = $data->phone;
                $nestedData['email'] = $data->email;
                $nestedData['id_role'] = $data->id_role;
                $nestedData['id_shop'] = $data->id_shop;
                $nestedData['offline'] = $data->offline;
                $nestedData['active'] = $data->active;
                $nestedData['options'] = [
                    'delete' => 1,
                    'edit' => 1
                ];
                $responseData[] = $nestedData;

            }
        }

        $json_data = array(
            "total" => intval($totalData),
            "filtered" => intval($totalFiltered),
            "data" => $responseData
        );

        return response()->json($json_data);
    }

    public function get($id)
    {
        $admin = Model::with('payoutType')->find($id);

        return $this->successResponse("success", $admin);
    }

    public function createOrUpdate($collection = [])
    {

        $update = [
            "name" => $collection["name"],
            "surname" => $collection["surname"],
            "image_url" => $collection["image_path"],
            "email" => $collection["email"],
            "phone" => $collection["phone"],
            "id_role" => $collection['role_id'] ?? 2,
            "is_requested" => isset($collection["is_requested"]) ? 1 : 0,
            "is_confirmed" => isset($collection["is_requested"]) ? 0 : 1,
            "id_shop" => $collection["shop_id"] ?? null,
            "active" => $collection["active"] ?? 0,
        ];

        if(strlen($collection["password"]) > 3) {
            $update["password"] = Hash::make($collection["password"]);
        }

        $admin = Model::updateOrCreate([
            "id" => $collection["id"] ?? 0
        ], $update);
        if ($admin) {
            $admin->balance()->updateOrCreate(['admin_id' => $admin->id], ['currency' => Currency::pluck('symbol')->first()]);
            $admin->payoutType()->updateOrCreate(['admin_id' => $admin->id],[
                'type' => $collection["payout_type"],
                'value' => $collection["payout_value"]
            ]);
        }
        return $this->successResponse("success", $admin);
    }

    public function activate($id, $activate)
    {
        $admin = Model::findOrFail($id);

        if ($admin) {
            $admin->active = $activate;
        }

        return $this->successResponse("success", []);
    }

    public function getActiveDeliveryBoy($id_shop)
    {

        $delivery_boys = Model::where([
            "id_shop" => $id_shop,
            "id_role" => 3
        ])->get();

        return $this->successResponse("success", $delivery_boys);
    }

    public function deliveryBoyLogin($collection = [])
    {
        $admin = Model::with('balance')->where([
            "id_role" => 3,
            'phone' => $collection['phone']
        ])->first();

        if ($admin == null) {
            return $this->errorResponse("Admin does not exist in our system.");
        } else {
            if (Hash::check($collection['password'], $admin->password)) {
                $admin->push_token = $collection['push_token'];
                $admin->save();

                $transactions =  $admin->transactions()->deliveryDailyBalance();
                $admin = collect($admin)->merge(['daily_balance' => $transactions]);

                return $this->successResponse("success", $admin);
            } else {
                return $this->errorResponse("Password is wrong.");
            }
        }
    }

    public function managerDatatable($collection = [])
    {
        $totalData = Model::where("is_confirmed", 0)->count();
        $totalFiltered = $totalData;

        $defaultLanguage = Languages::where("default", 1)->first();

        $datas = Model::with([
            'shop' => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])->where("is_confirmed", 0)
            ->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->name;
                $nestedData['surname'] = $data->surname;
                $nestedData['image_url'] = $data->image_url;
                $nestedData['phone'] = $data->phone;
                $nestedData['email'] = $data->email;
                $nestedData['active'] = $data->active;
                $nestedData['options'] = [
                    'edit' => 1,
                ];
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable(intval($totalData), intval($totalFiltered), $responseData);
    }

    public function managerStatusEdit($id, $status)
    {
        if($status == 1) {
            Model::find($id)->update([
                "is_confirmed" => 1
            ]);
        } else if($status == 2) {
            Model::find($id)->delete();
        }

        return $this->successResponse("success");
    }

    /**
     * return collection of Admin where role DeliveryBoy
     */
    public function deliveryBoysList($array = [])
    {
        $boys = $this->startCondition()->with('position', 'balance')->filterDeliveryBoys($array);

        $result = $this->model->deliveryBoyOrdersCount($boys);

        return $result;
    }

    /**
     * return object of Admin by DeliveryBoy role ID with dailyBalance
     */
    public function deliveryBoyById($id, $array = [])
    {
        $response = $this->startCondition()->with('position', 'balance')->firstWhere(['id' => $id, 'id_role' => 3]);
        if ($response) {
            $transactions =  $response->transactions()->deliveryDailyBalance($array);
            return collect($response)->merge(['daily_balance' => $transactions]);
        }
        return $response;
    }
}
