<?php

namespace App\Repositories;

use App\Models\Languages;
use App\Models\ShopPayment;
use App\Models\ShopPayment as Model;
use App\Repositories\Interfaces\ShopPaymentInterface;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class ShopPaymentRepository extends CoreRepository implements ShopPaymentInterface
{
    use ApiResponse;
    use DatatableResponse;

    public function __construct()
    {
        parent::__construct();
    }

    protected function getModelClass()
    {
        return Model::class;
    }

    public function createOrUpdate($collection = [])
    {
        $payment = $this->startCondition()->updateOrCreate([
            "id_payment" => $collection["id_payment"],
            "id_shop" => $collection['id_shop']
        ], [
            "key_id" => $collection['key_id'] ?? null,
            "secret_id" => $collection["secret_id"]?? null,
            "active" => $collection["active"] ?? 0
        ]);

        return $this->successResponse("success", $payment);
    }

    public function datatable($collection = [])
    {
        $totalData = $this->startCondition()->count();
        $start = $collection['start'] ?? 0;
        $length = $collection['length'] ?? null;
        $totalFiltered = $totalData;

        $defaultLanguage = Languages::where("default", 1)->first();

        $data = $this->startCondition()->with([
            "shop.language" => function ($query) use ($defaultLanguage) {
                $query->where('id_lang', $defaultLanguage->id);
            },
            "payment.language" => function ($query) use ($defaultLanguage) {
                $query->where('id_lang', $defaultLanguage->id);
            },

        ])
            ->where('id_shop', $collection['shop_id'])
            ->when($length, function ($q, $length) use ($start) {
                $q->skip($start)->take($length);
            })->orderByDesc('id')->get();

        $data = $data->map(function ($value){
            return collect($value)->merge([
                'shop' => $value->shop->language->name,
                'options' => [
                    'delete' => 1,
                    'edit' => 1
            ]]);
        });

        return $this->responseJsonDatatable($totalData, $totalFiltered, $data);
    }

    public function get($shop_id, $payment_id)
    {
        $lang = Languages::where("default", 1)->first();

        $payment = $this->startCondition() ->with([
            'shop.language' => function ($query) use ($lang) {
                $query->where('id_lang', $lang->id);
            },
            "payment.language" => function ($query) use ($lang) {
                $query->where('id_lang', $lang->id);
            },
            "payment.attributes.language" => function ($query) use ($lang) {
                $query->where('lang_id', $lang->id);
            }
            ])->firstWhere(['id_shop' => $shop_id, 'id_payment' => $payment_id]);

        if ($payment) {
            $payment = collect($payment)->merge([
                'shop' => $payment->shop->language->name,
            ]);

            return $this->successResponse("Shop Payments found", $payment);
        } else {
            return $this->errorResponse("Shop Payment not found");
        }
    }

    public function active($collection = [])
    {
        $lang = Languages::where("default", 1)->first();

        $data = $this->startCondition()->with([
            'shop.language' => function ($query) use ($lang) {
                $query->where('id_lang', $lang->id);
            },
            "payment.language" => function ($query) use ($lang) {
                $query->where('id_lang', $lang->id);
            },
            "payment.attributes.language" => function ($query) use ($lang) {
                $query->where('lang_id', $lang->id);
            }
        ])->where('id_shop', $collection['shop_id'])
            ->whereActive(1)->get();

        if ($data) {
            $data = $data->map(function ($item){
                return collect($item)->merge([
                    'shop' => $item->shop->language->name,
                ]);
            });
        }

        return $this->successResponse('Shop active payments found', $data);
    }

    public function delete($id)
    {
        Model::find($id)->delete();
        return $this->successResponse("success");
    }

    public function paymentForBalanceTopup($shop_id){
        $lang = $this->defaultLanguage();

        $payments = ShopPayment::whereHas('payment', function ($q) {
            $q->where('type', '!=', 0);
        })
            ->with([
            "payment.language" => function ($query) use ($lang) {
                $query->where('id_lang', $lang);
            },
            "payment.attributes.language" => function ($query) use ($lang) {
                $query->where('lang_id', $lang);
            }
        ])
            ->where('id_shop', $shop_id)->whereActive(1)->get();

        return $this->successResponse("success", $payments);
    }
}
