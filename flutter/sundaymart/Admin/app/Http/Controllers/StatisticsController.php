<?php

namespace App\Http\Controllers;

use App\Repositories\StatisticsRepository;
use Illuminate\Http\Request;

class StatisticsController extends Controller
{
    // Server information
    public function serverInfo()
    {
        return (new StatisticsRepository())->serverInfo();
    }

    public function commissionStatistics(Request $request)
    {
        return (new StatisticsRepository())->commissionStatistics($request->all());
    }

    public function orderStatistics(Request $request)
    {
        return (new StatisticsRepository())->orderStatistics($request->all());
    }
}
