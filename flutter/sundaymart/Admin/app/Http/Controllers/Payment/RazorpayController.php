<?php

namespace App\Http\Controllers\Payment;

use App\Http\Controllers\Controller;
use App\Models\Transaction;
use App\Repositories\Interfaces\Payment\PaystackRepoInterface;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class RazorpayController extends Controller
{
    use ApiResponse;
    private $razorpayRepository;

    /**
     * @param PaystackRepoInterface $PaystackRepository
     */
    public function __construct(PaystackRepoInterface $paystackRepository)
    {
        $this->paystackRepository = $paystackRepository;
    }

    public function verifyTransaction(Request $request){
        return $this->paystackRepository->verifyTransaction($request->all());
    }


    public function razorpayCallbackUrl(Request $request) {
        \Log::info('Razorpay Callback', [$request->all()]);

        $trxId = $request->razorpay_payment_id ?? null;
        $linkId = $request->razorpay_payment_link_id ?? null;
        $status = $request->razorpay_payment_link_status ?? null;

        if ($status == 'paid') {
            $transaction = Transaction::where('payment_sys_trans_id', $linkId)->first();
            $transaction->update([
                'status' => 2,
                'payment_sys_trans_id' => $trxId,
                'status_description' => "Success",
            ]);
        } else {
            $transaction = Transaction::where('payment_sys_trans_id', $linkId)->first();
            $transaction->update([
                'status' => 3,
                'status_description' => $status,
            ]);
        }
    }
}
