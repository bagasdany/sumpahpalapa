<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BrandCategories extends Model
{
    protected $table = "brand_categories";
    protected $primaryKey = "id";
    protected $guarded = [];

    public function brands() {
        return $this->hasMany(Brands::class, "id_brand_category", "id");
    }

    public function language() {
        return $this->hasOne(BrandCategoriesLanguage::class, "id_brand_category", "id");
    }

    public function languages() {
        return $this->hasMany(BrandCategoriesLanguage::class, "id_brand_category", "id");
    }
}
