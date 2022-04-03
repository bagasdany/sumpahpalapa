<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TimeUnits extends Model
{
    protected $table = "time_units";
    protected $primaryKey = "id";
    public $timestamps = false;

    protected $guarded = [];

    public function shop() {
        return $this->belongsTo(Shops::class, "id_shop", "id");
    }
}
