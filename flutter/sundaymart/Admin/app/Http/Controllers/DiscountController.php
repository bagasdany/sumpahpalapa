<?php

namespace App\Http\Controllers;

use App\Repositories\Interfaces\DiscountInterface;
use Illuminate\Http\Request;

class DiscountController extends Controller
{
    private $discountRepository;

    public function __construct(DiscountInterface $discount)
    {
        $this->discountRepository = $discount;
    }

    public function save(Request $request)
    {
        return $this->discountRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->discountRepository->datatable($request->all());
    }

    public function get(Request $request)
    {
        return $this->discountRepository->get($request->id);
    }

    public function delete(Request $request)
    {
        return $this->discountRepository->delete($request->id);
    }
}
