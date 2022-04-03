<?php


namespace App\Repositories;

use App\Models\Admin;
use App\Models\Clients;
use App\Models\Notifications as Model;
use App\Repositories\Interfaces\NotificationInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;
use App\Traits\SendNotification;

class NotificationRepository extends CoreRepository implements NotificationInterface
{
    use ApiResponse;
    use DatatableResponse;
    use SendNotification;

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

        return $this->successResponse("success");
    }

    public function createOrUpdate($collection = [])
    {
        try {
            Model::updateOrCreate([
                "id" => $collection["id"]
            ], [
                "title" => $collection["title"],
                "description" => $collection["description"],
                "has_image" => $collection["has_image"],
                "image_url" => $collection["image_url"],
                "active" => $collection["active"],
                "id_shop" => $collection["id_shop"],
                "id_user" => Admin::getUserId(),
                "is_sent" => 0,
                "send_time" => $collection["send_time"],
            ]);

            return $this->successResponse("success");
        } catch (\Exception $e) {
            return $this->errorResponse($e->getMessage());
        }
    }

    public function get($id)
    {
        $notification = Model::find($id);

        return $this->successResponse("success", $notification);
    }

    public function getAllNotifications($collection = [])
    {
        $notifications = Model::with([
            "shop.language" => function ($query) use ($collection) {
                $query->id_lang = $collection['id_lang'];
            }
        ])->where([
            'id_shop' => $collection['id_shop'],
            'active' => 1,
            ["send_time", "<=", date("Y-m-d H:i:s", strtotime($collection['now']))],
            ["send_time", ">=", date("Y-m-d H:i:s", strtotime($collection['date']))]
        ])->get();

        return $this->successResponse("success", $notifications);
    }

    public function datatable($collection = [])
    {
        $id_shop = Admin::getUserShopId();
        if ($id_shop == -1)
            $totalData = Model::count();
        else
            $totalData = Model::where("id_shop", $id_shop)->count();

        $totalFiltered = $totalData;

        $datas = Model::where('active', 1);

        if ($id_shop != -1)
            $datas = $datas->where("id_shop", $id_shop);

        $datas = $datas->skip($collection['start'])
            ->take($collection['length'])
            ->get();


        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['title'] = $data->title;
                $nestedData['description'] = $data->description;
                $nestedData['has_image'] = $data->has_image;
                $nestedData['image_url'] = $data->image_url;
                $nestedData['active'] = $data->active;
                $nestedData['is_sent'] = $data->is_sent;
                $nestedData['send_time'] = $data->send_time;
                $nestedData['options'] = [
                    'delete' => 1,
                    'edit' => 1
                ];

                if ($data->is_sent == 0)
                    $nestedData['options']['send'] = 1;

                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function send($id) {
        $notification = Model::findOrFail($id);
        if ($notification) {
            $clients = Clients::select("push_token")->where([
                "active" => 1,
            ])->whereNotNull("push_token")->get();

            $clientsIds = [];
            foreach ($clients as $client) {
                $clientsIds[] = $client->push_token;
            }

            if(count($clients) > 0) {
                $result = $this->sendNotification($clientsIds, $notification->title);

                $notification->is_sent = 1;
                $notification->save();
            }
        }

        return $this->successResponse("success", $result);
    }
}
