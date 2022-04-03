<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\Currency;
use App\Models\Languages;
use App\Models\ShopsCurriencies;

abstract class CoreRepository
{
    protected $model;
    protected $currency;

    /**
     * CoreRepository constructor.
     */
    public function __construct()
    {
        $this->model = app($this->getModelClass());
        $this->currency = request()->currency_id ?? null;
    }

    abstract protected function getModelClass();

    protected function startCondition(){
        return clone $this->model;
    }

    public function defaultLanguage(){
        return Languages::where('default', 1)->pluck('id')->first();
    }

    public function getTotal($shop){
        $shop_id = Admin::getUserShopId();
        if ($shop_id == -1) {
            if (isset($shop))
                $totalData = $this->startCondition()->where("shop_id", $shop)->count();
            else
                $totalData = $this->startCondition()->count();
        } else {
            if (isset($shop))
                $totalData = $this->startCondition()->where("shop_id", $shop)->count();
            else
                $totalData =  $this->startCondition()->where("shop_id", $shop_id)->count();
        }

        return $totalData;
    }

    public function getShopCurrencyRate(){
        $currency = Currency::find($this->currency);
        return $currency->rate ?? 1;
    }
}
