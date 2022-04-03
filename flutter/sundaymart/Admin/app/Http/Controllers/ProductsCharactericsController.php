<?php

namespace App\Http\Controllers;

use App\Repositories\Interfaces\ProductCharactericsInterface;
use Illuminate\Http\Request;

class ProductsCharactericsController extends Controller
{
    private $productCharactericsRepository;

    public function __construct(ProductCharactericsInterface $characterics)
    {
        $this->productCharactericsRepository = $characterics;
    }

    public function save(Request $request)
    {
        return $this->productCharactericsRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->productCharactericsRepository->datatable($request->all());
    }

    public function get(Request $request)
    {
        return $this->productCharactericsRepository->get($request->id);
    }

    public function delete(Request $request)
    {
        return $this->productCharactericsRepository->delete($request->id);
    }
}
