<?php

namespace App\Http\Controllers\Mobile;

use App\Http\Controllers\Controller;
use App\Http\Requests\Rest\DiscountRestRequest;
use App\Repositories\Interfaces\PrivacyInterface;
use Illuminate\Http\Request;

class PrivacyContoller extends Controller
{
    private $privacyRepository;

    public function __construct(PrivacyInterface $privacy)
    {
        $this->privacyRepository = $privacy;
    }

    public function privacy(Request $request)
    {
        return $this->privacyRepository->get($request->id_shop);
    }
}
