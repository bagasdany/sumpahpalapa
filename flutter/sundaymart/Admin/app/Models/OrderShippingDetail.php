<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class OrderShippingDetail extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['order_id','delivery_type_id', 'delivery_transport_id', 'shipping_box_id'];
}
