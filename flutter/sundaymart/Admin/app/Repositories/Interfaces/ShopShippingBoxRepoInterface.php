<?php

namespace App\Repositories\Interfaces;

interface ShopShippingBoxRepoInterface
{
    public function datatable($collection = []);

    public function save($collection = []);

    public function get($id);

    public function active($collection = []);

}
