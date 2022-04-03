<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductExtrasLanguage extends Model {
    protected $table = "product_extras_language";
    protected $primaryKey = "id";
    protected $guarded = [];
    public $timestamps = false;

    public function language() {
        return $this->belongsTo(Languages::class, "id_lang", "id");
    }
}
