<?php

namespace App\Http\Controllers;

use App\Repositories\Interfaces\BrandCategoryInterface;
use Illuminate\Http\Request;
use App\Models\BrandCategories;
use App\Models\BrandCategoriesLanguage;
use App\Models\Languages;

class BrandCategoriesController extends Controller
{

    private $brandCategoryRepository;

    public function __construct(BrandCategoryInterface $brandCategory)
    {
        $this->brandCategoryRepository = $brandCategory;
    }

    public function save(Request $request)
    {
        $id = $request->id;
        $active = $request->active;
        $names = $request->name;

        if ($id > 0)
            $category = BrandCategories::findOrFail($id);
        else
            $category = new BrandCategories();

        $category->active = $active;
        if ($id > 0)
            $category->updated_at = date("Y-m-d H:i:s");
        else
            $category->created_at = date("Y-m-d H:i:s");

        if ($category->save()) {
            $brand_category_id = $category->id;
            foreach ($names as $key => $value) {

                $language = Languages::where("short_name", $key)->first();

                if ($id > 0) {
                    $brandCategoryLanguage = BrandCategoriesLanguage::where([
                        "id_brand_category" => $id,
                        "id_lang" => $language->id
                    ])->first();
                    if (!$brandCategoryLanguage)
                        $brandCategoryLanguage = new BrandCategoriesLanguage();
                } else
                    $brandCategoryLanguage = new BrandCategoriesLanguage();
                $brandCategoryLanguage->name = $value;
                $brandCategoryLanguage->id_brand_category = $brand_category_id;
                $brandCategoryLanguage->id_lang = $language->id;
                $brandCategoryLanguage->save();
            }

            return response()->json([
                'success' => 1,
                'msg' => "Successfully saved"
            ]);
        }

        return response()->json([
            'success' => 0,
            'msg' => "Error in saving language"
        ]);
    }

    public function datatable(Request $request)
    {
        return $this->brandCategoryRepository->datatable($request->all());
    }


    public function get(Request $request)
    {
        return $this->brandCategoryRepository->get($request->id);
    }

    public function delete(Request $request)
    {
        return $this->brandCategoryRepository->delete($request->id);
    }

    public function active(Request $request)
    {
        return $this->brandCategoryRepository->active();
    }
}
