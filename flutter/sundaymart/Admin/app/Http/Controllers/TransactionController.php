<?php

namespace App\Http\Controllers;

use App\Repositories\Interfaces\TransactionInterface;
use Illuminate\Http\Request;

class TransactionController extends Controller
{

    private $transactionRepository;

    /**
     * @param TransactionInterface $transactionRepository
     */
    public function __construct(TransactionInterface $transactionRepository)
    {
        $this->transactionRepository = $transactionRepository;
    }

    public function datatable(Request $request){
        return $this->transactionRepository->transactionsList($request->all());
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function shopTransaction(Request $request, $id)
    {
        return $this->transactionRepository->transactionsList($request->all(), $id);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function clientTransaction(Request $request, $id)
    {
        return $this->transactionRepository->clientTransactions($id, $request->all());
    }

}
