<?php

namespace Database\Seeders;

use App\Models\DeliveryTransport;
use Illuminate\Database\Seeder;

class DeliveryTransportSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data = [
            'active' => 1
        ];
        $transport = DeliveryTransport::create([

        ]);
    }
}
