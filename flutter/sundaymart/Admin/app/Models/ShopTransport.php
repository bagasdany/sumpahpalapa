<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ShopTransport extends Model
{
    use HasFactory;
    protected $fillable = ['shop_id', 'delivery_transport_id', 'price', 'active', 'default'];

    public function deliveryTransports(){
        return $this->hasManyThrough( DeliveryTransportLanguage::class, DeliveryTransport::class,
            'id', 'delivery_transport_id', 'delivery_transport_id', 'id');
    }

    public function deliveryTransport(){
        return $this->hasOneThrough( DeliveryTransportLanguage::class, DeliveryTransport::class,
            'id', 'delivery_transport_id', 'delivery_transport_id', 'id');
    }

    public function shop(){
        return $this->belongsTo(Shops::class, 'shop_id');
    }
}
