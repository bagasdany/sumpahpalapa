<?php

namespace App\Repositories\Interfaces;

interface ShopDeliveryInterface
{
    public function datatable($collection = []);

    public function save($params);

    public function getByShopId($shop_id, $collection = []);

    public function getActiveShopDeliveries($shop_id);
}
