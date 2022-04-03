<?php

namespace App\Http\Controllers\Payment;

use App\Http\Controllers\Controller;
use App\Models\Transaction;
use App\Repositories\Interfaces\Payment\FlutterwaveInterface;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class FlutterwaveController extends Controller
{
    use ApiResponse;
    private $flutterwaveRepository;

    /**
     * @param FlutterwaveInterface $flutterwaveRepository
     */
    public function __construct(FlutterwaveInterface $flutterwaveRepository)
    {
        $this->flutterwaveRepository = $flutterwaveRepository;
    }


    public function verifyTransaction(Request $request){

        return $this->flutterwaveRepository->verifyTransaction($request->all());
    }


    public function flutterwaveCallbackUrl(Request $request) {
        \Log::info('Flutterwave Callback', [$request->all()]);
        $trxId = $request->tx_ref ?? null;
        $status = $request->status ?? null;

        if ($status == 'successful') {
            $transaction = Transaction::where('payment_sys_trans_id', $trxId)->first();
            $transaction->update([
                'status' => 2,
                'status_description' => $status,
            ]);
        } else {
            $transaction = Transaction::where('payment_sys_trans_id', $trxId)->first();
            $transaction->update([
                'status' => 3,
                'status_description' => $status,
            ]);
        }
    }
}
