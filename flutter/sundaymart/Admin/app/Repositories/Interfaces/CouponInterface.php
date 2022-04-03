<?php

namespace App\Repositories\Interfaces;

interface CouponInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function get($id);

    public function getCouponProducts($collection = []);

    public function datatable($collection = []);

    public function getByName($name);
}
