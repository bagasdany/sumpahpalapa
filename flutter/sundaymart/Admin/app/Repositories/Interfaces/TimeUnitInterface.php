<?php

namespace App\Repositories\Interfaces;

interface TimeUnitInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function datatable($collection = []);

    public function get($id);

    public function active($shop_id);
}
