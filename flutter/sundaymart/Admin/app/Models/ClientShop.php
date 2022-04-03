<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ClientShop extends Model
{
    use HasFactory;
    protected $fillable = ['ip_address', 'name', 'active', 'hash', 'uuid'];

    protected $hidden = ['hash'];
}
