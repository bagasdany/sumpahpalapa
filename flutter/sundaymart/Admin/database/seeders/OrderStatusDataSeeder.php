<?php

namespace Database\Seeders;

use App\Models\OrdersStatus;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class OrderStatusDataSeeder extends Seeder
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
                'name' => 'Processing',
                'active' => 1,
            ],
            [
                'id' => 2,
                'name' => 'Ready',
                'active' => 1,
            ],
            [
                'id' => 3,
                'name' => 'On a Way',
                'active' => 1,
            ],
            [
                'id' => 4,
                'name' => 'Delivered',
                'active' => 1,
            ],
            [
                'id' => 5,
                'name' => 'Canceled',
                'active' => 1,
            ],
        ];

        foreach ($data as $value) {
            OrdersStatus::firstOrCreate(['id' => $value['id']], $value);
        }
    }
}
