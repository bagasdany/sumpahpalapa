<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Coupon extends Model
{
    protected $table = "coupon";
    protected $primaryKey = "id";
    protected $guarded = [];

    public function language() {
        return $this->hasOne(CouponLanguage::class, "id_coupon", "id");
    }

    public function languages() {
        return $this->hasMany(CouponLanguage::class, "id_coupon", "id");
    }

    public function products() {
        return $this->hasMany(CouponProducts::class, "id_coupon", "id");
    }

    public function details(){
        return $this->hasMany(CouponDetail::class, 'coupon_id');
    }

    public function shop() {
        return $this->belongsTo(Shops::class, "id_shop", "id");
    }

    public function scopeCheckCoupon($query, $coupon){
        return $query->where('active', 1)->where('name', $coupon)
            ->where('usage_time', '>', 0)
            ->whereDate('valid_until', '>', now());
    }
}
