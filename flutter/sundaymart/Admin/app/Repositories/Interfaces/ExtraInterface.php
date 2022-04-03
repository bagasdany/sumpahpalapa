<?php

namespace App\Repositories\Interfaces;

interface ExtraInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function get($id);

    public function datatable($collection = []);
}
