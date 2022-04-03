<?php


namespace App\Repositories;

use App\Models\Languages as Model;
use App\Models\MobileParams;
use App\Repositories\Interfaces\LanguageInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class LanguageRepository extends CoreRepository implements LanguageInterface
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

    public function delete($id)
    {
        Model::find($id)->delete();

        return $this->successResponse("success", []);
    }

    public function createOrUpdate($collection = [])
    {
        try {
            Model::updateOrCreate([
                "id" => $collection["id"]
            ], [
                "active" => $collection["active"],
                "short_name" => $collection["short_code"],
                "image_url" => $collection["image_path"],
                "name" => $collection["name"],
            ]);

            return $this->successResponse("success", []);

        } catch (\Exception $e) {
            return $this->errorResponse($e->getMessage());
        }
    }

    public function get($id_language)
    {
        $language = Model::findOrFail($id_language);

        return $this->successResponse("success", $language);
    }

    public function datatable($collection = [])
    {
        $totalData = Model::count();
        $totalFiltered = $totalData;

        $datas = Model::skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = [];
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->name;
                $nestedData['short_code'] = $data->short_name;
                $nestedData['image_url'] = $data->image_url;
                $nestedData['active'] = $data->active;
                $nestedData['default'] = $data->default;
                $nestedData['options'] = [
                    'delete' => 1,
                    'edit' => 1
                ];
                $responseData[] = $nestedData;

            }
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }

    public function getAllActiveLanguages()
    {
        $languages = Model::where("active", 1)->get();

        return $this->successResponse("success", $languages);
    }

    public function getDictionary()
    {
        $languages = Model::select("id", "short_name")
            ->where("active", 1)->get();

        $responceData = [];
        foreach ($languages as $data) {
            $messages = [];
            $id_lang = $data["id"];

            $datas = MobileParams::select("name", "default", "id")->with([
                "language" => function ($query) use ($id_lang) {
                    $query->where("id_lang", $id_lang);
                }
            ])->get();

            foreach ($datas as $mob) {
                $messages[$mob['name']] = $mob["language"] != null && strlen($mob['language']['name']) > 0 ? $mob['language']['name'] : $mob['default'];
            }

            $responceData[$data['short_name']] = $messages;
        }

        return $this->successResponse("success", $responceData);
    }

    public function makeDefault($id_language)
    {
        Model::where('default', 1)
            ->update(['default' => 0]);

        Model::where('id', $id_language)
            ->update(['default' => 1]);

        return $this->successResponse("success", []);
    }
}
