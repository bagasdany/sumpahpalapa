<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Discount extends Model
{
    protected $table = "discount";
    protected $primaryKey = "id";
    protected $guarded = [];

    public function products()
    {
        return $this->hasMany(DiscountProducts::class, "id_discount", "id");
    }

    public function shop()
    {
        return $this->belongsTo(Shops::class, "id_shop", "id");
    }
}
