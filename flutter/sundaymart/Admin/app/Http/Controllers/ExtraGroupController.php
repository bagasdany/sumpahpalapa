<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\ExtrasGroupTypes;
use App\Models\Languages;
use App\Models\ProductExtrasGroup;
use App\Models\ProductExtrasGroupLanguage;
use App\Repositories\Interfaces\ExtraGroupInterface;
use App\Repositories\Interfaces\ExtraInterface;
use Illuminate\Http\Request;

class ExtraGroupController extends Controller
{
    private $extraGroupRepository;

    public function __construct(ExtraGroupInterface $extraGroup)
    {
        $this->extraGroupRepository = $extraGroup;
    }

    public function types(Request $request)
    {
        return $this->extraGroupRepository->getExtraGroupType();
    }

    public function save(Request $request)
    {
        return $this->extraGroupRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->extraGroupRepository->datatable($request->all());
    }

    public function delete(Request $request)
    {
        return $this->extraGroupRepository->delete($request->id);
    }

    public function get(Request $request)
    {
        return $this->extraGroupRepository->get($request->id);
    }

    public function active(Request $request)
    {
        return $this->extraGroupRepository->active($request->product_id);
    }
}
