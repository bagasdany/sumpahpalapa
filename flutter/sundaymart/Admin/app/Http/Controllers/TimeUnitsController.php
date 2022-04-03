<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Brands;
use App\Models\Languages;
use App\Models\Shops;
use App\Models\TimeUnits;
use App\Repositories\Interfaces\TimeUnitInterface;
use Illuminate\Http\Request;

class TimeUnitsController extends Controller
{
    private $timeUnitRepository;

    public function __construct(TimeUnitInterface $timeUnit)
    {
        $this->timeUnitRepository = $timeUnit;
    }

    public function save(Request $request)
    {
        return $this->timeUnitRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->timeUnitRepository->datatable($request->all());
    }

    public function get(Request $request)
    {
        return $this->timeUnitRepository->get($request->id);
    }

    public function delete(Request $request)
    {
        return $this->timeUnitRepository->delete($request->id);
    }

    public function active(Request $request)
    {
        return $this->timeUnitRepository->active($request->shop_id);
    }
}
