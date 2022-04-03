<?php

namespace App\Http\Controllers;

use App\Http\Requests\Admin\AboutRequest;
use App\Repositories\Interfaces\AboutInterface;
use Illuminate\Http\Request;

class AboutController extends Controller
{
    private $aboutRepository;

    public function __construct(AboutInterface $about)
    {
        $this->aboutRepository = $about;
    }

    public function save(AboutRequest $request)
    {
        return $this->aboutRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->aboutRepository->datatable($request->all());
    }

    public function get(Request $request)
    {
        return $this->aboutRepository->get($request->id_shop);
    }
}
