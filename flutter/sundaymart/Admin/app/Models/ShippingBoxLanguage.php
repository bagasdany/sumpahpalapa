<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ShippingBoxLanguage extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['lang_id', 'type', 'name', 'description'];

    protected $hidden = [
        'laravel_through_key'
    ];

    public function language() {
        return $this->belongsTo(Languages::class, "lang_id");
    }
}
