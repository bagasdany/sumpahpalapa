<?php

namespace App\Http\Controllers\Mobile;

use App\Http\Controllers\Controller;
use App\Repositories\Interfaces\TermsInterface;
use Illuminate\Http\Request;

class TermsController extends Controller
{
    private $termsRepository;

    public function __construct(TermsInterface $terms)
    {
        $this->termsRepository = $terms;
    }

    public function terms(Request $request)
    {
        return $this->termsRepository->get($request->id_shop);
    }
}
