<?php

namespace App\Http\Controllers\Payment;

use App\Http\Controllers\Controller;
use App\Models\Transaction;
use App\Repositories\Interfaces\Payment\PaystackRepoInterface;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use Paystack;
use Redirect;
use URL;

class PaystackController extends Controller
{
    use ApiResponse;
    private $paystackRepository;

    /**
     * @param PaystackRepoInterface $paystackRepository
     */
    public function __construct(PaystackRepoInterface $paystackRepository)
    {
        $this->paystackRepository = $paystackRepository;
    }

    public function verifyTransaction(Request $request){

        return $this->paystackRepository->verifyTransaction($request->all());
    }


    public function paystackCallbackUrl(Request $request){
        \Log::info('Paystack Callback', [$request->all()]);
        $trxId = $request->reference ?? null;

        if ($trxId) {
            $transaction = Transaction::where('payment_sys_trans_id', $trxId)->first();
            $transaction->update([
                'status' => 2,
                'status_description' => 'Successfully',
            ]);
        }
        return response()->json('ok');
    }
}
