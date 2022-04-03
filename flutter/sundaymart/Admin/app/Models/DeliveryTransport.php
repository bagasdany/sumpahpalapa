<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeliveryTransport extends Model
{
    use HasFactory;
    protected $fillable = ['active'];

    public function language() {
        return $this->hasOne(DeliveryTransportLanguage::class, "delivery_transport_id", "id");
    }

    public function languages() {
        return $this->hasMany(DeliveryTransportLanguage::class, "delivery_transport_id", "id");
    }

    public function shopTransports() {
        return $this->hasMany(ShopTransport::class, 'delivery_transport_id', 'id');
    }
}
