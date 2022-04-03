<?php

namespace App\Http\Controllers;

use App\Models\Point;
use App\Repositories\Interfaces\PointInterface;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class PointController extends Controller
{
    use ApiResponse;
    private $model, $pointRepository;

    /**
     * @param $model
     * @param $pointRepository
     */
    public function __construct(Point $model, PointInterface $pointRepository)
    {
        $this->model = $model;
        $this->pointRepository = $pointRepository;
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function datatable(Request $request)
    {
        return $this->pointRepository->datatable($request->all());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function save(Request $request)
    {
        return $this->pointRepository->createOrUpdate($request->all());
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function get($id)
    {
        return $this->pointRepository->get($id);
    }

    /**
     * Get active points.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function active(Request $request)
    {
        return $this->pointRepository->active($request->all());
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


    public function pointRateSave(Request $request){
        return $this->pointRepository->pointRateSave($request->all());
    }

    public function pointRateShow(){
        return $this->pointRepository->pointRateShow();
    }
}
