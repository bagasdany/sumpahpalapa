<?php

namespace App\Http\Controllers\Backend\Admin;

use App\Http\Controllers\Controller;
use App\Models\ShopDelivery;
use App\Repositories\Interfaces\ShopDeliveryInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;
use App\Transformers\ShopDeliveryTransformer;
use Illuminate\Http\Request;

class ShopDeliveryController extends Controller
{
    use ApiResponse;
    private $model, $shopDeliveryRepository;

    public function __construct(ShopDelivery $model, ShopDeliveryInterface $shopDelivery)
    {
        $this->model = $model;
        $this->shopDeliveryRepository = $shopDelivery;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function datatable(Request $request)
    {
        return $this->shopDeliveryRepository->datatable($request->all());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function save(Request $request)
    {
        $response = $this->shopDeliveryRepository->save($request->all());
        if ($response) {
            return $this->successResponse('ShopDelivery was successfully saved', (new ShopDeliveryTransformer)->transform($response));
        }
        return $this->errorResponse('Error during saving');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function get($id)
    {
        try {
            $response = $this->model->with('deliveryType.language')->find($id);
            if ($response) {
                return $this->successResponse('Record was successfully found', $response);
            }
            return $this->errorResponse(['status' => 404, 'error' => 'Record not found']);
        } catch (\Exception $e){
            return $this->errorResponse($e->getMessage());
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function delete()
    {
        $id = $_GET['id'] ?? null;
        if ($id) {
            $response = $this->model->find($id);
            if ($response) {
                $response->delete();
                return $this->successResponse('Record was successfully deleted', $response);
            }
            return $this->errorResponse(['status' => 404, 'error' => 'Record not found']);
        }
        return $this->errorResponse(['status' => 400, 'error' => 'Bad Request']);
    }


    public function changeStatus(Request $request){
        $response = $this->model->find($request->id);
        if ($response) {
            $response->update(['active' => $request->active]);
            return $this->successResponse('Status was successfully updated', $response);
        }
        return $this->errorResponse(['status' => 404, 'error' => 'Record not found']);
    }

    /**
     * Get Shop Delivery by ShopID
     *
     * @param $shop_id
     * @return \Illuminate\Http\JsonResponse
     */
    public function getByShopId($shop_id, Request $request){

        return $this->shopDeliveryRepository->getByShopId($shop_id, $request->all());

    }

    public function getActiveShopDeliveries($shop_id, Request $request) {
        return $this->shopDeliveryRepository->getActiveShopDeliveries($shop_id);
    }
}
