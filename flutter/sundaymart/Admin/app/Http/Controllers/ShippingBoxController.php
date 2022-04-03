<?php

namespace App\Http\Controllers;

use App\Models\ShippingBox;
use App\Repositories\Interfaces\ShippingBoxRepoInterface;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class ShippingBoxController extends Controller
{
    use ApiResponse;
    private $shippingBoxRepository;
    private $model;

    /**
     * @param $shopTransportRepo
     */
    public function __construct(ShippingBox $model, ShippingBoxRepoInterface $shippingBoxRepository)
    {
        $this->shippingBoxRepository = $shippingBoxRepository;
        $this->model = $model;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function datatable(Request $request)
    {
        return $this->shippingBoxRepository->datatable($request->all());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function save(Request $request)
    {
        return $this->shippingBoxRepository->save($request->all());
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function get($id)
    {
        return $this->shippingBoxRepository->get($id);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function delete($id)
    {
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

    /**
     * Display active Shipping Box.
     *
     * @return \Illuminate\Http\Response
     */
    public function active(Request $request)
    {
        return $this->shippingBoxRepository->active($request->all());
    }

}
