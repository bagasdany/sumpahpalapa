<?php

namespace App\Repositories\Interfaces;

interface FaqInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function get($id);

    public function getForRest($id_shop, $id_lang);

    public function datatable($collection = []);
}
