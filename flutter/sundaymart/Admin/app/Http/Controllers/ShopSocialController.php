<?php

namespace App\Http\Controllers;

use App\Models\ShopSocial;
use App\Repositories\ShopSocialRepository;
use App\Repositories\SocialRepository;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class ShopSocialController extends Controller
{
    use ApiResponse;
    private $model;
    private $shopSocialRepository;

    /**
     * @param $model
     * @param $shopSocialRepository
     */
    public function __construct(ShopSocial $model, ShopSocialRepository $shopSocialRepository)
    {
        $this->model = $model;
        $this->shopSocialRepository = $shopSocialRepository;
    }

    public function datatable(Request $request){
        return $this->shopSocialRepository->datatable($request->all());
    }

    public function save(Request $request){
        return $this->shopSocialRepository->createOrUpdate($request->all());
    }

    public function get($id){
        return $this->shopSocialRepository->get($id);
    }

    public function delete($id){
        return true;
    }

    public function active(){
        return $this->shopSocialRepository->active();
    }
}
