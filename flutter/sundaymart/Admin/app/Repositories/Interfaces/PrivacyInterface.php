<?php

namespace App\Repositories\Interfaces;

interface PrivacyInterface
{
    public function createOrUpdate($collection = []);

    public function datatable($collection = []);

    public function get($id);

    public function delete($id);
}
