<?php

namespace App\Repositories\Interfaces;

interface AddressInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function get($id_shop);

    public function datatable($collection = []);

    public function active($client_id);
}
