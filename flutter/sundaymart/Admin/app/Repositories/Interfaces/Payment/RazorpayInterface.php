<?php

namespace App\Repositories\Interfaces\Payment;

interface RazorpayInterface
{
    public function createPayment($array, $key);

    public function verifyPayment($transactionId);
}
