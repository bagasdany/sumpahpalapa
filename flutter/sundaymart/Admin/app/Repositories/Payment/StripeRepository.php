<?php

namespace App\Repositories\Payment;

use App\Models\Clients;
use App\Models\Orders;
use App\Repositories\BalanceRepository;
use App\Repositories\CoreRepository;
use App\Repositories\Interfaces\Payment\StripeInterface;
use App\Models\Transaction as Model;
use App\Repositories\TransactionRepository;
use App\Traits\ApiResponse;
use Stripe\StripeClient;

class StripeRepository extends CoreRepository implements StripeInterface
{
    use ApiResponse;
    public function __construct()
    {
        parent::__construct();
    }

    protected function getModelClass()
    {
        $this->model = Model::class;
    }

    public function createCustomer($params)
    {
        // TODO: Implement createCustomer() method.
    }

    public function setCardToken($params, $key)
    {
        $stripe = new StripeClient($key);
        $year = \Str::of($params['card_expired'])->after('/');
        $month = \Str::of($params['card_expired'])->before('/');
        try {
            return $stripe->tokens->create([
                'card' => [
                    'number' => $params['card_number'],
                    'exp_month' => $month,
                    'exp_year' => $year,
                    'cvc' => $params['card_cvv'],
                ],
            ]);
        } catch (\Exception $exception) {
            return response()->json($exception->getMessage());
        }
    }

    public function shopBalanceCharge($params, $key)
    {
        $card = $this->setCardToken($params, $key);

        if ($card && $card->id) {
            $stripe = new StripeClient($key);
            try {
                return $stripe->charges->create([
                    'amount' => $params['amount'] * 100,
                    'currency' => 'usd',
                    'card' => $card->id,
                    'description' => 'Top up '.$params['detail'],
                ]);

            } catch (\Exception $exception) {
                return response()->json($exception->getMessage());
            }
        }
    }

    public function stripePayment($array, $key)
    {
        switch ($array['type']){
            case 'order':
                $result = Orders::firstWhere('id', $array['id']);
                if (!$result) {
                    return $this->errorResponse('Order not found');
                }
                $amount = $result->total_sum;
                $order_id = $array['id'];
                break;
            case 'admin':
                $result = (new BalanceRepository())->getUsersBalance(['type' => 'admin', 'id' => $array['id']]);
                $amount = $array['amount'];
                $admin_id = $array['id'];
                break;
            case 'client':
                $result = (new BalanceRepository())->getUsersBalance(['type' => 'client', 'id' => $array['id']]);
                $amount = $array['amount'];
                $client_id = $array['id'];
                break;
            default: $result = null;
        }

        if ($result){
            $params = $array + ['amount' => $amount, 'detail' => 'Top up for '. $array['type'] .' #'.$array['id']];
            $payment = $this->shopBalanceCharge($params, $key);

            if (isset($payment->status) && $payment->status == 'succeeded') {
                $transaction = (new TransactionRepository())->createOrUpdate([
                    'shop_id' => $array['shop_id'],
                    'client_id' => $client_id ?? null,
                    'admin_id' => $admin_id ?? null,
                    'order_id'  => $order_id ?? null,
                    'payment_sys_trans_id'  => $payment->id ?? null,
                    'payment_sys_id'  => $array['payment_id'],
                    'amount' => $amount,
                    'status'  => 2,
                    'status_description'  => 'Successful',
                ]);
                if ($array['type'] == 'admin' || $array['type'] == 'client') {
                    (new BalanceRepository())->topUpUserBalance($array);
                }
                if ($transaction) {
                    return $this->successResponse('Successes', [
                        'stripe_trans_id' => $payment->id,
                        'receipt_url' => $payment->receipt_url,
                    ]);
                } else {
                    return $this->errorResponse('Transaction failed');
                }
            } else {
                return $this->errorResponse($payment->original);
            }
        } else {
            return $this->errorResponse('Undefined TYPE');
        }
    }

}
