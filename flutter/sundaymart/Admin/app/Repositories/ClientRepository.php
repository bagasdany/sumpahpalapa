<?php

namespace App\Repositories;

use App\Models\Clients;
use App\Models\ClientShop;
use App\Models\Shops as Model;
use App\Repositories\Interfaces\ClientInterface;
use App\Repositories\Interfaces\ShopInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;
use Facade\FlareClient\Http\Client;
use Illuminate\Support\Facades\Hash;
use Storage;

class ClientRepository extends CoreRepository implements ClientInterface
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

    public function get($id_shop)
    {

    }

    public function createOrUpdate($collection = [])
    {
        $token = bin2hex(openssl_random_pseudo_bytes(35));

        Clients::updateOrCreate([
            "id" => $collection["id"]
        ], [
            "name" => $collection["name"],
            "surname" => $collection["surname"],
            "image_url" => $collection["image_path"],
            "email" => $collection["email"],
            "phone" => $collection["phone"],
            "active" => $collection["active"],
            "auth_type" => 1,
            "token" => $token,
            "password" => Hash::make($collection["password"])
        ]);

        return $this->successResponse("success");
    }

    public function delete($id)
    {
        Clients::find($id)->delete();

        return $this->successResponse("success");
    }

    public function loginForRest($collection = [])
    {
        if (isset($collection['phone']) && isset($collection['password'])) {
            $client = Clients::where('phone', '=', $collection['phone'])->first();

            if ($client === null) {
                return $this->errorResponse("Client does not exist in our system.");
            } else {
                if (Hash::check($collection['password'], $client->password)) {
                    $client->push_token = $collection['push_token'];
                    $client->save();

                    return $this->successResponse("success", $client);
                } else {
                    return $this->errorResponse("Password is wrong.");
                }
            }
        }

        if (isset($collection['social_id'])) {
            $client = Clients::where('social_id', '=', $collection['social_id'])->first();

            if ($client === null) {
                return $this->errorResponse("Client does not exist in our system.");
            } else {
                $client->push_token = $collection['push_token'];
                $client->save();

                return $this->successResponse("success", $client);
            }
        }

        return $this->errorResponse("Client does not exist in our system.");
    }

    public function updateUserForRest($collection = [])
    {
        if ($collection['id'] > 0) {
            $updateData = [
                'name' => $collection['name'],
                'surname' => $collection['surname'],
                'phone' => $collection['phone'],
                'email' => $collection['email'],
                'gender' => $collection['gender'],
                'image_url' => $collection['image_url'],
            ];

            if (strlen($collection['password']) >= 8)
                $updateData['password'] = $collection['password'];

            Clients::updateOrCreate(
                [
                    'id' => $collection['id']
                ],
                $updateData
            );
        }

        return $this->successResponse("success", []);
    }

    public function createUserForRest($collection = [])
    {
        if (isset($collection['phone'])) {
            if (Clients::where('phone', '=', $collection['phone'])->exists()) {
                return $this->errorResponse("Client already exist in our system.");
            }
        }

        if (isset($collection['social_id'])) {
            if (Clients::where('social_id', '=', $collection['social_id'])->exists()) {
                return $this->errorResponse("Client already exist in our system.");
            }
        }

        $token = bin2hex(openssl_random_pseudo_bytes(35));

        $client = Clients::create(
            [
                'name' => $collection['name'],
                'surname' => $collection['surname'],
                'phone' => $collection['phone'],
                'email' => $collection['email'],
                'password' => Hash::make($collection['password']),
                'social_id' => $collection['social_id'],
                'auth_type' => $collection['auth_type'],
                'device_type' => $collection['device_type'],
                'token' => $token,
                'push_token' => $collection['push_token'],
                'active' => 1,
            ]);

        return $this->successResponse("success", $client);
    }

    public function getActiveClients()
    {
        $clients = Clients::where("active", 1)->get();

        return $this->successResponse("success", $clients);
    }

    public function getTotalClientsCount()
    {
        $count = Clients::count();

        return $this->successResponse("success", $count);
    }

    public function datatable($collection = [])
    {
        $totalData = Clients::count();
        $totalFiltered = $totalData;

        $datas = Clients::skip($collection["start"])
            ->limit($collection["length"])
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
                $nestedData['auth_type'] = $data->auth_type;
                $nestedData['device_type'] = $data->device_type;
                $nestedData['active'] = $data->active;
                $nestedData['options'] = [
                    'delete' => 1,
                ];
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    /**
     * @param $uuid
     * @param $key
     * @return mixed
     */
    public function deactivate($uuid, $key)
    {
        $clientShop = ClientShop::firstWhere('uuid', $uuid);
        if ($clientShop){
            $clientShop->delete();
            Storage::disk('local')->delete('licensee');
            return response()->json(['status' => true, 'message' => 'Client Shop delete']);
        }
        return response()->json(['status' => false, 'message' => 'Client Shop not found'], 404);
    }

    /**
     * @param $uuid
     * @param $key
     * @return mixed
     */
    public function activate($uuid, $key)
    {
        $server_ip = $_SERVER['SERVER_ADDR'] ?? '127.0.0.1';
        $clientShop = ClientShop::updateOrCreate(['ip_address' => $server_ip], [
            'name' => request()->root(),
            'hash' => Hash::make($key),
            'uuid' => $uuid,
            'active' => 1,
        ]);

        if ($clientShop){
            $clientShop = ClientShop::where('active', 1)->first();
            Storage::disk('local')->put('licensee', $key.':'.$clientShop->ip_address);
            return response()->json(['status' => true, 'data' => $clientShop]);
        }
        return response()->json(['status' => false, 'message' => 'Client Shop not found'], 404);
    }

    public function pointChange2Balance($point){
        return true;
    }

    public function resetPassword($collection) {
        $client = Clients::where('phone', '=', $collection['phone'])->first();

        if ($client === null) {
            return $this->errorResponse("Client does not exist in our system.");
        }

        $client = Clients::where("phone", "=", $collection['phone'])->update(
            [
                'password' => Hash::make($collection['password']),
            ]);

        return $this->successResponse("success", $client);
    }
}
