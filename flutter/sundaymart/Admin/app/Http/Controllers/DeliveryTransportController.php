<?php

namespace App\Http\Controllers;

use App\Models\DeliveryTransport;
use App\Repositories\Interfaces\DeliveryTransportRepoInterface;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class DeliveryTransportController extends Controller
{
    use ApiResponse;
    private $deliveryTransport;
    private $model;

    /**
     * @param DeliveryTransportRepoInterface $deliveryTransport
     */
    public function __construct(DeliveryTransportRepoInterface $deliveryTransport, DeliveryTransport $model)
    {
        $this->deliveryTransport = $deliveryTransport;
        $this->model = $model;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function datatable(Request $request)
    {
        return $this->deliveryTransport->datatable($request->all());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function save(Request $request)
    {
        return $this->deliveryTransport->save($request->all());
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function get($id)
    {
        return $this->deliveryTransport->get($id);
    }


    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function destroy($id)
    {
        if ($id) {
            $response = $this->model->find($id);
            if ($response) {
                $count = $response->shopTransports->count();
                if ($count > 0) {
                    return $this->errorResponse('Removal is not possible. This transport is used by many shops');
                }
                $response->delete();
                return $this->successResponse('Record was successfully deleted', $response);
            }
            return $this->errorResponse(['status' => 404, 'error' => 'Record not found']);
        }
        return $this->errorResponse(['status' => 400, 'error' => 'Bad Request']);
    }

    /**
     * Display active Delivery Transport.
     *
     * @return \Illuminate\Http\Response
     */
    public function active(Request $request)
    {
        return $this->deliveryTransport->active($request->all());
    }
}
