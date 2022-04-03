<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\ShopDelivery;
use App\Repositories\Interfaces\ShopInterface;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class ShopsController extends Controller
{
    use ApiResponse;
    private $shopRepository;

    public function __construct(ShopInterface $shop)
    {
        $this->shopRepository = $shop;
    }

    public function save(Request $request)
    {
        return $this->shopRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->shopRepository->datatable($request->all());
    }

    public function get(Request $request)
    {
        return $this->shopRepository->get($request->id);
    }

    public function delete(Request $request)
    {
        return $this->shopRepository->delete($request->id);
    }

    public function licensee()
    {
        return $this->shopRepository->licensee();
    }

    public function active(Request $request)
    {
      return $this->shopRepository->active();
    }

    public function activate(Request $request)
    {
      return $this->shopRepository->activate($request->public_key);
    }

    public function getTotalShopsCount()
    {
        return $this->shopRepository->getShopCount();
    }

}
