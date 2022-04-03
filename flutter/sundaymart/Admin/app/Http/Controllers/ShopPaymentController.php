<?php

namespace App\Http\Controllers;

use App\Repositories\Interfaces\ShopPaymentInterface;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\ShopPayment;
use App\Models\Languages;

class ShopPaymentController extends Controller
{
    private $shopPaymentRepository;

    public function __construct(ShopPaymentInterface $shopPayment)
    {
        $this->shopPaymentRepository = $shopPayment;
    }

    public function save(Request $request)
    {
        return $this->shopPaymentRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->shopPaymentRepository->datatable($request->all());
    }

    public function get(Request $request)
    {
        return $this->shopPaymentRepository->get($request->shop_id, $request->payment_id);
    }

    public function delete(Request $request)
    {
        return $this->shopPaymentRepository->delete($request->id);
    }

    public function active(Request $request)
    {
        return $this->shopPaymentRepository->active($request->all());
    }
}
