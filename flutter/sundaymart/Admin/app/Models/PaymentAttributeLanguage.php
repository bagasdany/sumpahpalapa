<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PaymentAttributeLanguage extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['name', 'lang_id'];

    public function language() {
        return $this->belongsTo(Languages::class, "lang_id");
    }
}
