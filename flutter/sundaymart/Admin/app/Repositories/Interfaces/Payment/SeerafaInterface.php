<?php

namespace App\Repositories\Interfaces\Payment;

interface SeerafaInterface
{
    public function loginOTP($array, $key);

    public function loginConfirm($array,  $private_key, $secret_id);

    public function transactionOTP($array, $key);

    public function transactionConfirm($array,  $private_key, $secret_id);
}
