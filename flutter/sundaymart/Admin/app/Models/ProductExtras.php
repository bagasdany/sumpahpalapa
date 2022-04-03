<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductExtras extends Model
{
    protected $table = "product_extras";
    protected $primaryKey = "id";
    protected $guarded = [];
    public function language() {
        return $this->hasOne(ProductExtrasLanguage::class, "id_extras", "id");
    }

    public function languages() {
        return $this->hasMany(ProductExtrasLanguage::class, "id_extras", "id");
    }

    public function extrasGroup() {
        return $this->belongsTo(ProductExtrasGroup::class, "id_extra_group", "id");
    }
}
