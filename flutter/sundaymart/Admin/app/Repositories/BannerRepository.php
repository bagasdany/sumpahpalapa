<?php

namespace App\Repositories;

use App\Models\Admin;
use App\Models\BannersLanguage;
use App\Models\BannersProducts;
use App\Models\Banners as Model;
use App\Models\Languages;
use App\Repositories\Interfaces\BannerInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class BannerRepository extends CoreRepository implements BannerInterface
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
        $banners = Model::updateOrCreate([
            "id" => $collection["id"]
        ], [
            "image_url" => $collection['image_path'],
            "title_color" => $collection['title_color'],
            "button_color" => $collection['button_color'],
            "indicator_color" => $collection['indicator_color'],
            "background_color" => $collection['background_color'],
            "position" => $collection['position'],
            "active" => $collection['active'],
            "id_shop" => $collection['shop_id']
        ]);

        if ($banners) {
            $banner_id = $banners->id;
            foreach ($collection['name'] as $key => $value) {
                $language = Languages::where("short_name", $key)->first();

                BannersLanguage::updateOrCreate([
                    "id_banner" => $banner_id,
                    "id_lang" => $language->id
                ], [
                    "title" => $value,
                    "description" => $collection['description'][$key],
                    "sub_title" => $collection['sub_title'][$key],
                    "button_text" => $collection['button_text'][$key],
                    "id_banner" => $banner_id,
                    "id_lang" => $language->id
                ]);
            }


            BannersProducts::where("id_banner", $banner_id)->delete();

            if (isset($collection['products']) && is_array($collection['products']) && count($collection['products']) > 0)
                foreach ($collection['products'] as $productId) {

                    BannersProducts::create([
                        "id_banner" => $banner_id,
                        "id_product" => intval($productId)
                    ]);
                }
        }

        return $this->successResponse("success");
    }

    public function get($id)
    {
        $banner = Model::with([
            "languages.language",
            "products"
        ])->where([
            "id" => $id
        ])
            ->first();

        return $this->successResponse("success", $banner);
    }

    public function getBannerForRest($id_shop, $id_lang)
    {
        $banners = Model::with([
            "language" => function ($query) use ($id_lang) {
                $query->id_lang = $id_lang;
            }
        ])
            ->where('id_shop', $id_shop)
            ->get();

        return $this->successResponse("success", $banners);
    }

    public function getBannerProductsForRest($collection = [])
    {
        $banner = BannersProducts::whereHas('product', function ($q) {
            $q->where('quantity', '>', 0);
        })->where("id_banner", $collection['id_banner'])->with([
            "product",
            "product.images",
            "product.units.language" => function ($query) use ($collection) {
                $query->id_lang = $collection['id_lang'];
            },
            "product.taxes" => function ($query) use ($collection) {
                $query->where('active', 1);
            },
            "product.actualDiscount",
            "product.coupon.coupon",
            "product.language" => function ($query) use ($collection) {
                $query->where([
                    'id_lang' => $collection['id_lang'],
                    ['name', '!=', null]
                ]);
                $query->orWhere([
                    ['name', '!=', null]
                ]);
            }
        ])
            ->whereHas("product.language", function ($query) use ($collection) {
                if (strlen($collection['search']) >= 3) {
                    $query->where("name", "like", "%" . $collection['search'] . "%");
                }
            })
            ->whereHas("product", function ($query) use ($collection) {
                if (strlen($collection['brands']) > 0) {
                    $query->whereIn("id_brand", explode(",", $collection['brands']));
                }

                $whereQuery = [
                    "active" => 1,
                    ["price", ">=", $collection['min_price']],
                    ["price", "<=", $collection['max_price']],
                ];

                $query->where($whereQuery);
            })
            ->withCount([
                "comments" => function ($query) {
                    $query->active = 1;
                }
            ])
            ->withSum("comments", "star")
            ->join("products", "banners_products.id_product", "products.id")
            ->orderBy("products.price", $collection['sort_type'] == 0 ? "asc" : "desc")
            ->skip($collection['offset'])
            ->take($collection['limit'])
            ->get();

        $banner = $banner->map(function ($item){
            if ($item->product) {
                $rate = $this->getShopCurrencyRate();
                $item->product->price = $item->product->price * $rate;;
                collect($item->product)->merge([
                    'commission_price' => $item->product->commission_price,
                    'commission' => $item->product->commission
                ]);
            }
            return $item;
        });


        return $this->successResponse("Success", $banner);
    }

    public function datatable($collection = [])
    {
        $shop_id = Admin::getUserShopId();
        if ($shop_id == -1)
            $totalData = Model::count();
        else
            $totalData = Model::where("id_shop", $shop_id)->count();

        $totalFiltered = $totalData;
        $defaultLanguage = Languages::where("default", 1)->first();


        $datas = Model::with([
            "language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            },
            "shop.language" => function ($query) use ($defaultLanguage) {
                $query->id_lang = $defaultLanguage->id;
            }
        ]);
        if ($shop_id != -1) {
            $datas = $datas->where('id_shop', $shop_id);
        }

        $datas = $datas
            ->skip($collection['start'])
            ->take($collection['length'])
            ->get();

        $responseData = array();
        if (!empty($datas)) {
            foreach ($datas as $data) {
                $nestedData['id'] = $data->id;
                $nestedData['name'] = $data->language->title;
                $nestedData['description'] = $data->language->description;
                $nestedData['sub_title'] = $data->language->sub_title;
                $nestedData['button_text'] = $data->language->button_text;
                $nestedData['image_url'] = $data->image_url;
                $nestedData['title_color'] = $data->title_color;
                $nestedData['button_color'] = $data->button_color;
                $nestedData['indicator_color'] = $data->indicator_color;
                $nestedData['background_color'] = $data->background_color;
                $nestedData['position'] = $data->position;
                $nestedData['shop'] = $data->shop->language->name;
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
