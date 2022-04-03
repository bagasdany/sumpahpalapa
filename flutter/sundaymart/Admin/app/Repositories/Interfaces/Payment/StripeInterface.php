<?php

namespace App\Repositories\Interfaces\Payment;

interface StripeInterface
{
    public function createCustomer($params);

    public function setCardToken($params, $key);

    public function shopBalanceCharge($params, $key);

    public function stripePayment($params, $key);
}
