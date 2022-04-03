<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductExtrasGroup extends Model {
    protected $table = "product_extra_groups";
    protected $primaryKey = "id";

    protected $guarded = [];

    public function language() {
        return $this->hasOne(ProductExtrasGroupLanguage::class, "id_extra_group", "id");
    }

    public function languages() {
        return $this->hasMany(ProductExtrasGroupLanguage::class, "id_extra_group", "id");
    }

    public function extras() {
        return $this->hasMany(ProductExtras::class, "id_extra_group", "id");
    }

    public function types() {
        return $this->belongsTo(ExtrasGroupTypes::class, "type", "id");
    }
}
