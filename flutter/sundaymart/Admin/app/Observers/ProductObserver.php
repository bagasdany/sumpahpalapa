<?php

namespace App\Observers;

use App\Models\Products;
use App\Repositories\ShopRepository;

class ProductObserver
{
    private $shop;
    public function __construct(ShopRepository $shopRepository)
    {
        $this->shop = $shopRepository;
    }
    /**
     * Handle the Products "creating" event.
     *
     * @param  \App\Models\Products  $products
     * @return void
     */
    public function saving(Products $products)
    {
        $result = $this->csl();
        if (!$result) {
            die(response()->json(['status' => false, 'license' => false, 'message' => 'Need activation key']));
        }
    }

    /**
     * Handle the Products "created" event.
     *
     * @param  \App\Models\Products  $products
     * @return void
     */
    public function created(Products $products)
    {
        //
    }

    /**
     * Handle the Products "updated" event.
     *
     * @param  \App\Models\Products  $products
     * @return void
     */
    public function updated(Products $products)
    {
        //
    }

    /**
     * Handle the Products "deleted" event.
     *
     * @param  \App\Models\Products  $products
     * @return void
     */
    public function deleted(Products $products)
    {
        //
    }

    /**
     * Handle the Products "restored" event.
     *
     * @param  \App\Models\Products  $products
     * @return void
     */
    public function restored(Products $products)
    {
        //
    }

    /**
     * Handle the Products "force deleted" event.
     *
     * @param  \App\Models\Products  $products
     * @return void
     */
    public function forceDeleted(Products $products)
    {
        //
    }

    private function csl(){
        return $this->shop->checkLicenseeHash();
    }
}
