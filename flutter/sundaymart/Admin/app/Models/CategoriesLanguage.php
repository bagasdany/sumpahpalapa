<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CategoriesLanguage extends Model
{
    protected $table = "categories_language";
    protected $primaryKey = "id";
    public $timestamps = false;

    protected $guarded = [];

    public function language() {
        return $this->belongsTo(Languages::class, "id_lang", "id");
    }
}
