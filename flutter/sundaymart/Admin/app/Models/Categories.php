<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Categories extends Model
{
    protected $table = "categories";
    protected $primaryKey = "id";

    protected $guarded = [];

    public function products() {
        return $this->hasMany(Products::class, 'id_category','id');
    }

    public function language() {
        return $this->hasOne(CategoriesLanguage::class, 'id_category', 'id');
    }

    public function languages() {
        return $this->hasMany(CategoriesLanguage::class, 'id_category', 'id');
    }

    public function subcategories() {
        return $this->hasMany(Categories::class, 'parent');
    }

    public function parentcategory() {
        return $this->belongsTo(Categories::class, 'parent', 'id');
    }

    public function shop() {
        return $this->belongsTo(Shops::class, "id_shop", "id");
    }

    public function taxes(){
        return $this->belongsToMany(Tax::class, TaxCategory::class, 'category_id', 'tax_id');
    }
}
