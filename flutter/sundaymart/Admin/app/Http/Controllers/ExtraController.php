<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Languages;
use App\Models\ProductExtras;
use App\Models\ProductExtrasLanguage;
use App\Repositories\Interfaces\ExtraInterface;
use Illuminate\Http\Request;

class ExtraController extends Controller
{
    private $extraRepository;

    public function __construct(ExtraInterface $extra)
    {
        $this->extraRepository = $extra;
    }

    public function datatable(Request $request)
    {
        return $this->extraRepository->datatable($request->all());
    }

    public function save(Request $request)
    {
        return $this->extraRepository->createOrUpdate($request->all());
    }

    public function delete(Request $request)
    {
        return $this->extraRepository->delete($request->id);
    }

    public function get(Request $request)
    {
        return $this->extraRepository->get($request->id);
    }
}
