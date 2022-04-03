<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeliveryBoyPayout extends Model
{
    use HasFactory;
    protected $guarded = [];

    const PayoutsType = [
        1 => 'Salary',
        2 => 'Percent from DeliveryFee',
        3 => 'Fixed amount',
    ];

    public function getPayoutsType($type)
    {
        return self::PayoutsType[$type];
    }
}
