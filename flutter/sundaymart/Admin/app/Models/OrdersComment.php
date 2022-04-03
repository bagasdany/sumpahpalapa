<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrdersComment extends Model
{
    protected $table = "order_comments";
    protected $primaryKey = "id";

    protected $guarded = [];

    public function order() {
        return $this->belongsTo(Orders::class, "id_order", "id");
    }
}
