<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BrandCategoriesLanguage extends Model
{
    protected $table = "brand_categories_language";
    protected $primaryKey = "id";
    protected $guarded = [];
    public $timestamps = false;

    public function language()
    {
        return $this->belongsTo(Languages::class, "id_lang", "id");
    }
}
