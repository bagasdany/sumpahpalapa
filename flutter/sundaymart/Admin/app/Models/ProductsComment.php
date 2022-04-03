<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductsComment extends Model
{
    protected $table = "products_comments";
    protected $primaryKey = "id";
    protected $guarded = [];

    public function user()
    {
        return $this->belongsTo(Clients::class, "id_user", 'id');
    }
}
