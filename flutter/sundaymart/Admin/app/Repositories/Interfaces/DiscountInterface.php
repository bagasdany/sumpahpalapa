<?php

namespace App\Repositories\Interfaces;

interface DiscountInterface
{
    public function getDiscountProducts($collection = []);

    public function delete($id);

    public function get($id);

    public function createOrUpdate($collection = []);

    public function datatable($collection = []);
}
