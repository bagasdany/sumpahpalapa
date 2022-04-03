<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\PaymentsMethod;
use App\Models\PaymentsStatus;
use App\Repositories\Interfaces\PaymentInterface;
use Illuminate\Http\Request;

class PaymentController extends Controller
{
    private $paymentRepository;

    public function __construct(PaymentInterface $payment)
    {
        $this->paymentRepository = $payment;
    }

    public function methodDatatable(Request $request)
    {
        return $this->paymentRepository->methodDatatable($request->all());
    }

    public function statusDatatable(Request $request)
    {
        return $this->paymentRepository->statusDatatable($request->all());
    }

    public function activeStatus()
    {
        return $this->paymentRepository->getActiveStatus();
    }

    public function activeMethod()
    {
        return $this->paymentRepository->getActiveMethod();
    }
}
