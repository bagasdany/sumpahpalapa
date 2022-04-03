<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ShippingBox extends Model
{
    use HasFactory;

    protected $fillable = ['type', 'active'];

    public function language() {
        return $this->hasOne(ShippingBoxLanguage::class, "shipping_box_id");
    }

    public function languages() {
        return $this->hasMany(ShippingBoxLanguage::class, "shipping_box_id");
    }
}
