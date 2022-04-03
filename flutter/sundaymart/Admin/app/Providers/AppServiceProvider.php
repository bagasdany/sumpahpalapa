<?php

namespace App\Providers;

use App\Models\Categories;
use App\Models\Orders;
use App\Models\Products;
use App\Models\Shops;
use App\Observers\CategoryObserver;
use App\Observers\OrderObserver;
use App\Observers\ProductObserver;
use App\Observers\ShopObserver;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        if (request()->ip() != '127.0.0.1' && isset($_SERVER['SERVER_ADDR'])) {
            Orders::observe(OrderObserver::class);
            Products::observe(ProductObserver::class);
            Categories::observe(CategoryObserver::class);
            Shops::observe(ShopObserver::class);
        }
    }

}
