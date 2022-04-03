<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Permissions;
use App\Models\RolePermissions;
use App\Models\Roles;
use App\Repositories\Interfaces\RolePermissionInterface;
use Illuminate\Http\Request;

class RolePermissionController extends Controller
{
    private $rolePermissionRepository;

    public function __construct(RolePermissionInterface $rolePermission)
    {
        $this->rolePermissionRepository = $rolePermission;
    }

    public function roles(Request $request)
    {
        return $this->rolePermissionRepository->roles();
    }

    public function datatable(Request $request)
    {
        return $this->rolePermissionRepository->datatable($request->all());
    }

    public function permissionDatatable(Request $request)
    {
        return $this->rolePermissionRepository->permissionDatatable($request->all());
    }

    public function savepermission(Request $request)
    {
        return $this->rolePermissionRepository->createOrUpdatePermission($request->all());
    }

    public function save(Request $request)
    {
        return $this->rolePermissionRepository->createOrUpdate($request->all());
    }

    public function deletepermission(Request $request)
    {
        return $this->rolePermissionRepository->delete($request->id);
    }

    public function getpermission(Request $request)
    {
        return $this->rolePermissionRepository->get($request->id);
    }
}
