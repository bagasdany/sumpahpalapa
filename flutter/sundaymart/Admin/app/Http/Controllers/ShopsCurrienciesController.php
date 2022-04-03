<?php

namespace App\Http\Controllers;

use App\Models\Languages;
use App\Repositories\Interfaces\ShopCurrencyInterface;
use Illuminate\Http\Request;

use App\Models\ShopsCurriencies;

class ShopsCurrienciesController extends Controller
{
    private $shopCurrencyRepository;

    public function __construct(ShopCurrencyInterface $shopCurrency)
    {
        $this->shopCurrencyRepository = $shopCurrency;
    }

    public function save(Request $request)
    {
        return $this->shopCurrencyRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->shopCurrencyRepository->datatable($request->all());
    }

    public function currency(Request $request)
    {
        return $this->shopCurrencyRepository->getShopCurrencies($request->shop_id);
    }

    public function get(Request $request)
    {
        return $this->shopCurrencyRepository->get($request->id);
    }

    public function delete(Request $request)
    {
        return $this->shopCurrencyRepository->delete($request->id);
    }

    public function change(Request $request)
    {
        return $this->shopCurrencyRepository->change($request->all());
    }
}
