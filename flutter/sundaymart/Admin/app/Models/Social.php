<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Social extends Model
{
    use HasFactory;
    protected $fillable = ['tag', 'name', 'active'];

    public function shopSocials(){
        return $this->hasMany(ShopSocial::class, 'social_id');
    }
}
