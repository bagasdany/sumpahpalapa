<?php

namespace App\Repositories\Interfaces;

interface AppSettingsInterface
{
    public function appLanguageDatatable($collection = []);

    public function appTranslationDatatable($collection = []);

    public function saveTranslation($collection = []);
}
