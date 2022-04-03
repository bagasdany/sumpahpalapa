<?php

namespace App\Http\Controllers\Payment;

use App\Http\Controllers\Controller;
use App\Models\ShopPayment;
use App\Models\Transaction;
use App\Repositories\Payment\RazorpayRepository;
use App\Repositories\Payment\SeerafaRepository;
use App\Repositories\TransactionRepository;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;

class SeerafaController extends Controller
{
    use ApiResponse;
    public function payment(Request $request){

        switch ($request->input('method')) {
            case 'login_otp':
                return $this->loginOTP($request->all());
            case 'login_confirm':
                return $this->loginConfirm($request->all());
            case 'transaction_otp':
                return $this->transactionOTP($request->all());
            case 'transaction_confirm':
                return $this->transactionConfirm($request->all());
            case 'transaction_update':
                return $this->transactionUpdate($request->all());
            default:
                return $this->errorResponse('Unknown method');
        }
    }

    private function loginOTP($array){
        $shopPayment = ShopPayment::with('payment')
            ->where(['id_shop' => $array['shop_id'], 'id_payment' => $array['payment_id']])->first();
        if ($shopPayment) {
            $transaction = (new TransactionRepository())->createOrUpdate([
                'shop_id' => $shopPayment->id_shop,
                'client_id' => $array['client_id'],
                'order_id' => null,
                'payment_sys_id' => $shopPayment->id_payment,
                'payment_sys_trans_id' => $array['phone'],
                'amount' => 0,
                'note' => $array['phone'],
                'status' => 1,
                'status_description' => 'Seerafa, LoginOTP generated , but not confirmed',
            ]);

            $seerafa = (new SeerafaRepository())->loginOTP($array + ['trxId' => $transaction->id], $shopPayment->key_id);

            if (isset($seerafa) && $seerafa->status) {
                return $this->successResponse('Success', [
                    'request_id' =>  $transaction->id, 'phone' =>  $array['phone'], 'next_method' => 'login_confirm'
                ]);
            }
            return $this->errorResponse($seerafa->response ?? 'Unknown error');
        }
        return $this->errorResponse('Shop Payment not found');

    }

    private function loginConfirm($array){
        $shopPayment = ShopPayment::with('payment')
            ->where(['id_shop' => $array['shop_id'], 'id_payment' => $array['payment_id']])->first();

        $seerafa = (new SeerafaRepository())->loginConfirm($array, $shopPayment->key_id, $shopPayment->secret_id);
        if (isset($seerafa) && $seerafa->status) {
            $transaction = Transaction::find($array['request_id']);
            $transaction->update([
                'payment_sys_trans_id' => $seerafa->response->token,
                'status_description' => 'Seerafa, LoginOTP confirmed'
            ]);
            return $this->successResponse('Success', [
                'request_id' =>  $transaction->id,
                'token' =>  $seerafa->response->token,
                'next_method' => 'transaction_otp'
            ]);
        }
        return $this->errorResponse($seerafa->response ?? 'Unknown error');
    }

    private function transactionOTP($array){
        $shopPayment = ShopPayment::with('payment')
            ->where(['id_shop' => $array['shop_id'], 'id_payment' => $array['payment_id']])->first();

        $transaction = Transaction::find($array['request_id']);
        if ($transaction) {
            $seerafa = (new SeerafaRepository())->transactionOTP($array + ['token' => $transaction->payment_sys_trans_id], $shopPayment->key_id);

            if (isset($seerafa) && $seerafa->status) {
                $transaction->update([
                    'amount' => $array['amount'],
                    'status_description' => 'Seerafa, transactionOTP generated, but not confirmed',
                ]);
                return $this->successResponse('Success', [
                    'request_id' => $transaction->id, 'amount' => $array['amount'], 'next_method' => 'transaction_confirm'
                ]);
            }
            return $this->errorResponse($seerafa->response);
        }
        return $this->errorResponse('Transaction not found');
    }

    private function transactionConfirm($array){
        $shopPayment = ShopPayment::with('payment')
            ->where(['id_shop' => $array['shop_id'], 'id_payment' => $array['payment_id']])->first();
        $transaction = Transaction::find($array['request_id']);
        if ($transaction) {
            $seerafa = (new SeerafaRepository())->transactionConfirm($array + ['token' => $transaction->payment_sys_trans_id], $shopPayment->key_id, $shopPayment->secret_id);
            if (isset($seerafa) && $seerafa->status) {
                $transaction->update([
                    'payment_sys_trans_id' => $seerafa->response->txnRefID,
                    'status' => 2,
                    'status_description' => "Success",
                ]);
                return $this->successResponse('Success', [
                    'trx_id' => $transaction->id,
                    'next_method' => 'transaction_update'
                ]);
            } else {
                $transaction->update([
                    'status_description' => $seerafa->response,
                ]);
            }
            return $this->errorResponse($seerafa->response);
        }
        return $this->errorResponse('Transaction not found');
    }

    private function transactionUpdate($array){
        $transaction = Transaction::find($array['trx_id']);
        if ($transaction) {
            $result = $transaction->update(['order_id' => $array['order_id']]);
            if ($result) {
                return $this->successResponse('Transaction updated', []);
            }
            return $this->errorResponse('Error during update');
        }
        return $this->errorResponse('Transaction not found');
    }
}
