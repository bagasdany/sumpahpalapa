<?php

namespace App\Repositories\Interfaces;

interface TermsInterface
{
    public function createOrUpdate($collection = []);

    public function datatable($collection = []);

    public function get($id);

    public function delete($id);
}
