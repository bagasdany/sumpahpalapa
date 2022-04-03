<?php

namespace App\Repositories\Interfaces;

interface AdminInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function get($id);

    public function datatable($collection = []);

    public function activate($id, $status);

    public function getActiveDeliveryBoy($id_shop);

    public function deliveryBoyLogin($collection = []);

    public function managerDatatable($collection = []);

    public function managerStatusEdit($id, $status);

    public function deliveryBoysList();

    public function deliveryBoyById($id, $array= []);
}
