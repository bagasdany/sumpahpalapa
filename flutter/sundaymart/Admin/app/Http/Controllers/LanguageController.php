<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Languages;
use App\Repositories\Interfaces\LanguageInterface;
use Illuminate\Http\Request;

class LanguageController extends Controller
{
    private $languageRepository;

    public function __construct(LanguageInterface $language)
    {
        $this->languageRepository = $language;
    }

    public function save(Request $request)
    {
        return $this->languageRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->languageRepository->datatable($request->all());
    }

    public function delete(Request $request)
    {
        return $this->languageRepository->delete($request->id);
    }

    public function get(Request $request)
    {
        return $this->languageRepository->get($request->id);
    }

    public function makeDefault(Request $request)
    {
        return $this->languageRepository->makeDefault($request->id);
    }

    public function active()
    {
        return $this->languageRepository->getAllActiveLanguages();
    }
}
