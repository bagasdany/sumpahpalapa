<?php

namespace App\Http\Controllers;

use App\Models\Tax;
use App\Repositories\Interfaces\TaxRepoInterface;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class TaxController extends Controller
{
    use ApiResponse;
    private $model, $taxRepository;

    /**
     * @param TaxRepoInterface $taxRepository
     */
    public function __construct(Tax $model, TaxRepoInterface $taxRepository)
    {
        $this->taxRepository = $taxRepository;
        $this->model = $model;
    }


    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function datatable(Request $request)
    {
        return $this->taxRepository->datatable($request->all());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function save(Request $request)
    {
        return $this->taxRepository->updateOrCreate($request->all());
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function get($id)
    {
        return $this->taxRepository->get($id);
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
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function shopActiveTaxes($shop_id, Request $request)
    {
        return $this->taxRepository->active($shop_id, $request->all());
    }

    /**
     * Get Shop default Taxes.
     * @return \Illuminate\Http\Response
     */
    public function shopDefaultTaxes($shop_id, Request $request)
    {
        return $this->taxRepository->getDefaultTaxes($shop_id);
    }

}
