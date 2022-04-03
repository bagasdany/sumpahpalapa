<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PointLanguage extends Model
{
    use HasFactory;
    protected $fillable = ['lang_id', 'name', 'description'];
    public $timestamps = false;

    public function language(){
        return $this->belongsTo(Languages::class, 'lang_id');
    }
}
