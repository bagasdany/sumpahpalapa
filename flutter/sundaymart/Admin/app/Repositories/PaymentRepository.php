<?php

namespace App\Repositories;

use App\Models\ClientBalance;
use App\Models\Languages;
use App\Models\Orders;
use App\Models\PaymentAttribute;
use App\Models\Payments;
use App\Models\PaymentsMethod as Model;
use App\Models\PaymentsStatus;
use App\Models\ShopPayment;
use App\Models\Transaction;
use App\Repositories\Interfaces\PaymentInterface;
use App\Repositories\Payment\FlutterwaveRepository;
use App\Repositories\Payment\PaypalRepository;
use App\Repositories\Payment\PaystackRepository;
use App\Repositories\Payment\RazorpayRepository;
use App\Repositories\Payment\SeerafaRepository;
use App\Repositories\Payment\StripeRepository;
use App\Traits\ApiResponse;
use App\Traits\DatatableResponse;

class PaymentRepository extends CoreRepository implements PaymentInterface
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

    public function methodDatatable($collection = [])
    {
        $totalData = Model::count();

        $totalFiltered = $totalData;

        $datas = Model::offset($collection['start'])
            ->limit($collection['length'])
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

    public function statusDatatable($collection = [])
    {
        $totalData = PaymentsStatus::count();
        $totalFiltered = $totalData;

        $datas = PaymentsStatus::skip($collection['start'])
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

    public function getActiveStatus()
    {
        $paymentStatus = PaymentsStatus::where([
            "active" => 1
        ])->get();

        return $this->successResponse("success", $paymentStatus);
    }

    public function getActiveMethod()
    {
        $paymentMethod = Model::where([
            "active" => 1
        ])->get();

        return $this->successResponse("success", $paymentMethod);
    }

    public function createOrUpdate($collection = [])
    {
        $payment = Payments::updateOrCreate(["id" => $collection["id"] ?? null], [
            "active" => $collection['active'],
            "type" => $collection['type']
        ]);

        if ($payment){
            $languages = Languages::select('id', 'short_name')->get();
            foreach ($languages as $lang){
                $payment->languages()->updateOrCreate(['id_lang' => $lang->id, "id_payment" => $payment->id],[
                    'name' => $collection['name'][$lang->short_name] ?? null,
                    'key_title' => $collection['key_title'][$lang->short_name] ?? null,
                    'secret_title' => $collection['secret_title'][$lang->short_name] ?? null,
                ]);
            }
            return $this->successResponse("success", $payment);
        }
        return $this->errorResponse("error");
    }

    public function get($id)
    {
        $payment = Payments::with("languages.language")->firstWhere('id', $id);

        return $this->successResponse("success", $payment);
    }

    public function delete($id)
    {
        Payments::find($id)->delete();

        return $this->successResponse("success");
    }

    public function active()
    {
        $lang = $this->defaultLanguage();
        $payments = Payments::with([
            "language" => function ($query) use ($lang) {
                $query->where('id_lang', $lang);
            },
            "attributes.language" => function ($query) use ($lang) {
                $query->where('lang_id', $lang);
            }
            ])->whereActive(1)->get();

        return $this->successResponse("success", $payments);
    }

    public function datatable($collection = [])
    {
        $totalData = Payments::count();
        $length = $collection['length'] ?? null;
        $start = $collection['start'] ?? 0;

        $totalFiltered = $length > $totalData ? $totalData : $length;

        $lang = $this->defaultLanguage();
        $data = Payments::with([
            "language" => function ($query) use ($lang) {
                $query->where('id_lang', $lang);
            },
            "attributes.language" => function ($query) use ($lang) {
                $query->where('lang_id', $lang);
            }
        ])->when($length, function ($query) use ($start, $length) {
            $query->skip($start)
                ->take($length);
        })->orderByDesc('id')->get();

        $data = $data->map(function ($value){
            return collect($value)->merge([
                'options' => [
                    'delete' => 1,
                    'edit' => 1
                ]]);
        });

        return $this->responseJsonDatatable($totalData, $totalFiltered, $data);
    }

    /**
     * @param array $array
     * @return mixed
     */
    public function paymentAttributesSave($array = [])
    {
        $payment = Payments::find($array['payment_id']);

        if ($payment) {
            $attribute = $payment->attributes()->create([
                'tag' => $array['tag'],
                'position' => $array['position'] ?? 1,
                'mask' => $array['mask'] ?? null,
                'validation' => $array['validation'] ?? null,
                'active' => $array['active'] ?? 0,
            ]);

            $languages = Languages::select('id', 'short_name')->get();
            foreach ($languages as $lang) {
                $attribute->languages()->updateOrCreate(['lang_id' => $lang->id, "payment_attribute_id" => $payment->id], [
                    'name' => $array['name'][$lang->short_name] ?? null,
                ]);
            }
            return $this->successResponse("Payment Attribute Saved!", $attribute);
        }
        return $this->errorResponse("Payment not found!");
    }

    /**
     * @param $id
     * @return mixed
     */
    public function paymentAttributesGet($id)
    {
        $attribute = PaymentAttribute::with('languages')->find($id);

        if ($attribute) {
            $attribute = collect($attribute)->merge(['payment_name' => $attribute->payment->language->name]);

            return $this->successResponse("Payment Attribute found!", $attribute);
        }
        return $this->errorResponse("Payment Attribute not found!");
    }

    /* Set choose Payment by Type and top up (order, admin or client balance) */
    public function setPayment($array){
        // if Balance(99) payment don't check for shop.
        if ($array['payment_id'] == 99){
            return $this->paymentFromBalance($array);
        } else {
            $shopPayment = ShopPayment::with('payment')
                ->where(['id_shop' => $array['shop_id'], 'id_payment' => $array['payment_id']])->first();
            if ($shopPayment) {
                switch ($shopPayment->payment->tag){
                    case 'stripe':
                        return (new StripeRepository())->stripePayment($array, $shopPayment->secret_id);

                    case 'paystack': // Payment via Paystack
                        $response = $this->setAmount($array);
                        if ($response && $response['status']) {
                            $array = $array + ['amount' => $response['amount']];
                            $paystack = (new PaystackRepository())->createTransaction($array, $shopPayment->secret_id);

                            if (isset($paystack->status) && $paystack->status == 'succeeded') {
                                $transaction = $this->setPaymentTransaction($array + ['trxId' => $paystack->data->reference ]);
                                if ($transaction) {
                                    return $this->successResponse('Success', ['redirect_url' =>  $paystack->data->authorization_url]);
                                } else {
                                    return $this->errorResponse('Transaction failed');
                                }
                            } else {
                                return $paystack;
                            }
                        } else {
                            return $this->errorResponse($response['message']);
                        }

                    case 'flutterwave': // Payment via Flutterwave
                        $response = $this->setAmount($array);
                        if ($response && $response['status']) {
                            $array = $array + ['amount' => $response['amount'], 'trxId' => \Str::uuid()];
                            $flutterwave = (new FlutterwaveRepository())->createTransaction($array, $shopPayment->secret_id);

                            if (isset($flutterwave->status) && $flutterwave->status == 'success') {
                                $transaction = $this->setPaymentTransaction($array);

                                if ($transaction) {
                                    return $this->successResponse('Success', ['redirect_url' => $flutterwave->data->link]);
                                } else {
                                    return $this->errorResponse('Transaction failed');
                                }
                            } else {
                                return $flutterwave;
                            }
                        } else {
                            return $this->errorResponse($response['message']);
                        }

                    case 'razorpay': // Payment via Razorpay
                        $response = $this->setAmount($array);
                        if ($response && $response['status']) {
                            $array = $array + ['amount' => $response['amount']];
                            $basic = base64_encode($shopPayment->key_id . ':' . $shopPayment->secret_id);
                            $razorpay = (new RazorpayRepository())->createPayment($array, $basic);

                            if (isset($razorpay->status) && $razorpay->status == 'created') {
                                    $transaction = $this->setPaymentTransaction($array + ['trxId' => $razorpay->id ]);
                                if ($transaction) {
                                    return $this->successResponse('Success', ['redirect_url' =>  $razorpay->short_url]);
                                } else {
                                    return $this->errorResponse('Transaction failed');
                                }
                            } else {
                                return $razorpay;
                            }
                        } else {
                            return $this->errorResponse($response['message']);
                        }

                    case 'paypal': // Payment via Razorpay
                        $response = $this->setAmount($array);
                        if ($response && $response['status']) {
                            $array = $array + ['amount' => $response['amount']];
                            $basic = base64_encode($shopPayment->key_id . ':' . $shopPayment->secret_id);
                            $paypal = (new PaypalRepository())->createOrder($array, $basic);

                            if (isset($paypal->status) && $paypal->status == 'CREATED') {
                                $transaction = $this->setPaymentTransaction($array + ['trxId' => $paypal->id ]);
                                if ($transaction) {
                                    return $this->successResponse('Success', ['redirect_url' =>  $paypal->links[1]->href]);
                                } else {
                                    return $this->errorResponse('Transaction failed');
                                }
                            } else {
                                return $paypal;
                            }
                        } else {
                            return $this->errorResponse($response['message']);
                        }

                    case 'terminal_money':
                    case 'cash_money':
                        $result = $this->setOfflineTransaction($array);
                        return $this->successResponse('Transaction was created', $result);
                    default:
                        return $this->errorResponse('Payment system not found');

                }
            }
            return $this->errorResponse('Shop Payment not found');
        }
    }

    // Set payment amount
    private function setAmount($array){
        switch ($array['type']){
            case 'order':
                $order = Orders::firstWhere('id', $array['id']);
                if (!$order) {
                    return ['status' => false, 'message' => 'Order not found'];
                } elseif ($order->transaction && $order->transaction->status == 2) {
                    return ['status' => false, 'message' => 'Order already paid '];
                }
                $result = ['status' => true, 'amount' => $order->total_sum];
                break;
            case 'admin':
                $result = (new BalanceRepository())->getUsersBalance(['type' => 'admin', 'id' => $array['id']]);
                break;
            case 'client':
                $result = (new BalanceRepository())->getUsersBalance(['type' => 'client', 'id' => $array['id']]);
                break;
            default: $result = ['status' => false, 'message' => 'Undefined type'];
        }
        return $result;
    }

    // Set transaction for Payment
    private function setPaymentTransaction($array){
        $transaction = (new TransactionRepository())->createOrUpdate([
            'shop_id' => $array['shop_id'],
            'client_id' => $array['type'] == 'client' ? $array['id'] : null,
            'admin_id' => $array['type'] == 'admin' ? $array['id'] : null,
            'order_id'  => $array['type'] == 'order' ? $array['id'] : null,
            'payment_sys_trans_id'  => $array['trxId'] ?? null,
            'payment_sys_id'  => $array['payment_id'],
            'amount' => $array['amount'],
            'status'  => 1,
            'status_description'  => 'In process',
        ]);
        if ($transaction) {
            return true;
        } else {
            return false;
        }
    }

    // Payment from Client Balance
    private function paymentFromBalance($array){
        $order = Orders::with('transaction')->firstWhere('id', $array['id']);

        if ($order && !$order->transaction) {
            $user = ClientBalance::firstWhere('client_id', $order->id_user);

            if ($user && $user->balance >= $order->total_sum) {
                $transaction = $this->setOfflineTransaction($array);

                if ($transaction) {
                    $user->update(['balance' => $user->balance - $order->total_sum]);
                   $trans = Transaction::find($transaction->id);
                   $trans->update(['status' => 2, 'status_description' => 'Successfully']);
                }
                return $this->successResponse('Order has been paid', $transaction);
            }
            return $this->errorResponse('Not enough money in user balance');
        }
        return $this->errorResponse('Order already paid');
    }


    /* Create transaction when payment type CASH or TERMINAL or Balance */
    private function setOfflineTransaction($array){
        $result = Orders::firstWhere('id', $array['id']);
        if ($result) {
            $transaction = (new TransactionRepository())->createOrUpdate([
                'shop_id' => $array['shop_id'],
                'order_id'  => $result->id,
                'payment_sys_id'  => $array['payment_id'],
                'payment_sys_trans_id'  => rand(10000, 1000000),
                'amount' => $result->total_sum,
                'status'  => 1,
                'status_description'  => 'In process',
            ]);
            return $transaction;
        }
        return $this->errorResponse('Order not found');
    }
}
