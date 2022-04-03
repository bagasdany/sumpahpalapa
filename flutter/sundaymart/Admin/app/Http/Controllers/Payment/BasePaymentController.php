<?php

namespace App\Http\Controllers\Payment;

use App\Http\Controllers\Controller;
use App\Http\Requests\Rest\BalanceTopUpRequest;
use App\Models\Orders;
use App\Models\ShopPayment;
use App\Models\Transaction;
use App\Repositories\BalanceRepository;
use App\Repositories\Interfaces\Payment\PaystackRepoInterface;
use App\Repositories\Interfaces\Payment\StripeInterface;
use App\Repositories\Interfaces\ShopPaymentInterface;
use App\Repositories\Interfaces\TransactionInterface;
use App\Repositories\PaymentRepository;
use App\Repositories\TransactionRepository;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class BasePaymentController extends Controller
{
    use ApiResponse;

    /**
     *
     *
     */
    public function payment(BalanceTopUpRequest $request){
        return (new PaymentRepository())->setPayment($request->all());
    }

}
