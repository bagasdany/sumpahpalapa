<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PaymentAttribute extends Model
{
    use HasFactory;
    protected $fillable = ['tag', 'position', 'mask', 'validation', 'active'];
    protected $hidden = ['created_at', 'updated_at'];
    public function language() {
        return $this->hasOne(PaymentAttributeLanguage::class, "payment_attribute_id");
    }

    public function languages() {
        return $this->hasMany(PaymentAttributeLanguage::class, "payment_attribute_id");
    }

    public function payment(){
        return $this->belongsTo(Payments::class, 'payment_id');
    }


}
