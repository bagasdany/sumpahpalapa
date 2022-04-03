<?php

namespace App\Repositories\Interfaces;

interface CurrencyInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function get($id);

    public function getAllActiveCurrenciesForRest($collection = []);

    public function active();

    public function datatable($collection = []);

    public function default();

}
