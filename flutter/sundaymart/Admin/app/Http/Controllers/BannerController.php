<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Banners;
use App\Models\BannersLanguage;
use App\Models\BannersProducts;
use App\Models\Languages;
use App\Models\Admin;

use App\Repositories\Interfaces\BannerInterface;
use Illuminate\Http\Request;

class BannerController extends Controller
{
    private $bannerRepository;

    public function __construct(BannerInterface $banner)
    {
        $this->bannerRepository = $banner;
    }

    public function save(Request $request)
    {
        return $this->bannerRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->bannerRepository->datatable($request->all());
    }

    public function delete(Request $request)
    {
        return $this->bannerRepository->delete($request->id);
    }

    public function get(Request $request)
    {
        return $this->bannerRepository->get($request->id);
    }
}
