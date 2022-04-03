<?php

namespace App\Repositories\Interfaces;

interface UnitInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function datatable($collection = []);

    public function get($id);

    public function active();
}
