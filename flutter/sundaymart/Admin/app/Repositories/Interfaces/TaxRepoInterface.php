<?php

namespace App\Repositories\Interfaces;

interface TaxRepoInterface
{
    public function datatable($collection = []);

    public function updateOrCreate($array = []);

    public function get($id);

    public function active($shop_id, $array = []);

    public function getDefaultTaxes($shop_id, $array = []);

}
