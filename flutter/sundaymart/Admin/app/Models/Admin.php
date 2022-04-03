<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Tymon\JWTAuth\Contracts\JWTSubject;
use Tymon\JWTAuth\Facades\JWTAuth;


class Admin extends Authenticatable implements JWTSubject
{
    use Notifiable;

    public function getJWTIdentifier()
    {
        return $this->getKey();
    }

    public function getJWTCustomClaims()
    {
        return [];
    }

    protected $table = "admins";
    protected $primaryKey = "id";
    protected $guarded = [];

    protected $hidden = [
        'laravel_through_key',
        'password',
        'pivot'
    ];

    public static function getUserShopId()
    {
        $token = JWTAuth::getToken();
        $user = JWTAuth::toUser($token);

        if ($user->id_role == 1) {
            return -1;
        }

        return $user->id_shop;
    }

    public static function getUserId()
    {
        $token = JWTAuth::getToken();
        $user = JWTAuth::toUser($token);
        return $user->id;
    }

    public function shop()
    {
        return $this->belongsTo(ShopsLanguage::class, "id_shop", "id_shop");
    }

    public function balance()
    {
        return $this->hasOne(AdminBalance::class);
    }

    public function position()
    {
        return $this->hasOne(LiveTracking::class);
    }

    public function orders()
    {
        return $this->belongsToMany(Orders::class, 'delivery_boy_orders', 'admin_id', 'order_id', 'id', 'id');
    }

    public function transactions()
    {
        return $this->hasMany(Transaction::class, 'admin_id');
    }

    public function payoutType(){
        return $this->hasOne(DeliveryBoyPayout::class, 'admin_id');
    }

    // Define DeliveryBoy payoutType and charge balance
    public function scopeDeliveryBoyPayout($query, $id, $amount)
    {
        $deliveryBoy = $query->with('payoutType')->find($id);
        if ($deliveryBoy) {
            switch ($deliveryBoy->payoutType->type) {
                case 2: $payout = round($deliveryBoy->payoutType->value * ($amount/100),2);
                    break;
                case 3: $payout =  round($deliveryBoy->payoutType->value, 2);
                    break;
                default: $payout =  0;
                    break;
            }
            $deliveryBoy->balance()->update([
                'balance' => $deliveryBoy->balance->balance + $payout
            ]);
            return $payout;
        }
        return false;
    }

    public function deliveryBoyOrdersCount($collection)
    {
         $collection->map(function ($value) {
            $boy = $value->orders->mapToGroups(function ($order, $key) {
                switch ($order->order_status){
                    case 1: $status = 'accepted';
                        break;
                    case 2: $status = 'ready_to_delivery';
                        break;
                    case 3: $status = 'in_a_way';
                        break;
                    case 4: $status = 'delivered';
                        break;
                    case 5: $status = 'canceled';
                        break;
                    default: $status = 'unknown';
                }
                return [$status => $order->order_status];
            });
            $boy = $boy->map(function ($item) {
                return $item->pipe(function ($value) {
                    return collect($value)->count();
                });
            });

            $transactions = $value->transactions()->deliveryDailyBalance();
            $value->daily_balance = $transactions;
            $value->shop_name = $value->shop->name ?? null;
            return $value->orders_count = $boy;
        });
        return $collection->makeHidden(['shop', 'orders']);
    }

    public function scopeFilterDeliveryBoys($query, $array = [])
    {
        // Filter orders by request params
        $sort = isset($array['sort']) && $array['sort'] == 'desc';

        $query = $query->where('id_role', 3);

        if (isset($array['id_delivery_boy'])) {
            $query = $query->where('id', $array['id_delivery_boy']);
        }
        if (isset($array['order_date_from']) && isset($array['order_date_to'])) {
            $to = Carbon::parse($array['order_date_to'])->addDay(); // Add one day to include $collection['order_date_to'] in the interval
            $query = $query->whereBetween('created_at', [$array['order_date_from'], $to]);
        }
        if (isset($array['status'])) {
            $query = $query->whereHas('orders', function ($q) use ($array) {
                $q->where('order_status', $array['status']);
            });
        }

        if (isset($array["start"])) {
            $query = $query->skip($array["start"])->take($array["length"]);
        }

        $query = $query->orderByDesc('id')->get();

        if (isset($collection['sort'])) {
            $query = $query->sortBy('orders.orders_count', 1, $sort);
        }
        return $query;
    }
}
