<?php

namespace App\Repositories\Interfaces;

interface RolePermissionInterface
{
    public function roles();

    public function datatable($collection = []);

    public function permissionDatatable($collection = []);

    public function createOrUpdatePermission($collection = []);

    public function createOrUpdate($collection = []);

    public function delete($id);

    public function get($id);
}
