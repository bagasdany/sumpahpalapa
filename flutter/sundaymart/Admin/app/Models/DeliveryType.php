<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeliveryType extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['status'];

    const DELIVERY_TYPES = [
        1 => 'free',
        2 => 'standard',
        3 => 'express',
    ];



    public function language() {
        return $this->hasOne(DeliveryTypeLanguage::class, "delivery_type_id", "id");
    }

    public function languages() {
        return $this->hasMany(DeliveryTypeLanguage::class, "delivery_type_id", "id");
    }

}
