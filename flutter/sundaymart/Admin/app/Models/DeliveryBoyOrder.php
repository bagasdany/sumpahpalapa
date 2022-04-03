<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeliveryBoyOrder extends Model
{
    use HasFactory;
    protected $fillable = ['status', 'order_id', 'admin_id'];
    public $timestamps = false;

}
