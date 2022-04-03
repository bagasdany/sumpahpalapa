<?php

namespace App\Http\Controllers;

use App\Repositories\Interfaces\ShopCategoryInterface;
use Illuminate\Http\Request;


class ShopCategoriesController extends Controller
{
    private $shopCategoryRepository;

    public function __construct(ShopCategoryInterface $shopCategory)
    {
        $this->shopCategoryRepository = $shopCategory;
    }

    public function save(Request $request)
    {
        return $this->shopCategoryRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->shopCategoryRepository->datatable($request->all());
    }


    public function get(Request $request)
    {
        return $this->shopCategoryRepository->get($request->id);
    }

    public function delete(Request $request)
    {
        return $this->shopCategoryRepository->delete($request->id);
    }

    public function active(Request $request)
    {
        return $this->shopCategoryRepository->active();
    }
}
