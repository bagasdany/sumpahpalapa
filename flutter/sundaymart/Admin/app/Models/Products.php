<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Staudenmeir\EloquentHasManyDeep\HasRelationships;

class Products extends Model
{
    use HasRelationships;
    protected $table = "products";
    protected $primaryKey = "id";

    protected $guarded = [];

    const DISCOUNT_TYPE = [
        1 => 'percent',
        2 => 'amount',
    ];

    public function setPriceAttribute($value)
    {
        $this->attributes['price'] = round($value, 2);
    }

    public function images()
    {
        return $this->hasMany(ProductsImages::class, 'id_product', 'id');
    }

    public function language()
    {
        return $this->hasOne(ProductsLanguage::class, 'id_product', 'id');
    }

    public function languages()
    {
        return $this->hasMany(ProductsLanguage::class, 'id_product', 'id');
    }

    public function discount()
    {
        return $this->hasOneThrough(Discount::class, DiscountProducts::class,  'id_product','id',  'id','id_discount');
    }

    public function coupon()
    {
        return $this->hasOne(CouponProducts::class, 'id_product', 'id');
    }

    public function category()
    {
        return $this->belongsTo(Categories::class, 'id_category', 'id');
    }

    public function categoryLanguage()
    {
        return $this->hasOneThrough(CategoriesLanguage::class, Categories::class,
            'id', 'id_category', 'id_category', 'id');
    }

    public function shop()
    {
        return $this->belongsTo(Shops::class, 'id_shop', 'id');
    }

    public function shopLanguage()
    {
        return $this->hasOneThrough(ShopsLanguage::class, Shops::class,
            'id', 'id_shop', 'id_shop', 'id');
    }

    public function comments()
    {
        return $this->hasMany(ProductsComment::class, 'id_product', 'id');
    }

    public function units()
    {
        return $this->belongsTo(Units::class, 'id_unit', 'id');
    }

    public function unitLanguage()
    {
        return $this->hasOneThrough(UnitsLanguage::class, Units::class,
            'id', 'id_unit', 'id_unit', 'id');
    }

    public function brands() {
        return $this->belongsTo(Brands::class,"id_brand", "id");
    }

    public function description() {
        return $this->hasMany(ProductsCharacterics::class, "id_product", "id");
    }

    public function extras() {
        return $this->hasMany(ProductExtrasGroup::class, "id_product", "id");
    }

    public function taxes() {
        return $this->hasManyThrough(Tax::class, TaxCategory::class,
            "category_id", "id", "id_category", "tax_id");
    }

    // Return actual and active discount for product
    public function actualDiscount(){
        return $this->hasOneThrough(Discount::class, DiscountProducts::class,  'id_product','id',  'id','id_discount')
            ->where(['active' => 1, 'is_count_down' => 0])
            ->orWhere(function($query) {
                $query->where('active', 1)
                    ->where('is_count_down', 1)
                    ->whereDate('start_time', '<', now())->whereDate('end_time', '>', now());
            });
    }

    // Return product commission amount
    public function getCommissionAttribute()
    {
        $commission = ($this->price / 100) * $this->shop->admin_percentage;
        return $this->attributes['commission'] = round($commission, 2);
    }

    // Return product commission price
    public function getCommissionPriceAttribute()
    {
        return $this->attributes['commission_price'] = round($this->price + $this->commission, 2);
    }
}
