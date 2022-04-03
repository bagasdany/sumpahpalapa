<?php

namespace App\Repositories\Interfaces;

interface ProductInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function get($id_product);

    public function saveProductComment($collection = []);

    public function getProductExtrasForRest($id_product, $id_lang);

    public function datatable($collection = []);

    public function datatableComment($collection = []);

    public function deleteComment($id);

    public function active($shop_id);

    public function getProductCount();

    public function getMostSoldProducts();
}
