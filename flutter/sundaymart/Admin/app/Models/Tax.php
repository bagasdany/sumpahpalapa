<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tax extends Model
{
    use HasFactory;

    protected $fillable = ['shop_id', 'name', 'description', 'percent', 'active', 'default'];

    protected $hidden = ['pivot'];

    public function shop(){
        return $this->belongsTo(Shops::class, 'shop_id');
    }
}
