<?php

namespace App\Http\Controllers\Payment;

use App\Http\Controllers\Controller;
use App\Models\ShopPayment;
use App\Models\Transaction;
use App\Repositories\Interfaces\Payment\PaypalInterface;
use Illuminate\Http\Request;

class PaypalController extends Controller
{
    private $paypalRepository;

    /**
     * @param PaypalInterface $paypalRepository
     */
    public function __construct(PaypalInterface $paypalRepository)
    {
        $this->paypalRepository = $paypalRepository;
    }

    /**
     * Callback method to change transaction by PayPal ID
     */
    public function paypalCallbackUrl(Request $request)
    {
        \Log::notice('PAYPAL', [$request->all()]);

        if (isset($request->event_type) && $request->event_type === "CHECKOUT.ORDER.APPROVED") {
            // Find transaction
            $transaction = Transaction::firstWhere('payment_sys_trans_id', $request->resource["id"]);
            if ($transaction) {
                // Get Shop payment credentials
                $shopPayment = ShopPayment::with('payment')
                    ->where(['id_shop' => $transaction->shop_id, 'id_payment' => $transaction->payment_sys_id])->first();
                // Generate Basic key
                $basic = base64_encode($shopPayment->key_id . ':' . $shopPayment->secret_id);
                // Send request to capture order payment
                $response = $this->paypalRepository->captureOrder($transaction->payment_sys_trans_id, $basic);
                if ($response && $response->status === "COMPLETED") {
                    $transaction->update([
                        'status' => 2,
                        'status_description' => 'Success',
                    ]);
                } else {
                    $transaction->update([
                        'status' => 3,
                        'status_description' => 'ERROR',
                    ]);
                }
            }
        }
    }
}
