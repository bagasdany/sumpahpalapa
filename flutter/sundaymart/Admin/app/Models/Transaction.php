<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Transaction extends Model
{
    use HasFactory;
    protected $fillable = [
            'shop_id', 'client_id', 'admin_id', 'order_id', 'payment_sys_trans_id', 'payment_sys_id', 'type', 'amount',
            'note', 'currency', 'perform_time', 'refund_time', 'status', 'status_description',
        ];

    const FILTER_TYPE = [
        0 => 'All',
        1 => 'Order',
        2 => 'Balance',
    ];

    public function payment(){
        return $this->belongsTo(Payments::class, 'payment_sys_id');
    }

    public function shop(){
        return $this->belongsTo(Shops::class);
    }

    public function paymentStatus(){
        return $this->belongsTo(PaymentsStatus::class, 'status');
    }

    /**
     * Query for get Delivery Boy daily balance from Transactions between request date range
     */
    public function scopeDeliveryDailyBalance($query, $date = []){
        if (count($date) == 2) {
            $to = Carbon::parse($date['to'])->addDay(); // Add one day to include $date['to'] in the interval
            $transactions = $query->whereBetween('perform_time', [$date['from'], $to])->where('type', 'credit')->get();
        } else {
            $transactions = $query->whereDate('perform_time', now())->where('type', 'credit')->get();
        }
        // Grouping the resulting collection from the base
        $transactions = $transactions->mapToGroups(function ($item) {
            $date = Carbon::parse($item->perform_time)->format('Y-m-d');
            return [ $date => $item['amount'] ];
        });
        // Loop the collection through map and sum the amount of each group
        return $transactions->map(function ($item){
            return $item->pipe(function ($value){
                return collect($value)->sum();
            });
        });

    }
}
