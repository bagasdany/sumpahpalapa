<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\Faq as Model;
use App\Models\FaqLanguage;
use App\Models\Languages;
use App\Repositories\Interfaces\FaqInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class FaqRepository extends CoreRepository implements FaqInterface
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

        return $this->successResponse("success");
    }

    public function createOrUpdate($collection = [])
    {
        try {
            if ($collection['id'] > 0) {
                $faq = Model::findOrFail($collection['id']);
            } else {
                $faq = new Model();
            }

            $faq->id_shop = $collection['id_shop'];
            $faq->active = $collection['active'];
            if ($faq->save()) {
                $id = $faq->id;
                foreach ($collection['questions'] as $key => $value) {
                    $language = Languages::getByShortName($key);

                    $faq_language = null;

                    if ($collection['id'] > 0) {
                        $faq_language = FaqLanguage::where([
                            "id_faq" => $id,
                            "id_lang" => $language->id
                        ])->first();
                    }

                    if (!$faq_language)
                        $faq_language = new FaqLanguage();

                    $faq_language->id_lang = $language->id;
                    $faq_language->id_faq = $id;
                    $faq_language->question = $value;
                    $faq_language->answer = $collection['answers'][$key];
                    $faq_language->save();
                }

                return $this->successResponse("Faq successfully saved", []);
            }

            return $this->errorResponse("error in saving faq");
        } catch (\Exception $e) {
            return $this->errorResponse($e->getMessage());
        }
    }

    public function get($id)
    {
        $data = Model::where("id", $id)->with([
            "languages.language",
        ])->first();

        return $this->successResponse("success", $data);
    }

    public function getForRest($id_shop, $id_lang)
    {
        $data = Model::where("id_shop", $id_shop)->with([
            "language" => function ($query) use ($id_lang) {
                $query->id_lang = $id_lang;
            },
        ])->get();

        return $this->successResponse("success", $data);
    }

    public function datatable($collection = [])
    {
        $id_shop = Admin::getUserShopId();
        if ($id_shop == -1)
            $totalData = Model::count();
        else
            $totalData = Model::where("id_shop", $id_shop)->count();
        $totalFiltered = $totalData;

        $language = Languages::getDefaultLanguage();

        $datas = Model::with([
            "language" => function ($query) use ($language) {
                $query->id_lang = $language->id;
            },
            "shop.language" => function ($query) use ($language) {
                $query->id_lang = $language->id;
            },
        ]);

        if ($id_shop != -1)
            $datas = $datas->where("id_shop", $id_shop);

        $datas = $datas->take($collection['length'])
            ->skip($collection['start'])
            ->get();

        $responseData = [];

        foreach ($datas as $data) {
            $nestedData['id'] = $data['id'];
            $nestedData['question'] = $data['language']['question'];
            $nestedData['answer'] = $data['language']['answer'];
            $nestedData['shop'] = $data['shop']['language']['name'];
            $nestedData['active'] = $data['active'];
            $nestedData['options'] = [
                'delete' => 1,
                'edit' => 1
            ];

            $responseData[] = $nestedData;
        }

        return $this->responseJsonDatatable($totalData, $totalFiltered, $responseData);
    }
}
