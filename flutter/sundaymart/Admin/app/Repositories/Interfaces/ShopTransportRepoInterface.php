<?php

namespace App\Repositories\Interfaces;

interface ShopTransportRepoInterface
{
    public function datatable($collection = []);

    public function save($collection = []);

    public function get($id);

    public function active($collection = []);

    public function default($collection = []);

}
