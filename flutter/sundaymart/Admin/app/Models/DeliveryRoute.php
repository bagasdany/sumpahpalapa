<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeliveryRoute extends Model
{
    use HasFactory;
    protected $fillable = ['order_id', 'origin_address', 'destination_address', 'distance', 'duration', 'price', 'type', 'properties'];

    protected $casts = [
        'properties' => 'json',
    ];

    public function order()
    {
        return $this->belongsTo(Orders::class, 'order_id');
    }

    public function setMeterToKilometer($value): float
    {
        return round($value / 1000, 1, PHP_ROUND_HALF_UP);
    }

    public function setSecondsToMinute($value): float
    {
        return round($value / 60, 1, PHP_ROUND_HALF_UP);
    }
}
