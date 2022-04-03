<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PhonePrefix extends Model
{
    protected $table = "phone_prefix";
    protected $primaryKey = "id";
    protected $guarded = [];

    public $timestamps = false;
}
