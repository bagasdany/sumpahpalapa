<?php

namespace App\Repositories\Interfaces;

interface ShopPaymentInterface
{
    public function createOrUpdate($collection = []);

    public function datatable($collection = []);

    public function get($shop_id, $payment_id);

    public function delete($id);

    public function active($collection = []);

    public function paymentForBalanceTopup($shop_id);
}
