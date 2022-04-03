<?php

namespace App\Repositories\Interfaces;

interface ShopCurrencyInterface
{
    public function get($id);

    public function delete($id);

    public function datatable($collection = []);

    public function createOrUpdate($collection = []);

    public function getShopCurrencies($shop_id);

    public function change($collection = []);
}
