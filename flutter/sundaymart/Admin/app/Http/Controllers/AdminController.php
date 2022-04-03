<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Admin;
use App\Models\Languages;
use App\Models\ShopsLanguage;
use App\Repositories\Interfaces\AdminInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AdminController extends Controller
{
    use ApiResponse;
    use DatatableResponse;
    private $model, $adminRepository;

    public function __construct(Admin $model, AdminInterface $admin)
    {
        $this->adminRepository = $admin;
        $this->model = $model;
    }

    public function activate(Request $request)
    {
        return $this->adminRepository->activate($request->id, $request->activate);
    }


    public function create(Request $request)
    {
        return $this->adminRepository->createOrUpdate($request->all());
    }


    public function save(Request $request)
    {
       return $this->adminRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->adminRepository->datatable($request->all());
    }

    public function delete(Request $request)
    {
        return $this->adminRepository->delete($request->id);
    }

    public function get(Request $request)
    {
        return $this->adminRepository->get($request->id);
    }

    public function deliveryBoyActive(Request $request)
    {
        return $this->adminRepository->getActiveDeliveryBoy($request->shop_id);
    }

    public function deliveryBoyLogin(Request $request) {
        return $this->adminRepository->deliveryBoyLogin($request->all());
    }

    public function managerDatatable(Request $request) {
        return $this->adminRepository->managerDatatable($request->all());
    }

    public function managerEdit(Request $request) {
        return $this->adminRepository->managerStatusEdit($request->id, $request->status);
    }

    public function updateDeliveryBoy(Request $request) {
        return $this->adminRepository->createOrUpdate($request->all());
    }

    public function deliveryBoys(Request $request)
    {
        $response = $this->adminRepository->deliveryBoysList($request->all());
        if ($response) {

            if(isset($request["start"]) && isset($request["length"])) {
                $total = $this->model->where("id_role", 3)->count();

                return $this->responseJsonDatatable($total, count($response), $response);
            } else
                return $this->successResponse("List of DeliveryBoys", $response);

        }
        return $this->errorResponse(['status' => 404, 'message' => 'Collection are empty']);
    }

    public function deliveryBoyById(Request $request, $id)
    {
        $response = $this->adminRepository->deliveryBoyById($id, $request->all());
        if ($response) {
            return $this->successResponse("DeliveryBoy successfully found", $response);
        }
        return $this->errorResponse(['status' => 404, 'message' => 'Record not found']);
    }

    public function setOfflineStatus(Request $request){
        $response = $this->model->find($request->admin_id);
        if ($response) {
            $response->update(['offline' => $request->status ?? 0]);
        }
        return $response;
    }
}
