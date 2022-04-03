<?php

namespace App\Http\Controllers\Backend\Admin;

use App\Http\Controllers\Controller;
use App\Models\DeliveryType;
use App\Repositories\Interfaces\DeliveryInterface;
use App\Traits\ApiResponse;
use App\Transformers\DeliveryTypeTransformer;
use Illuminate\Http\Request;

class DeliveryTypeController extends Controller
{
    use ApiResponse;
    private $model;
    private $deliveryRepository;

    /**
     * @param $model
     * @param $deliveryRepository
     */
    public function __construct(DeliveryType $model, DeliveryInterface $deliveryRepository)
    {
        $this->model = $model;
        $this->deliveryRepository = $deliveryRepository;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function datatable(Request $request)
    {
        return $this->deliveryRepository->datatable($request->all());
    }

    /**
     * Store a newly created or update resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function save(Request $request)
    {

        $response = $this->deliveryRepository->save($request->all());

        if ($response) {
            return $this->successResponse('DeliveryType was successfully saved', $response);
        }
        return $this->errorResponse('Error during save');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function get($id)
    {
         $response = $this->model->with('languages', 'languages.language')->find($id);
         if ($response) {
             return $this->successResponse('Record #' . $id . ' successfully found', $response);
         }
         return $this->errorResponse('Record not found');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function delete($id)
    {
        $response = $this->model->find($id);
        if ($response) {
            $response->delete();
            return $this->successResponse('Record was successfully deleted', true);
        }
        return $this->errorResponse('Record not found');
    }

    public function active(){
        return $this->model->with('language')->where('status', 1)->get();
    }
}
