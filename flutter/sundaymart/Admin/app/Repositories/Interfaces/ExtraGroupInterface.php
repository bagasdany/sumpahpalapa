<?php

namespace App\Repositories\Interfaces;

interface ExtraGroupInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function get($id);

    public function getExtraGroupType();

    public function datatable($collection = []);

    public function active($product_id);
}
