<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Privacy extends Model
{
    protected $table = "privacy";
    protected $primaryKey = "id";
    protected $guarded = [];


    public function language() {
        return $this->hasOne(PrivacyLanguage::class, "id_privacy", "id");
    }

    public function languages() {
        return $this->hasMany(PrivacyLanguage::class, "id_privacy", "id");
    }
}
