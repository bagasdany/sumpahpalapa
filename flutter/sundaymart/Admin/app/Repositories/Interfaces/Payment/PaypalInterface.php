<?php

namespace App\Repositories\Interfaces\Payment;

interface PaypalInterface
{
    public function createOrder($array, $key);

    public function captureOrder($trxId, $key);

    public function checkOrder($array);

}
