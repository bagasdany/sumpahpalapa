<?php

namespace Database\Seeders;

use App\Models\PaymentsStatus;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;


class PaymentStatusDataSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data = [
            [
                'id' => 1,
                'name' => 'In process',
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 2,
                'name' => 'Successful',
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 3,
                'name' => 'Canceled',
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ];

        foreach ($data as $value) {
            PaymentsStatus::firstOrCreate(['id' => $value['id']],$value);
        }
    }
}
