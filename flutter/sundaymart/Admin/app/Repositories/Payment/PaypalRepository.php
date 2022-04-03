<?php

namespace App\Repositories\Payment;

use App\Models\Transaction as Model;
use GuzzleHttp\Client;
use GuzzleHttp\RequestOptions;
use Http;

class PaypalRepository extends \App\Repositories\CoreRepository implements \App\Repositories\Interfaces\Payment\PaypalInterface
{
    protected $endpoint = 'https://api.sandbox.paypal.com/v2/checkout/orders';
    protected $authEndpoint = 'https://api-m.sandbox.paypal.com/v1/oauth2/token';

    protected function getModelClass()
    {
        return Model::class;
    }

    public function createOrder($array, $key)
    {

        $token = $this->getAccessToken($key);
        if ($token->access_token) {
            try {
                $headers = [
                    "Authorization" => "Bearer " .$token->access_token,
                    "Content-Type" => "application/json"
                ];
                $client = new Client(['headers' => $headers]);

                $params = [
                    "intent" => "CAPTURE",
                    "purchase_units" => [
                        [
                            "amount" => [
                                "currency_code" => "USD",
                                "value" => $array['amount']
                            ],
                        ],
                    ],
                ];

                $response = $client->post($this->endpoint, ['json' => $params]);
                return json_decode($response->getBody());
            } catch (\Exception $exception){
                return $exception->getMessage();
            }
        }
        return $token;
    }

    public function captureOrder($trxId, $key)
    {
        $token = $this->getAccessToken($key);
        if ($token->access_token) {
            try {
                $headers = [
                    "Authorization" => "Bearer " .$token->access_token,
                    "Content-Type" => "application/json"
                ];
                $client = new Client(['headers' => $headers]);

                $response = $client->post($this->endpoint . '/' . $trxId . '/capture');
                return json_decode($response->getBody());
            } catch (\Exception $exception){
                return $exception->getMessage();
            }
        }
        return $token;
    }

    public function checkOrder($array)
    {
        // TODO: Implement checkOrder() method.
    }

    private function getAccessToken($key){

        $headers = ["Accept-Language" => "en_US", "Authorization" => "Basic " .$key];
        $client = new Client(['headers' => $headers]);
        try {
            $response = $client->post($this->authEndpoint, ['query' => ['grant_type' => 'client_credentials']]);
            return json_decode($response->getBody());

        } catch (\Exception $exception){
            return $exception->getMessage();
        }

    }
}
