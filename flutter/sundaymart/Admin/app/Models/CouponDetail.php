<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CouponDetail extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['order_id', 'coupon_id', 'client_id', 'used_time'];
}
