<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ShopPayment extends Model
{
    protected $table = "shop_payment";
    protected $primaryKey = "id";

    protected $fillable = ['id_shop', 'id_payment', 'key_id', 'secret_id', 'active'];

    public function shop() {
        return $this->belongsTo(Shops::class, "id_shop", "id");
    }

    public function payment() {
        return $this->belongsTo(Payments::class, "id_payment", "id");
    }

    public function attributes(){
        return $this->hasMany(PaymentAttribute::class, 'payment_id');
    }
}
