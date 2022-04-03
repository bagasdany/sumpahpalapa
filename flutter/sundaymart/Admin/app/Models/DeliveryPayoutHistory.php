<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeliveryPayoutHistory extends Model
{
    use HasFactory;
    protected $guarded = [];

    const HISTORY_STATUS = [
        'success',
        'cancel',
        'processing',
    ];

    public function order()
    {
        return $this->belongsTo(Orders::class, 'oder_id');
    }

    public function deliveryBoy()
    {
        return $this->belongsTo(Admin::class, 'admin_id');
    }

    public function createOrUpdate($params){
        DeliveryPayoutHistory::updateOrCreate(
            ['admin_id' => $params['admin_id'], 'order_id' => $params['order_id']],
            [
                'amount' => $params['amount'],
                'status' => $params['status']
            ]);
    }
}
