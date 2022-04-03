<?php

namespace App\Repositories\Payment;

use App\Models\Transaction as Model;
use App\Traits\ApiResponse;
use Illuminate\Support\Facades\Http;

class SeerafaRepository extends \App\Repositories\CoreRepository implements \App\Repositories\Interfaces\Payment\SeerafaInterface
{
    use ApiResponse;
    protected $url = 'http://dev-api.seerafa.com/pg';

    protected function getModelClass()
    {
        return Model::class;
    }

    public function loginOTP($array, $key)
    {

        $headers = ['X-key' => $key, 'Content-Type' => 'multipart/form-data'];

        $response = Http::withHeaders($headers)
            ->post( $this->url . '/account/generateLoginOTP?mobile_number=' . $array['phone'] . '&request_id=' . $array['trxId']);
        return json_decode($response->body());
    }

    public function loginConfirm($array,  $private_key, $secret_id)
    {
        $headers = ['X-key' => $private_key, 'Content-Type' => 'multipart/form-data'];
        $checksum = hash('sha256',
            $array['request_id'] . '|' . $array['phone'] . '|' . $array['otp_code'] . '|' . $secret_id);

        $response = Http::withHeaders($headers)
            ->post($this->url . '/account/loginOTP?' . 'request_id=' . $array['request_id'] . '&mobile_number=' . $array['phone'] . '&otp=' . $array['otp_code'] . '&checksum=' . $checksum);
        return json_decode($response->body());

    }

    public function transactionOTP($array, $key)
    {
        $headers = ['X-key' => $key, 'Content-Type' => 'multipart/form-data', 'Authorization' => 'Bearer '.$array['token']];

        $params = [
            "request_id" => $array['request_id'],
            "amount" => $array['amount'],
        ];

        $response = Http::withHeaders($headers)
            ->post($this->url . '/account/generateTransactionOTP?' . 'request_id=' . $array['request_id'] . '&amount=' . $array['amount']);
        return json_decode($response->body());

    }

    public function transactionConfirm($array, $private_key, $secret_id)
    {
        $headers = ['X-key' => $private_key, 'Content-Type' => 'multipart/form-data', 'Authorization' => 'Bearer '.$array['token']];

        $remarks = 'Payment from client';
        $checksum = hash('sha256',
            $array['request_id'] . '|' . $array['amount'] . '|' . $array['otp_code'] . '|' . $remarks . '|' . $secret_id);

        $response = Http::withHeaders($headers)
            ->post($this->url . '/wallet/confirmPayment?' . 'request_id=' . $array['request_id'] . '&amount=' . $array['amount'] .
                '&otp=' . $array['otp_code'] . '&remarks=' . $remarks . '&checksum=' . $checksum);
        return json_decode($response->body());

    }
}
