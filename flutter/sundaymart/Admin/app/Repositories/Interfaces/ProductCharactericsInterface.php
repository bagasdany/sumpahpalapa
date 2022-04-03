<?php

namespace App\Repositories\Interfaces;

interface ProductCharactericsInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function get($id);

    public function datatable($collection = []);
}
