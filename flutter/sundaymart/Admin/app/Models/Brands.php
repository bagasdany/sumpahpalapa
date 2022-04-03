<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Brands extends Model
{
    protected $table = "brands";
    protected $primaryKey = "id";
    protected $guarded = [];

    public function category()
    {
        return $this->belongsTo(BrandCategories::class, "id_brand_category", "id");
    }

    public function shop()
    {
        return $this->belongsTo(Shops::class, "id_shop", "id");
    }
}
