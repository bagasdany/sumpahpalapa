<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Languages;
use App\Models\Units;
use App\Models\UnitsLanguage;
use App\Repositories\Interfaces\UnitInterface;
use Illuminate\Http\Request;

class UnitController extends Controller
{
    private $unitRepository;

    public function __construct(UnitInterface $unit)
    {
        $this->unitRepository = $unit;
    }

    public function save(Request $request)
    {
        return $this->unitRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->unitRepository->datatable($request->all());
    }

    public function get(Request $request)
    {
        return $this->unitRepository->get($request->id);
    }

    public function delete(Request $request)
    {
        return $this->unitRepository->delete($request->id);
    }

    public function active(Request $request)
    {
        return $this->unitRepository->active();
    }
}
