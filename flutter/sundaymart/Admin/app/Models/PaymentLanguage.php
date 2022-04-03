<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PaymentLanguage extends Model
{
    protected $table = "payment_language";
    protected $primaryKey = "id";
    protected $guarded = [];
    public $timestamps = false;

    public function language() {
        return $this->belongsTo(Languages::class, "id_lang", "id");
    }

    public function paymentAttributes(){
        return $this->hasManyThrough(PaymentAttribute::class, Payments::class,
            'id', 'payment_id', 'id_payment', 'id');
    }
}
