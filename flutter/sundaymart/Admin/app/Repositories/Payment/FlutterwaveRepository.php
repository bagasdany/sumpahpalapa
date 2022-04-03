<?php

namespace App\Repositories\Payment;

use App\Models\Transaction as Model;
use App\Repositories\CoreRepository;
use App\Repositories\Interfaces\Payment\FlutterwaveInterface;
use App\Traits\ApiResponse;
use GuzzleHttp\Client;
use Http;

class FlutterwaveRepository extends CoreRepository implements FlutterwaveInterface
{
    protected $endpoint = 'https://api.flutterwave.com/v3/payments';
    private $shop;
    use ApiResponse;

    protected function getModelClass()
    {
        return Model::class;
    }

    public function createTransaction($array, $key)
    {
        $headers = ["Authorization" => "Bearer " .$key, "Content-Type" => "application/json"];
        $params = [
            "tx_ref" => $array['trxId'],
            "currency" => 'NGN',
            "redirect_url" => request()->root(). '/api/auth/payment/flutterwave/callback',
            "amount" => $array['amount'],
            "payment_options" => "card",
            "customer" => [
                "email" => $array['email'] ?? " ",
            ],
        ];

        $response = Http::withHeaders($headers)->post($this->endpoint, $params);

        return json_decode($response->body());
    }

    public function updateTransaction($id, $array)
    {
        // TODO: Implement updateTransaction() method.
    }

    public function verifyTransaction($id)
    {
        // TODO: Implement verifyTransaction() method.
    }
}
