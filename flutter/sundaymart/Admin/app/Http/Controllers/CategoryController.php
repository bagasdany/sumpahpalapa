<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Repositories\Interfaces\CategoryInterface;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    private $categoryRepository;

    public function __construct(CategoryInterface $category)
    {
        $this->categoryRepository = $category;
    }

    public function save(Request $request)
    {
        return $this->categoryRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->categoryRepository->datatable($request->all());
    }

    public function get(Request $request)
    {
        return $this->categoryRepository->get($request->id);
    }

    public function delete(Request $request)
    {
        return $this->categoryRepository->delete($request->id);
    }

    public function active(Request $request)
    {
        return $this->categoryRepository->active($request->shop_id);
    }

    public function parent(Request $request)
    {
        return $this->categoryRepository->parent($request->shop_id);
    }

    public function setCategoryTax(Request $request){
        return $this->categoryRepository->setCategoryTax($request->all());
    }
}
