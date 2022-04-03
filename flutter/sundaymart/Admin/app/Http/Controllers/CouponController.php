<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Coupon;
use App\Models\CouponLanguage;
use App\Models\CouponProducts;
use App\Models\Languages;
use App\Models\Admin;

use App\Repositories\Interfaces\CouponInterface;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class CouponController extends Controller
{
    private $couponRepository;

    public function __construct(CouponInterface $coupon)
    {
        $this->couponRepository = $coupon;
    }

    public function save(Request $request)
    {
        return $this->couponRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->couponRepository->datatable($request->all());
    }

    public function delete(Request $request)
    {
        return $this->couponRepository->delete($request->id);
    }

    public function get(Request $request)
    {
        return $this->couponRepository->get($request->id);
    }

    public function getByName(Request $request)
    {
        return $this->couponRepository->getByName($request->name);
    }
}
