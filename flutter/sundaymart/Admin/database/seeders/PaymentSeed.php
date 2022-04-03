<?php

namespace Database\Seeders;

use App\Models\PaymentAttribute;
use App\Models\PaymentAttributeLanguage;
use App\Models\PaymentLanguage;
use App\Models\Payments;
use Illuminate\Database\Seeder;

class PaymentSeed extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $payments = [
            [
                'id' => 1,
                'tag' => 'cash_money',
                'type' => 0,
                'method' => 1,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 2,
                'tag' => 'terminal_money',
                'type' => 0,
                'method' => 2,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 3,
                'tag' => 'stripe',
                'type' => 2,
                'method' => 3,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 4,
                'tag' => 'paystack',
                'type' => 2,
                'method' => 4,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 5,
                'tag' => 'flutterwave',
                'type' => 2,
                'method' => 4,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 6,
                'tag' => 'razorpay',
                'type' => 2,
                'method' => 4,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            /*[
                'id' => 7,
                'tag' => 'seerafa',
                'type' => 2,
                'method' => 5,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],*/
            [
                'id' => 8,
                'tag' => 'paypal',
                'type' => 2,
                'method' => 4,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 99,
                'tag' => 'balance',
                'type' => 0,
                'method' => 1,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ];

        foreach ($payments as $payment){
            Payments::updateOrInsert(['id' => $payment['id']], $payment);
        }

        $paymentLang = [
            [
                'id' => 1,
                'name' => 'Cash',
                'key_title' => null,
                'secret_title' => null,
                'id_lang' => 1,
                'id_payment' => 1
            ],
            [
                'id' => 2,
                'name' => 'Terminal',
                'key_title' => null,
                'secret_title' => null,
                'id_lang' => 1,
                'id_payment' => 2
            ],
            [
                'id' => 3,
                'name' => 'Stripe',
                'key_title' => 'Public Key',
                'secret_title' => 'Secret Key',
                'id_lang' => 1,
                'id_payment' => 3
            ],
            [
                'id' => 4,
                'name' => 'Paystack',
                'key_title' => 'Public Key',
                'secret_title' => 'Secret Key',
                'id_lang' => 1,
                'id_payment' => 4
            ],
            [
                'id' => 5,
                'name' => 'Flutterwave',
                'key_title' => 'Public Key',
                'secret_title' => 'Secret Key',
                'id_lang' => 1,
                'id_payment' => 5
            ],
            [
                'id' => 6,
                'name' => 'Balance',
                'key_title' => null,
                'secret_title' => null,
                'id_lang' => 1,
                'id_payment' => 99
            ],
            [
                'id' => 7,
                'name' => 'Razorpay',
                'key_title' => 'Key ID',
                'secret_title' => 'Secret ID',
                'id_lang' => 1,
                'id_payment' => 6
            ],

            [
                'id' => 8,
                'name' => 'PayPal',
                'key_title' => 'Client ID',
                'secret_title' => 'Secret',
                'id_lang' => 1,
                'id_payment' => 8
            ],
            /*[
                'id' => 8,
                'name' => 'Seerafa',
                'key_title' => null,
                'secret_title' => null,
                'id_lang' => 1,
                'id_payment' => 7
            ],*/

        ];
        foreach ($paymentLang as $lang){
            PaymentLanguage::updateOrInsert(['id' => $lang['id']], $lang);
        }

        $paymentAttributes = [
            [
                'id' => 1,
                'payment_id' => 3,
                'tag' => 'card_number',
                'position' => 1,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 2,
                'payment_id' => 3,
                'tag' => 'card_expired',
                'position' => 2,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 3,
                'payment_id' => 3,
                'tag' => 'card_cvv',
                'position' => 3,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 4,
                'payment_id' => 3,
                'tag' => 'card_holder',
                'position' => 4,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 5,
                'payment_id' => 4,
                'tag' => 'email',
                'position' => 1,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 6,
                'payment_id' => 5,
                'tag' => 'email',
                'position' => 1,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 7,
                'payment_id' => 6,
                'tag' => 'email',
                'position' => 1,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            /*[
                'id' => 8,
                'payment_id' => 7,
                'tag' => 'phone',
                'position' => 1,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 9,
                'payment_id' => 7,
                'tag' => 'otp_code',
                'position' => 1,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],*/
            [
                'id' => 10,
                'payment_id' => 8,
                'tag' => 'email',
                'position' => 1,
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ];
        foreach ($paymentAttributes as $attribute){
            PaymentAttribute::updateOrInsert(['id' => $attribute['id']], $attribute);
        }

        $paymentAttributesLang = [
            [
                'id' => 1,
                'name' => 'Card number',
                'payment_attribute_id' => 1,
                'lang_id' => 1,
            ],
            [
                'id' => 2,
                'name' => 'Expire Date',
                'payment_attribute_id' => 2,
                'lang_id' => 1,
            ],
            [
                'id' => 3,
                'name' => 'CVV',
                'payment_attribute_id' => 3,
                'lang_id' => 1,
            ],
            [
                'id' => 4,
                'name' => 'Card holder name',
                'payment_attribute_id' => 4,
                'lang_id' => 1,
            ],
            [
                'id' => 5,
                'name' => 'Email address',
                'payment_attribute_id' => 5,
                'lang_id' => 1,
            ],
            [
                'id' => 6,
                'name' => 'Email address',
                'payment_attribute_id' => 6,
                'lang_id' => 1,
            ],
            [
                'id' => 7,
                'name' => 'Email address',
                'payment_attribute_id' => 7,
                'lang_id' => 1,
            ],
            /*[
                'id' => 8,
                'name' => 'Phone number',
                'payment_attribute_id' => 8,
                'lang_id' => 1,
            ],
            [
                'id' => 9,
                'name' => 'OTP Code',
                'payment_attribute_id' => 9,
                'lang_id' => 1,
            ],*/
            [
                'id' => 10,
                'name' => 'Email address',
                'payment_attribute_id' => 10,
                'lang_id' => 1,
            ],
        ];

        foreach ($paymentAttributesLang as $lang){
            PaymentAttributeLanguage::updateOrInsert(['id' => $lang['id']], $lang);
        }

    }
}
