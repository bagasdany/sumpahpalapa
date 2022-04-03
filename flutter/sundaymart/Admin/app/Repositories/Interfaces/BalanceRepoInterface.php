<?php

namespace App\Repositories\Interfaces;

interface BalanceRepoInterface
{
    public function getUsersBalance($array);

    public function topUpUserBalance($array);

    // public function topUpUserBalance($user_id, $amount = 0);
}
