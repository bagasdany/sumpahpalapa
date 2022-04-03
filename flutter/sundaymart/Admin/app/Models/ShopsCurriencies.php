<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ShopsCurriencies extends Model
{
    protected $table = "shops_curriencies";
    protected $primaryKey = "id";
    protected $guarded = [];

    public function currency() {
        return $this->belongsTo(Currency::class, "id_currency", "id");
    }

    public function shop() {
        return $this->belongsTo(Shops::class, "id_shop", "id");
    }
}
