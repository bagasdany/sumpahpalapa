<?php

namespace App\Observers;

use App\Models\Orders;
use App\Repositories\ShopRepository;

class OrderObserver
{
    private $shop;
    public function __construct(ShopRepository $shopRepository)
    {
        $this->shop = $shopRepository;
    }
    /**
     * Handle the Orders "creating" event.
     *
     * @param  \App\Models\Orders  $orders
     * @return void
     */
    public function saving(Orders $orders)
    {
       $result = $this->csl();
       if (!$result) {
           die(response()->json(['status' => false, 'license' => false, 'message' => 'Need activation key']));
       }
    }

    /**
     * Handle the Orders "created" event.
     *
     * @param  \App\Models\Orders  $orders
     * @return void
     */
    public function created(Orders $orders)
    {
        //
    }

    /**
     * Handle the Orders "updated" event.
     *
     * @param  \App\Models\Orders  $orders
     * @return void
     */
    public function updated(Orders $orders)
    {
        //
    }

    /**
     * Handle the Orders "deleted" event.
     *
     * @param  \App\Models\Orders  $orders
     * @return void
     */
    public function deleted(Orders $orders)
    {
        //
    }

    /**
     * Handle the Orders "restored" event.
     *
     * @param  \App\Models\Orders  $orders
     * @return void
     */
    public function restored(Orders $orders)
    {
        //
    }

    /**
     * Handle the Orders "force deleted" event.
     *
     * @param  \App\Models\Orders  $orders
     * @return void
     */
    public function forceDeleted(Orders $orders)
    {
        //
    }

    private function csl(){
        return $this->shop->checkLicenseeHash();
    }
}
