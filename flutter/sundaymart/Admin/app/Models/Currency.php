<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Currency extends Model
{
    protected $table = "currency";
    protected $primaryKey = "id";

    protected $guarded = [];

    public function language() {
        return $this->hasOne(CurrencyLanguage::class, "id_currency", "id");
    }

    public function languages() {
        return $this->hasMany(CurrencyLanguage::class, "id_currency", "id");
    }
}
