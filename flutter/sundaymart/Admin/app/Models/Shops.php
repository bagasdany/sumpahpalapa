<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Shops extends Model
{

    protected $table = "shops";
    protected $primaryKey = "id";
    protected $guarded = [];

    public function about() {
        return $this->hasOne(About::class, "id_shop", "id");
    }

    public function privacy() {
        return $this->hasOne(Privacy::class, "id_shop", "id");
    }

    public function terms() {
        return $this->hasOne(Terms::class, "id_shop", "id");
    }


    public function language() {
        return $this->hasOne(ShopsLanguage::class, "id_shop", "id");
    }

    public function languages() {
        return $this->hasMany(ShopsLanguage::class, "id_shop", "id");
    }

    public function category() {
        return $this->belongsTo(ShopCategories::class, "id_shop_category", "id");
    }

    public function currencies(){
        return $this->hasMany(ShopsCurriencies::class, 'id_shop');
    }

    public function shopDeliveryTypes(){
        return $this->hasMany(ShopDelivery::class, 'shop_id');
    }

    public function shopDeliveryTransports(){
        return $this->hasMany(ShopTransport::class, 'shop_id');
    }

    public function shopDeliveryBoxes(){
        return $this->hasMany(ShopShippingBox::class, 'shop_id');
    }

    public function taxes(){
        return $this->hasMany(Tax::class, 'shop_id');
    }


    public function shopPayments(){
        return $this->hasManyThrough(PaymentLanguage::class, ShopPayment::class,
            'id_shop', 'id_payment', 'id', 'id_payment');
    }

    public function socials(){
        return $this->belongsToMany(Social::class, ShopSocial::class, 'shop_id', 'social_id');
    }

    public function scopeAmountLimit($q, $id){
        $result = $q->find($id);
        return $result->amount_limit;
    }

}
