<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrdersDetail extends Model {
    protected $table = "order_details";
    protected $primaryKey = "id";

    public $timestamps = false;

    protected $guarded = [];

    public function product() {
        return $this->belongsTo(Products::class,"id_product", "id");
    }

    public function extras(){
        return $this->hasMany(OrdersDetailExtras::class, 'id_order_detail');
    }
}
