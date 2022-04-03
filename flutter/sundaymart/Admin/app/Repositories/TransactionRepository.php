<?php

namespace App\Repositories;

use App\Models\Transaction as Model;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class TransactionRepository extends CoreRepository implements Interfaces\TransactionInterface
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

    public function createOrUpdate($array, $id = null)
    {
        $result = $this->startCondition()->updateOrCreate(['id' => $id], [
            'shop_id' => $array['shop_id'],
            'client_id' => $array['client_id'] ?? null,
            'admin_id' => $array['admin_id'] ?? null,
            'order_id'  => $array['order_id'] ?? null,
            'payment_sys_trans_id'  => $array['payment_sys_trans_id'] ?? null,
            'payment_sys_id'  => $array['payment_sys_id'] ?? null,
            'type'  => $array['type'] ?? 'DEBIT',
            'amount' => $array['amount'],
            'note'  => $array['note'] ?? null,
            'currency'  => $array['currency'] ?? 'usd',
            'perform_time'  => $array['perform_time'] ?? now(),
            'refund_time'  => $array['refund_time'] ?? null,
            'status'  => $array['status'],
            'status_description'  => $array['status_description'],
        ]);

        return $result;
    }

    /**
     * @return mixed
     */
    public function transactionsList($params, $shop_id = null)
    {
        $sort = $params['sort'] ?? 'desc';
        $start = $params['start'] ?? 0;
        $length = $params['length'] ?? null;
        $status = $params['status'] ?? null;
        $type = $params['type'] ?? null;

        $total = $this->startCondition()->when($status, function ($q) use ($status) {
            $q->where('status', $status);
        })->when($shop_id, function ($q) use ($shop_id) {
            $q->where('shop_id', $shop_id);
        })->count();

        $transactions = $this->startCondition()->with(['shop.language', 'payment.language'])
            ->when($shop_id, function ($q) use ($shop_id) {
                $q->where('shop_id', $shop_id);
            })
            ->when($type == 2, function ($q) use ($type) {
                $q->whereNull('order_id');
            })->when($type == 1, function ($q) use ($type) {
                $q->whereNull(['client_id', 'admin_id']);
            })->when($length, function ($q) use ($length, $start) {
                $q->take($length)->skip($start);
            })->when($status, function ($q) use ($status) {
                $q->where('status', $status);
            })->orderBy('id', $sort)->get();

        $transactions = $transactions->map(function ($item){
            return collect($item)->merge([
                'shop' => $item->shop != null ?$item->shop->language->name:"",
                'payment' => isset($item->payment->language) ? $item->payment->language->name : 'No payment name'
            ]);
        });


        return $this->responseJsonDatatable($total, $length, $transactions);
    }

    /**
     * @return mixed
     */
    public function clientTransactions($client_id, $params)
    {
        $sort = $params['sort'] ?? 'desc';
        $start = $params['start'] ?? 0;
        $length = $params['length'] ?? null;
        $status = $params['status'] ?? null;

        $total = $this->startCondition()->when($status, function ($q) use ($status) {
            $q->where('status', $status);
        })->where('client_id', $client_id)->count();

        $transactions = $this->startCondition()->with(['shop.language', 'payment.language'])
            ->where('client_id', $client_id)
            ->when($length, function ($q) use ($length, $start) {
                $q->take($length)->skip($start);
            })->when($status, function ($q) use ($status) {
                $q->where('status', $status);
            })->orderBy('id', $sort)->get();

        $transactions = $transactions->map(function ($item){
            return collect($item)->merge([
                'shop' => $item->shop->language->name,
                'payment' => isset($item->payment->language) ? $item->payment->language->name : 'No payment name'
            ]);
        });
        return $this->responseJsonDatatable($total, $length, $transactions);

    }
}
