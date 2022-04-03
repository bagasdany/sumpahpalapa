<?php

namespace Database\Seeders;

use App\Models\PaymentsMethod;
use Illuminate\Database\Seeder;

class PaymentMethodSeed extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $paymentMethods = [
            [
                'id' => 1,
                'name' => 'cash',
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 2,
                'name' => 'terminal',
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 3,
                'name' => 'card',
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 4,
                'name' => 'url',
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 5,
                'name' => 'method',
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ]
        ];

        foreach ($paymentMethods as $value) {
            PaymentsMethod::firstOrCreate(['id' => $value['id']], $value);
        }
    }
}
