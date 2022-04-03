<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DeliveryTransportLanguage extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['name', 'description', 'lang_id'];

    protected $hidden = [
        'laravel_through_key'
    ];

    public function language() {
        return $this->belongsTo(Languages::class, "lang_id", "id");
    }
}
