<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BannersLanguage extends Model
{
    protected $table = "banners_language";
    protected $primaryKey = "id";
    protected $guarded = [];
    public $timestamps = false;

    public function language() {
        return $this->belongsTo(Languages::class, "id_lang", "id");
    }
}
