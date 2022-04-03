<?php

namespace App\Http\Controllers\Mobile;

use App\Http\Controllers\Controller;
use App\Repositories\Interfaces\TicketRepoInterface;
use Illuminate\Http\Request;

class TicketController extends Controller
{
    private $ticketRepository;

    public function __construct(TicketRepoInterface $ticketRepository)
    {
        $this->ticketRepository = $ticketRepository;
    }

    public function createTicket(Request $request){
        return $this->ticketRepository->createOrUpdate($request->all());
    }

    public function getTicket($id){
        return $this->ticketRepository->get($id, false);
    }
}
