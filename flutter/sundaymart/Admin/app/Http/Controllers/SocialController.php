<?php

namespace App\Http\Controllers;

use App\Models\Social;
use App\Repositories\SocialRepository;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class SocialController extends Controller
{
    use ApiResponse;
    private $model;
    private $socialRepository;

    /**
     * @param $model
     * @param $socialRepository
     */
    public function __construct(Social $model, SocialRepository $socialRepository)
    {
        $this->model = $model;
        $this->socialRepository = $socialRepository;
    }

    public function datatable(Request $request){
        return $this->socialRepository->datatable($request->all());
    }

    public function save(Request $request){
        return $this->socialRepository->createOrUpdate($request->all());
    }

    public function get($id){
        return $this->socialRepository->get($id);
    }

    public function delete($id){
        $response = $this->model->withCount('shopSocials')->find($id);
        if ($response) {
            if ($response->shop_socials_count > 0) {
                return $this->errorResponse('This Social is used by the store, you can\'t delete it');
            }
            $response->delete();
            return $this->successResponse('Successfully deleted', true);

        } else {
            return $this->errorResponse('Social not found');
        }

    }
    public function active(){
        return $this->socialRepository->active();
    }
}
