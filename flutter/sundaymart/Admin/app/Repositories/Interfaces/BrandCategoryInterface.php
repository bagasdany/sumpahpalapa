<?php

namespace App\Repositories\Interfaces;

interface BrandCategoryInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function get($id);

    public function active();

    public function datatable($collection = []);
}
