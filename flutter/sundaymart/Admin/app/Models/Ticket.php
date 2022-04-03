<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ticket extends Model
{
    use HasFactory;
    protected $fillable = ['client_id', 'order_id', 'shop_id', 'type', 'subject', 'content', 'status', 'is_read'];

    const TICKET_STATUS = [
        'created',
        'accepted',
        'approved',
        'rejected',
    ];

    public $ticket_types = [
        'question',
        'order',
    ];

    public function getTicketStatuses(){
        return collect(self::TICKET_STATUS)->map(function ($item){
           return $item;
        });
    }

    public function comments(){
        return $this->hasMany(self::class, 'parent_id');
    }

    public function scopeParentTickets($query){
        return $query->where('parent_id', 0);
    }
}
