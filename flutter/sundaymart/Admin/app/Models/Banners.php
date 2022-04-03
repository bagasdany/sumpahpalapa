<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Banners extends Model
{
    protected $table = "banners";
    protected $primaryKey = "id";
    protected $guarded = [];

    public function language()
    {
        return $this->hasOne(BannersLanguage::class, "id_banner", "id");
    }

    public function languages()
    {
        return $this->hasMany(BannersLanguage::class, "id_banner", "id");
    }

    public function products()
    {
        return $this->hasMany(BannersProducts::class, "id_banner", "id");
    }

    public function shop()
    {
        return $this->belongsTo(Shops::class, "id_shop", "id");
    }
}
