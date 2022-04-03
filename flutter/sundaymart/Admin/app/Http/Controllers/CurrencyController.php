<?php

namespace App\Http\Controllers;

use App\Repositories\Interfaces\CurrencyInterface;
use Illuminate\Http\Request;
use App\Models\Currency;
use App\Models\CurrencyLanguage;
use App\Models\Languages;

class CurrencyController extends Controller
{
    private $currencyRepository;

    public function __construct(CurrencyInterface $currency)
    {
        $this->currencyRepository = $currency;
    }

    public function save(Request $request)
    {
        return $this->currencyRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->currencyRepository->datatable($request->all());
    }

    public function get(Request $request)
    {
       return $this->currencyRepository->get($request->id);
    }

    public function delete(Request $request)
    {
        return $this->currencyRepository->delete($request->id);
    }

    public function active(Request $request)
    {
        return $this->currencyRepository->active();
    }

    public function default()
    {
        return $this->currencyRepository->default();
    }
}
