<?php

namespace App\Repositories\Interfaces;

interface LanguageInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function get($id_language);

    public function getAllActiveLanguages();

    public function getDictionary();

    public function datatable($collection = []);

    public function makeDefault($id_language);
}
