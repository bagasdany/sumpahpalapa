<?php

namespace App\Repositories\Interfaces;

interface PhonePrefixInterface
{
    public function createOrUpdate($collection = []);

    public function datatable($collection = []);

    public function get($id);

    public function delete($id);

    public function active();
}
