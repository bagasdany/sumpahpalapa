<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Orders extends Model
{
    protected $table = "orders";
    protected $primaryKey = "id";

    protected $guarded = [];

    public function shop()
    {
        return $this->belongsTo(Shops::class, "id_shop", "id");
    }

    public function details()
    {
        return $this->hasMany(OrdersDetail::class, "id_order", "id");
    }

    public function address()
    {
        return $this->hasOne(Addresses::class, "id", "id_delivery_address");
    }

    public function timeUnit()
    {
        return $this->hasOne(TimeUnits::class, "id", "delivery_time_id");
    }

    public function deliveryBoy()
    {
        return $this->hasOne(Admin::class, "id", "id_delivery_boy");
    }

    public function orderStatus() {
        return $this->belongsTo(OrdersStatus::class, "order_status", "id");
    }

    public function paymentStatus() {
        return $this->belongsTo(PaymentsStatus::class, "payment_status", "id");
    }

    public function paymentMethod() {
        return $this->belongsTo(PaymentsMethod::class, "payment_method", "id");
    }

    public function clients() {
        return $this->belongsTo(Clients::class, "id_user", "id");
    }

    public function review() {
        return $this->hasOne(OrdersComment::class, "id_order");
    }

    public function coupon() {
        return $this->hasOneThrough(Coupon::class, CouponDetail::class,"order_id", 'id', 'id', 'coupon_id');
    }

    public function deliveryRoute()
    {
        return $this->hasOne(DeliveryRoute::class, 'order_id');
    }

    public function deliveryBoyOrder() {
        return $this->hasOne(DeliveryBoyOrder::class, "order_id", "id");
    }

    public function deliveryPayoutHistory() {
        return $this->hasOne(DeliveryPayoutHistory::class, "order_id");
    }

    public function orderDeliveryBoysList()
    {
        return $this->belongsToMany(Admin::class,DeliveryBoyOrder::class, 'order_id','admin_id')
            ->select(['admin_id as id', 'name', 'surname', 'image_url', 'email', 'phone', 'gender', 'delivery_boy_orders.status']);
    }

    public function orderDeliveryBoy()
    {
        return $this->hasOneThrough(Admin::class,DeliveryBoyOrder::class, 'order_id','id', 'id', 'admin_id')
            ->where('status', '=',1)
            ->select(['admins.id', 'name', 'surname', 'image_url', 'email', 'phone', 'gender', 'delivery_boy_orders.status']);
    }

    public function deliveryType(){
        return $this->hasOneThrough(ShopDelivery::class, OrderShippingDetail::class, 'order_id', 'id', 'id', 'delivery_type_id');
    }

    public function deliveryTransport(){
        return $this->hasOneThrough(ShopTransport::class, OrderShippingDetail::class, 'order_id', 'id', 'id', 'delivery_transport_id');
    }

    public function deliveryBox(){
        return $this->hasOneThrough(ShopShippingBox::class, OrderShippingDetail::class, 'order_id', 'id', 'id', 'shipping_box_id');
    }

    public function transaction(){
        return $this->hasOne(Transaction::class, 'order_id');
    }
}
