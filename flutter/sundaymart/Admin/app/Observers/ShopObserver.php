<?php

namespace App\Observers;

use App\Models\Shops;
use App\Repositories\Interfaces\ShopInterface;
use App\Repositories\ShopRepository;

class ShopObserver
{
    private $shop;
    public function __construct(ShopRepository $shopRepository)
    {
        $this->shop = $shopRepository;
    }

    /**
     * Handle the Shops "creating" event.
     *
     * @param  \App\Models\Shops  $shops
     * @return void
     */
    public function saving(Shops $shops){
        $result = $this->csl();
        if (!$result) {
            die(response()->json(['status' => false, 'license' => false, 'message' => 'Need activation key']));
        }
    }
    /**
     * Handle the Shops "created" event.
     *
     * @param  \App\Models\Shops  $shops
     * @return void
     */
    public function created(Shops $shops)
    {

    }

    /**
     * Handle the Shops "updated" event.
     *
     * @param  \App\Models\Shops  $shops
     * @return void
     */
    public function updated(Shops $shops)
    {
        //
    }

    /**
     * Handle the Shops "deleted" event.
     *
     * @param  \App\Models\Shops  $shops
     * @return void
     */
    public function deleted(Shops $shops)
    {
        //
    }

    /**
     * Handle the Shops "restored" event.
     *
     * @param  \App\Models\Shops  $shops
     * @return void
     */
    public function restored(Shops $shops)
    {
        //
    }

    /**
     * Handle the Shops "force deleted" event.
     *
     * @param  \App\Models\Shops  $shops
     * @return void
     */
    public function forceDeleted(Shops $shops)
    {
        //
    }

    private function csl(){
       return $this->shop->checkLicenseeHash();
    }
}
