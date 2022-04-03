<?php

namespace App\Http\Controllers;

use App\Repositories\Interfaces\PaymentInterface;
use Illuminate\Http\Request;

class PaymentsController extends Controller
{
    private $paymentRepository;

    public function __construct(PaymentInterface $payment)
    {
        $this->paymentRepository = $payment;
    }

    public function save(Request $request)
    {
       return $this->paymentRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->paymentRepository->datatable($request->all());
    }

    public function get(Request $request)
    {
        return $this->paymentRepository->get($request->id);
    }


    public function delete(Request $request)
    {
       return $this->paymentRepository->delete($request->id);
    }

    public function active() {
        return $this->paymentRepository->active();
    }

    public function paymentAttributesSave(Request $request){
        return $this->paymentRepository->paymentAttributesSave($request->all());
    }

    public function paymentAttributesGet($id){
        return $this->paymentRepository->paymentAttributesGet($id);
    }
}
