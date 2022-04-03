<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ShopDelivery extends Model
{
    use HasFactory;
    protected $fillable = ['shop_id', 'delivery_type_id', 'type', 'start', 'end', 'amount', 'active'];

    const TYPES = [
        1 => 'hours',
        2 => 'days',
        3 => 'range',
        4 => 'fixed_amount',
        5 => 'fixed_range',
    ];

    public function shop(){
        return $this->belongsTo(Shops::class, 'shop_id');
    }

    public function deliveryType(){
        return $this->hasOneThrough( DeliveryTypeLanguage::class, DeliveryType::class,
            'id', 'delivery_type_id', 'delivery_type_id', 'id');
    }

    public function deliveryTypes(){
        return $this->hasManyThrough( DeliveryTypeLanguage::class, DeliveryType::class,
            'id', 'delivery_type_id', 'delivery_type_id', 'id');
    }
}
