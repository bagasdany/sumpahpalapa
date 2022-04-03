<?php

namespace App\Repositories;

use App\Traits\ApiResponse;
use App\Models\Ticket as Model;
use App\Traits\DatatableResponse;

class TicketRepository extends CoreRepository implements Interfaces\TicketRepoInterface
{
    use ApiResponse;
    use DatatableResponse;

    protected function getModelClass()
    {
        return Model::class;
    }

    public function datatable($array)
    {
        $shop = $array['shop_id'] ?? null;
        $length = $array['length'] ?? null;

        $totalData = $this->getTotal($shop);
        $filtered = $length > $totalData ? $totalData : $length;

        $tickets = $this->startCondition()->parentTickets()->with('comments')
            ->when(isset($array['length']), function ($query) use ($array){
                $query->take($array['length'])->skip($array['start']);
            })
            ->when(isset($array['status']), function ($q) use ($array) {
                $q->where('status', $array['status']);
            })
            ->when(isset($shop), function ($q) use ($shop) {
                $q->where('shop_id', $shop);
            })
            ->when(isset($array['client_id']), function ($q) use ($array) {
                $q->where('client_id', $array['client_id']);
            })
        ->orderByDesc( $this->startCondition()->select('updated_at')
            ->whereColumn('tickets.parent_id', 'tickets.id'))->get();

        return $this->responseJsonDatatable($totalData, $filtered, $tickets);

    }

    public function createOrUpdate($array)
    {
        if (isset($array['parent_id'])) {
            $ticket = $this->startCondition()->find($array['parent_id']);
            if ($ticket) {
                $ticketComment = $ticket->comments()->create([
                    'client_id' => $ticket->client_id,
                    'shop_id' => $ticket->shop_id,
                    'order_id' => $ticket->order_id,
                    'subject' => $ticket->subject,
                    'content' => $array['content'],
                    'type' => $ticket->type,
                    'is_read' => true,
                ]);
                $ticket->update(['id_read' => false]);
                return $this->successResponse('Ticket save', $ticketComment);
            }
        } else {
            $ticket =  $this->startCondition()->create([
                'client_id' => $array['client_id'],
                'shop_id' => $array['shop_id'],
                'order_id' => $array['order_id'] ?? null,
                'parent_id' => $array['parent_id'] ?? 0,
                'subject' => $array['subject'],
                'content' => $array['content'],
                'type' => $array['type'] ?? 'question',
                'status' => $array['status'] ?? 'created',
            ]);
        }

       return $this->successResponse('Ticket save', $ticket);
    }

    public function get($id, $is_read = null)
    {
        $ticket = $this->startCondition()->with('comments')->find($id);

        if (!$ticket) {
           return $this->errorResponse('Ticket not found');
        }
        // if request was from Admin Panel is_read become true
        if ($is_read) { $ticket->update(['is_read' => 1]); }

        return $this->successResponse('Ticket found', $ticket);
    }

    public function changeStatus($id, $status)
    {
        $ticket = $this->startCondition()->find($id);
        if ($ticket) {
            $ticket->update(['status' => $status]);
            return $this->successResponse('Ticked saved', $ticket);
        }
        return $this->errorResponse('Ticked not found');
    }
}
