<?php

namespace App\Repositories;

use App\Models\Permissions;
use App\Models\RolePermissions as Model;
use App\Models\Roles;
use App\Repositories\Interfaces\RolePermissionInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class RolePermissionRepository extends CoreRepository implements RolePermissionInterface
{
    use ApiResponse;
    use DatatableResponse;

    public function __construct()
    {
        parent::__construct();
    }

    protected function getModelClass()
    {
        $this->model = Model::class;
    }

    public function roles()
    {
        $roles = Roles::where("active", 1)->get();

        return $this->successResponse("success", $roles);
    }

    public function datatable($collection = [])
    {
        $totalData = Roles::count();
        $totalFiltered = $totalData;

        $datas = Roles::skip($collection['start'])
            ->take($collection['length'])
            ->get();


        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->name;
                $nestedData['active'] = $data->active;
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function permissionDatatable($collection = [])
    {
        $totalData = Permissions::count();
        $totalFiltered = $totalData;

        $datas = Permissions::skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $roles = Roles::where('active', 1)->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->name;
                foreach ($roles as $role) {
                    $rolePermission = Model::where([
                        'id_role' => $role->id,
                        'id_permission' => $data->id,
                    ])->first();
                    $nestedData[$role->name] = $rolePermission != null ? 1 : 0;
                }
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function createOrUpdatePermission($collection = [])
    {
        $permission = Permissions::updateOrCreate([
            "id" => $collection['id']
        ], [
            "name" => $collection['url'],
            "url" => $collection['url'],
            "type" => 1,
        ]);

        if ($permission) {
            Model::updateOrCreate([
                'id_role' => 1,
                'id_permission' => $permission->id
            ], [
                'id_role' => 1,
                'id_permission' => $permission->id
            ]);

            return $this->successResponse("success");
        }

        return $this->errorResponse("error");
    }

    public function createOrUpdate($collection = [])
    {
        $role = Roles::where("name", $collection['name'])->first();

        if ($collection['value'] == 1) {
            Model::create([
                "id_role" => $role->id,
                "id_permission" => $collection["id"]
            ]);
        } else {
            Model::where([
                'id_permission' => $collection["id"],
                'id_role' => $role->id
            ])->delete();
        }

        return $this->successResponse("success");
    }

    public function delete($id)
    {
        Permissions::find($id)->delete();

        return $this->successResponse("success");
    }

    public function get($id)
    {
        $permission = Permissions::find($id);

        return $this->successResponse("success", $permission);
    }
}
