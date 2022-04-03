<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrdersDetailExtras extends Model {
    protected $table = "order_details_extras";
    protected $primaryKey = "id";
    protected $guarded = [];

    protected $fillable = [
        'id_order_detail',
        'id_extras',
        'price',
        'id_extras_group'
    ];

    public function language(){
        return $this->hasOne(ProductExtrasLanguage::class, 'id_extras', 'id_extras');
    }

    public function productExtras(){
        return $this->belongsTo(ProductExtras::class, 'id_extras');
    }
}
