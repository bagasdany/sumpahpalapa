<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TaxCategory extends Model
{
    use HasFactory;
    public $timestamps = false;
    protected $fillable = ['category_id', 'tax_id'];
}
