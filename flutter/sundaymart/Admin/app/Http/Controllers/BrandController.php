<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Repositories\Interfaces\BrandInterface;
use Illuminate\Http\Request;

class BrandController extends Controller
{
    private $brandRepository;

    public function __construct(BrandInterface $brand)
    {
        $this->brandRepository = $brand;
    }

    public function save(Request $request)
    {
        return $this->brandRepository->createOrUpdate($request->all());
    }


    public function datatable(Request $request)
    {
        return $this->brandRepository->datatable($request->all());
    }

    public function get(Request $request)
    {
        return $this->brandRepository->get($request->id);
    }

    public function active(Request $request)
    {
        return $this->brandRepository->active($request->shop_id);
    }

    public function delete(Request $request)
    {
        return $this->brandRepository->delete($request->id);
    }
}
