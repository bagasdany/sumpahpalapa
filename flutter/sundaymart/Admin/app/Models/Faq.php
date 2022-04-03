<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Faq extends Model
{
    protected $table = "faq";
    protected $primaryKey = "id";
    protected $guarded = [];

    public function languages() {
        return $this->hasMany(FaqLanguage::class, "id_faq", "id");
    }

    public function language() {
        return $this->hasOne(FaqLanguage::class, "id_faq", "id");
    }

    public function shop() {
        return $this->belongsTo(Shops::class, "id_shop", "id");
    }
}
