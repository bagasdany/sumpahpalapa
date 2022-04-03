<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Repositories\Interfaces\AddressInterface;
use Illuminate\Http\Request;

class AddressController extends Controller
{
    private $addressRepository;

    public function __construct(AddressInterface $address)
    {
        $this->addressRepository = $address;
    }

    public function save(Request $request)
    {
        return $this->addressRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->addressRepository->datatable($request->all());
    }

    public function delete(Request $request)
    {
        return $this->addressRepository->delete($request->id);
    }

    public function active(Request $request)
    {
        return $this->addressRepository->active($request->client_id);
    }
}
