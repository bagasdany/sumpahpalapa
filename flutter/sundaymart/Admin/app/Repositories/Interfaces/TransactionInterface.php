<?php

namespace App\Repositories\Interfaces;

interface TransactionInterface
{
    public function createOrUpdate($array, $id = null);

    public function transactionsList($params, $shop_id = null);

    public function clientTransactions($client_id, $params);

}
