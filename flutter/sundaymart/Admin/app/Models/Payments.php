<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Payments extends Model
{
    protected $table = "payments";
    protected $primaryKey = "id";
    protected $guarded = [];

    public function languages() {
        return $this->hasMany(PaymentLanguage::class, "id_payment", "id");
    }

    public function language() {
        return $this->hasOne(PaymentLanguage::class, "id_payment", "id");
    }

    public function attributes(){
        return $this->hasMany(PaymentAttribute::class, 'payment_id');
    }

    public function method(){
        return $this->belongsTo(PaymentsMethod::class, 'method');
    }


}
