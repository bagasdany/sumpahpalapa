<?php

namespace App\Http\Controllers;

use App\Exports\ProductsExport;
use App\Imports\ProductsImport;
use App\Models\Languages;
use App\Models\Products;
use App\Repositories\Interfaces\ProductInterface;
use App\Traits\ApiResponse;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;

class ProductController extends Controller
{
    use ApiResponse;
    private $productRepository;

    public function __construct(ProductInterface $product)
    {
        $this->productRepository = $product;
    }

    public function save(Request $request)
    {
        return $this->productRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->productRepository->datatable($request->all());
    }


    public function get(Request $request)
    {
        return $this->productRepository->get($request->id);
    }

    public function delete(Request $request)
    {
        return $this->productRepository->delete($request->id);
    }

    public function commentsDelete(Request $request)
    {
        return $this->productRepository->deleteComment($request->id);
    }

    public function commentsDatatable(Request $request)
    {
        return $this->productRepository->datatableComment($request->all());
    }

    public function active(Request $request)
    {
        return $this->productRepository->active($request->shop_id);
    }

    public function getTotalProductsCount()
    {
        return $this->productRepository->getProductCount();
    }

    public function getMostSoldProducts(){
        return $this->productRepository->getMostSoldProducts();
    }

    public function export(Request $request){
        $file = Excel::store(new ProductsExport($request), 'products.xlsx',  'uploads_export');
        if ($file){
            return $this->successResponse('Successfully exported', [
                'path' => '/uploads/export',
                'file_name' => 'products.xlsx'
            ]);
        }
        return $this->errorResponse('Error during export');
    }

    public function import(Request $request){
        if ($request->method() == 'GET') {
            return $this->successResponse('Get import file template', [
                'path' => '/uploads/import',
                'file_name' => 'import_products.xlsx'
            ]);
        }

        try {
            Excel::import(new ProductsImport(), $request->file);
        } catch (\Exception $exception){
            return $this->errorResponse($exception->getMessage());
        }

        return $this->successResponse('Successfully', true);
    }
}
