<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductsCharacterics extends Model
{
    protected $table = "products_characterics";
    protected $primaryKey = "id";

    public $timestamps = false;

    protected $guarded = [];

    public function language() {
        return $this->hasOne(ProductsCharactericsLanguage::class, "id_product_characteristic", "id");
    }

    public function languages() {
        return $this->hasMany(ProductsCharactericsLanguage::class, "id_product_characteristic", "id");
    }
}
