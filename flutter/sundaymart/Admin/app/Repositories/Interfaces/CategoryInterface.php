<?php

namespace App\Repositories\Interfaces;

interface CategoryInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function get($id_category);

    public function getCategoryProductsForRest($collection = []);

    public function getCategoriesForRest($collection = []);

    public function datatable($collection = []);

    public function active($shop_id);

    public function parent($shop_id);

    public function setCategoryTax($array = []);
}
