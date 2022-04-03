<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ShopSocial extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['shop_id', 'social_id', 'link', 'active'];

    public function social(){
        return $this->belongsTo(Social::class, 'social_id');
    }
}
