<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Addresses extends Model
{
    protected $table = "addresses";
    protected $primaryKey = "id";
    protected $guarded = [];

    public function client() {
        return $this->belongsTo(Clients::class, "id_user", "id");
    }
}
