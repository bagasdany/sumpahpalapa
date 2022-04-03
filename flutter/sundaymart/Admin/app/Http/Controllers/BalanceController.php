<?php

namespace App\Http\Controllers;

use App\Http\Requests\Rest\BalanceTopUpRequest;
use App\Models\ShopPayment;
use App\Repositories\BalanceRepository;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class BalanceController extends Controller
{
    use ApiResponse;
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function getUserBalance(Request $request)
    {
        $result = (new BalanceRepository())->getUsersBalance($request->all());
        if (!$result) {
            return $this->errorResponse('Balance not found');
        }
        return $this->successResponse('Balance found', $result);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function topUpUserBalance(BalanceTopUpRequest $request)
    {
        $shopPayment = ShopPayment::with('payment')->where(['id_shop' => $request->shop_id, 'id_payment' => $request->payment_id])->first();

        if ($shopPayment) {
            switch ($shopPayment->payment->tag){
                case 'stripe':
                    return $this->stripePayment($request->all(), $shopPayment->secret_id);
                case 'paystack':
                    return $this->paystackPayment($request->all(), $shopPayment->secret_id);
                default:
                    return $this->errorResponse('Payment system not found');
            }
        }
        $result = (new BalanceRepository())->topUpUserBalance($request->validated());
        if (!$result) {
            return $this->errorResponse('Balance not found');
        }
        return $this->successResponse('Balance was successfully topped', $result);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
