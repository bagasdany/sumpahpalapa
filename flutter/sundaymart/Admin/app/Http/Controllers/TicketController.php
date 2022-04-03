<?php

namespace App\Http\Controllers;

use App\Models\Ticket;
use App\Repositories\Interfaces\TicketRepoInterface;
use Illuminate\Http\Request;

class TicketController extends Controller
{
    private $ticketRepository;
    private $model;

    public function __construct(Ticket $model, TicketRepoInterface $ticketRepository)
    {
        $this->ticketRepository = $ticketRepository;
        $this->model = $model;
    }

    public function datatable(Request $request){
        return $this->ticketRepository->datatable($request->all());
    }

    public function save(Request $request){
        return $this->ticketRepository->createOrUpdate($request->all());

    }

    public function get($id){
        return $this->ticketRepository->get($id, true);
    }

    public function delete($id){
        if ($id) {
            $response = $this->model->find($id);
            if ($response) {
                $response->delete();
                return $this->successResponse('Record was successfully deleted', $response);
            }
            return $this->errorResponse(['status' => 404, 'error' => 'Record not found']);
        }
        return $this->errorResponse(['status' => 400, 'error' => 'Bad Request']);
    }

    public function changeStatus($id, Request $request){
        return $this->ticketRepository->changeStatus($id, $request->status);
    }

    public function getTicketProperties(){
        return [
            'statuses' => $this->model->getTicketStatuses(),
            'types' => $this->model->ticket_types
        ];
    }
}
