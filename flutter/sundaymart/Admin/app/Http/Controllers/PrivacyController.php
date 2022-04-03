<?php

namespace App\Http\Controllers;

use App\Repositories\Interfaces\PrivacyInterface;
use Illuminate\Http\Request;

class PrivacyController extends Controller
{
    private $privacyRepository;

    public function __construct(PrivacyInterface $privacy)
    {
        $this->privacyRepository = $privacy;
    }

    public function save(Request $request)
    {
        return $this->privacyRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->privacyRepository->datatable($request->all());
    }

    public function delete(Request $request)
    {

    }

    public function get(Request $request)
    {
        return $this->privacyRepository->get($request->id_shop);
    }
}
