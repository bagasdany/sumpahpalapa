<?php

namespace App\Repositories\Interfaces;

interface ClientInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function get($id_shop);

    public function loginForRest($collection = []);

    public function updateUserForRest($collection = []);

    public function createUserForRest($collection = []);

    public function getActiveClients();

    public function getTotalClientsCount();

    public function datatable($collection = []);

    public function deactivate($uuid, $key);

    public function activate($uuid, $key);

    public function pointChange2Balance($point);
}
