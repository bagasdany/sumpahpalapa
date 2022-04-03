<?php

namespace App\Repositories;

use App\Models\BrandCategories as Model;
use App\Models\Languages;
use App\Repositories\Interfaces\BrandCategoryInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class BrandCategoryRepository extends CoreRepository implements BrandCategoryInterface
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

    public function get($id)
    {
        $categories = Model::with([
            "languages",
            "languages.language"
        ])
            ->where("id", $id)
            ->first();

        return $this->successResponse("success", $categories);
    }

    public function createOrUpdate($collection = [])
    {
        // TODO: Implement createOrUpdate() method.
    }

    public function delete($id)
    {
        Model::find($id)->delete();

        return $this->successResponse("success", []);
    }

    public function active()
    {
        $defaultLanguage = Languages::where("default", 1)->first();

        $categories = Model::with([
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ])->where([
            'active' => 1
        ])->get();

        $data = [];

        foreach ($categories as $category) {
            $data[] = [
                "id" => $category->id,
                "name" => $category->language->name
            ];
        }

        return $this->successResponse("success", $data);
    }

    public function datatable($collection = [])
    {
        $totalData = Model::count();
        $totalFiltered = $totalData;

        $defaultLanguage = Languages::where("default", 1)->first();

        $datas = Model::with([
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_Lang = $defaultLanguage->id;
            }
        ])
            ->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {

                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->language->name;
                $nestedData['active'] = $data->active;
                $nestedData['options'] = [
                    'delete' => 1,
                    'edit' => 1
                ];
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }
}
