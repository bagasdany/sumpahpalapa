<?php

namespace App\Repositories\Interfaces;

interface StatisticsRepoInterface
{
    public function serverInfo();

    public function orderStatistics($array);

    public function commissionStatistics($array);
}
