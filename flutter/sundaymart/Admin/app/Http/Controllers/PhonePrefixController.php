<?php

namespace App\Http\Controllers;

use App\Http\Requests\Admin\FaqRequest;
use App\Repositories\Interfaces\FaqInterface;
use App\Repositories\Interfaces\PhonePrefixInterface;
use Illuminate\Http\Request;

class PhonePrefixController extends Controller
{
    private $phonePrefixRepository;

    public function __construct(PhonePrefixInterface $phonePrefix)
    {
        $this->phonePrefixRepository = $phonePrefix;
    }

    public function save(Request $request)
    {
        return $this->phonePrefixRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->phonePrefixRepository->datatable($request->all());
    }

    public function get(Request $request)
    {
        return $this->phonePrefixRepository->get($request->id);
    }

    public function delete(Request $request)
    {
        return $this->phonePrefixRepository->delete($request->id);
    }

    public function active() {
        return $this->phonePrefixRepository->active();
    }
}
