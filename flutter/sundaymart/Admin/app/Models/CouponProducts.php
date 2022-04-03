<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CouponProducts extends Model
{
    protected $table = "coupon_products";
    protected $primaryKey = "id";
    protected $guarded = [];

    public $timestamps = false;

    public function coupon()
    {
        return $this->belongsTo(Coupon::class, 'id_coupon', 'id');
    }

    public function product()
    {
        return $this->belongsTo(Products::class, "id_product", "id");
    }

    public function comments()
    {
        return $this->hasMany(ProductsComment::class, 'id_product', 'id_product');
    }
}
