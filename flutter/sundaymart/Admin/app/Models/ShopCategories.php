<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ShopCategories extends Model
{
    protected $table = "shop_categories";
    protected $primaryKey = "id";

    protected $guarded = [];

    public function language() {
        return $this->hasOne(ShopCategoriesLanguage::class, "id_shop_category", "id");
    }

    public function languages() {
        return $this->hasMany(ShopCategoriesLanguage::class, "id_shop_category", "id");
    }
}
