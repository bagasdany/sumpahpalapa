<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Point extends Model
{
    use HasFactory;
    protected $guarded = [];

    public function languages(){
        return $this->hasMany(PointLanguage::class, 'point_id');
    }

    public function language() {
        return $this->hasOne(PointLanguage::class, "point_id");
    }
}
