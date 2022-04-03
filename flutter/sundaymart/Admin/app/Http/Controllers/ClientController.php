<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Clients;
use App\Repositories\Interfaces\ClientInterface;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;


class ClientController extends Controller
{
    private $clientRepository;

    public function __construct(ClientInterface $client)
    {
        $this->clientRepository = $client;
    }

    public function save(Request $request)
    {
        return $this->clientRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->clientRepository->datatable($request->all());
    }

    public function delete(Request $request)
    {
        return $this->clientRepository->delete($request->id);
    }

    public function active(Request $request)
    {
        return $this->clientRepository->getActiveClients();
    }

    public function getTotalClientsCount()
    {
        return $this->clientRepository->getTotalClientsCount();
    }

    public function deactivateShop($uuid, Request $request){
        return $this->clientRepository->deactivate($uuid, $request->key);
    }

    public function activateShop($uuid, Request $request){
        return $this->clientRepository->activate($uuid, $request->key);
    }

    public function point2Balance(Request $request){
        return $this->clientRepository->pointChange2Balance($request->point);
    }
}
