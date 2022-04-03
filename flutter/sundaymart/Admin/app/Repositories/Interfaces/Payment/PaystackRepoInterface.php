<?php

namespace App\Repositories\Interfaces\Payment;

interface PaystackRepoInterface
{
    public function createTransaction($array, $key);

    public function verifyTransaction($array);

    public function listTransactions();

    public function fetchTransaction();

}
