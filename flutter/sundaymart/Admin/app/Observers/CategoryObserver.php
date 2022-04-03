<?php

namespace App\Observers;

use App\Models\Categories;
use App\Repositories\ShopRepository;

class CategoryObserver
{
    private $shop;
    public function __construct(ShopRepository $shopRepository)
    {
        $this->shop = $shopRepository;
    }

    /**
     * Handle the Shops "creating" event.
     *
     * @param  Categories $categories
     * @return void
     */
    public function saving(Categories $categories){
        $result = $this->csl();
        if (!$result) {
            die(response()->json(['status' => false, 'license' => false, 'message' => 'Need activation key']));
        }
    }

    /**
     * Handle the Categories "created" event.
     *
     * @param  \App\Models\Categories  $categories
     * @return void
     */
    public function created(Categories $categories)
    {
        //
    }

    /**
     * Handle the Categories "updated" event.
     *
     * @param  \App\Models\Categories  $categories
     * @return void
     */
    public function updated(Categories $categories)
    {
        //
    }

    /**
     * Handle the Categories "deleted" event.
     *
     * @param  \App\Models\Categories  $categories
     * @return void
     */
    public function deleted(Categories $categories)
    {
        //
    }

    /**
     * Handle the Categories "restored" event.
     *
     * @param  \App\Models\Categories  $categories
     * @return void
     */
    public function restored(Categories $categories)
    {
        //
    }

    /**
     * Handle the Categories "force deleted" event.
     *
     * @param  \App\Models\Categories  $categories
     * @return void
     */
    public function forceDeleted(Categories $categories)
    {
        //
    }

    private function csl(){
       return $this->shop->checkLicenseeHash();
    }
}
