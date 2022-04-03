<?php

namespace App\Repositories\Interfaces;

use App\Models\ShopDelivery;

interface ShopInterface
{
    public function getShopCategories($id_lang);

    public function getShopUser($id_shop);

    public function getTimeUnitsForRest($id_shop);

    public function getShopsForRest($collection = []);

    public function createOrUpdate($collection = []);

    public function get($id);

    public function delete($id);

    public function datatable($collection = []);

    public function licensee();

    public function active();

    public function getShopCount();

    public function activate($key);

    public function getShopForRest($shop_id, $lang);

}
