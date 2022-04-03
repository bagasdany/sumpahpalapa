<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Languages;
use App\Models\MobileParams;
use App\Models\MobileParamsLanguage;
use App\Repositories\Interfaces\AppSettingsInterface;
use Illuminate\Http\Request;

class AppSettingsController extends Controller
{
    private $appSettingsRepository;

    public function __construct(AppSettingsInterface $appSettings)
    {
        $this->appSettingsRepository = $appSettings;
    }

    public function appLanguageDatatable(Request $request)
    {
        return $this->appSettingsRepository->appLanguageDatatable($request->all());
    }

    public function appLanguageDatatableWord(Request $request)
    {
        return $this->appSettingsRepository->appTranslationDatatable($request->all());
    }

    public function save(Request $request)
    {
        return $this->appSettingsRepository->saveTranslation($request->all());
    }
}
