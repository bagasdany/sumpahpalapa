<?php

namespace App\Http\Controllers;

use App\Models\OrderShippingDetail;
use App\Models\ShopTransport;
use App\Repositories\Interfaces\ShopTransportRepoInterface;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class ShopTransportController extends Controller
{
    use ApiResponse;
    private $shopTransportRepo;
    private $model;

    /**
     * @param $shopTransportRepo
     */
    public function __construct(ShopTransport $model, ShopTransportRepoInterface $shopTransportRepo)
    {
        $this->shopTransportRepo = $shopTransportRepo;
        $this->model = $model;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function datatable(Request $request)
    {
        return $this->shopTransportRepo->datatable($request->all());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function save(Request $request)
    {
        return $this->shopTransportRepo->save($request->all());
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function get($id)
    {
        return $this->shopTransportRepo->get($id);
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
                $count = OrderShippingDetail::where('delivery_transport_id', $id)->count();
                if ($count > 0) {
                    return $this->errorResponse('Removal is not possible. This transport is used by many Orders');
                }
                $response->delete();
                return $this->successResponse('Record was successfully deleted', $response);
            }
            return $this->errorResponse(['status' => 404, 'error' => 'Record not found']);
        }
        return $this->errorResponse(['status' => 400, 'error' => 'Bad Request']);
    }

    /**
     * Display active Shop Transport.
     *
     * @return \Illuminate\Http\Response
     */
    public function active(Request $request)
    {
        return $this->shopTransportRepo->active($request->all());
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function default(Request $request)
    {
        return $this->shopTransportRepo->default($request->all());
    }
}
