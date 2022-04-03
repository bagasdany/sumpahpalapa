<?php

namespace App\Http\Controllers;

use App\Http\Requests\Admin\FaqRequest;
use App\Repositories\Interfaces\FaqInterface;
use Illuminate\Http\Request;

class FaqController extends Controller
{
    private $faqRepository;

    public function __construct(FaqInterface $faq)
    {
        $this->faqRepository = $faq;
    }

    public function save(FaqRequest $request)
    {
        return $this->faqRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->faqRepository->datatable($request->all());
    }

    public function delete(Request $request)
    {
        return $this->faqRepository->delete($request->id);
    }

    public function get(Request $request)
    {
        return $this->faqRepository->get($request->id);
    }
}
