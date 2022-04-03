<?php

namespace App\Repositories\Payment;

use App\Models\Orders;
use App\Models\ShopPayment;
use App\Models\Transaction as Model;
use App\Repositories\BalanceRepository;
use App\Repositories\CoreRepository;
use App\Repositories\Interfaces\Payment\PaystackRepoInterface;
use App\Repositories\TransactionRepository;
use App\Traits\ApiResponse;
use GuzzleHttp\Client;
use Illuminate\Support\Facades\Http;

class PaystackRepository extends CoreRepository implements PaystackRepoInterface
{
    private $shop;
    use ApiResponse;

    public function __construct()
    {
        parent::__construct();

    }

    protected function getModelClass()
    {
        return Model::class;
    }

    public function createTransaction($array, $key)
    {

        $headers = ['Authorization' => 'Bearer '.$key, 'Content-Type' => 'application/json'];
        $params = [
            "amount" => $array['amount'] * 100,
            "email" => $array['email'] ?? " ",
            "callback_url" =>  request()->root(). '/api/auth/payment/paystack/callback'
        ];

        $response = Http::withHeaders($headers)->post('https://api.paystack.co/transaction/initialize', $params);
        return json_decode($response->body());

    }

    public function verifyTransaction($array)
    {
        $key = [];
        $client = new Client([
            'headers' => [
                'Authorization' => $key->secret_id,
                'Content-Type' => 'application/json',
            ]
        ]);

        $response = $client->get('https://api.paystack.co/transaction/verify/' . $array['transaction_id']);

        return $this->successResponse('Transaction found', $response);
    }

    public function listTransactions()
    {
        // TODO: Implement listTransactions() method.
    }

    public function fetchTransaction()
    {
        // TODO: Implement fetchTransaction() method.
    }

}
