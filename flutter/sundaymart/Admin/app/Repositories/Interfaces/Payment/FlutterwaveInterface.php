<?php

namespace App\Repositories\Interfaces\Payment;

interface FlutterwaveInterface
{
    public function createTransaction($array, $key);

    public function updateTransaction($id, $array);

    public function verifyTransaction($id);

}
