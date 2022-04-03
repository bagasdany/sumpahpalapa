<?php

namespace App\Repositories\Payment;

use App\Models\Transaction as Model;
use App\Repositories\CoreRepository;
use App\Repositories\Interfaces\Payment\RazorpayInterface;
use App\Traits\ApiResponse;
use Illuminate\Support\Facades\Http;

class RazorpayRepository extends CoreRepository implements RazorpayInterface
{

    private $shop;
    use ApiResponse;

    protected function getModelClass()
    {
        return Model::class;
    }

    public function createPayment($array, $key)
    {
        $headers = ['Authorization' => 'Basic '.$key, 'Content-Type' => 'application/json'];
        $params = [
            "amount" => $array['amount'] * 100,
            "currency" => "INR",
            "description" => "Payment for " . $array['type'] . ' #' . $array['id'],
            "customer" => [
                "email" => $array['email'] ?? " ",
            ],
            "notify" => [
                "email" => true
            ],
            "callback_url" =>  request()->root(). '/api/auth/payment/razorpay/callback',
            "callback_method" => "get"
        ];

        $response = Http::withHeaders($headers)->post('https://api.razorpay.com/v1/payment_links', $params);
        return json_decode($response->body());
    }

    public function verifyPayment($transactionId)
    {
        // TODO: Implement verifyPayment() method.
    }
}
