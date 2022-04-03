<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductsImages extends Model
{
    protected $table = "products_images";
    protected $primaryKey = "id";
    protected $guarded = [];

    public $timestamps = false;
}
