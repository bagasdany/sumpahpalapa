<?php

namespace App\Repositories\Interfaces;

interface ShopCategoryInterface
{
    public function createOrUpdate($collection = []);

    public function get($id);

    public function delete($id);

    public function active();

    public function datatable($collection = []);
}
