<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ShopShippingBox extends Model
{
    use HasFactory;
    protected $fillable = ['shop_id', 'shipping_box_id', 'start', 'end', 'price', 'active'];

    public function shop(){
        return $this->belongsTo(Shops::class, 'shop_id');
    }

    public function shippingBoxes(){
        return $this->hasManyThrough( ShippingBoxLanguage::class, ShippingBox::class,
            'id', 'shipping_box_id', 'shipping_box_id', 'id');
    }

    public function shippingBox(){
        return $this->hasOneThrough( ShippingBoxLanguage::class, ShippingBox::class,
            'id', 'shipping_box_id', 'shipping_box_id', 'id');
    }
}
