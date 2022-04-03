<?php

namespace App\Http\Controllers;

use App\Repositories\Interfaces\TermsInterface;
use Illuminate\Http\Request;


class TermsController extends Controller
{
    private $termsRepository;

    public function __construct(TermsInterface $terms)
    {
        $this->termsRepository = $terms;
    }


    public function save(Request $request){
        return $this->termsRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->termsRepository->datatable($request->all());
    }

    public function delete(Request $request){

    }

    public function get(Request $request){
        return $this->termsRepository->get($request->id_shop);
    }
}
