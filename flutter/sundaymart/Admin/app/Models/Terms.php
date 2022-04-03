<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Terms extends Model
{
    protected $table = "terms";
    protected $primaryKey = "id";
    protected $guarded = [];

    public function language() {
        return $this->hasOne(TermsLanguage::class, "id_terms", "id");
    }

    public function languages() {
        return $this->hasMany(TermsLanguage::class, "id_terms", "id");
    }
}
