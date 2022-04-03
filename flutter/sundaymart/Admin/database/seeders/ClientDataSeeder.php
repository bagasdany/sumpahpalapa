<?php

namespace Database\Seeders;

use App\Models\Clients;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class ClientDataSeeder extends Seeder
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
                'id' => 13,
                'email' => 'client@gmail.com',
                'phone' => '+998993148000',
                'password' => Hash::make('admin1234'),
                "name" => "Frank",
                "surname" => "Antonio",
                "active" => 1,
                "auth_type" => 1,
                "token" => "werwerwerw",
            ],
        ];

        foreach ($data as $value) {
            Clients::firstOrCreate(['id' => $value['id']],$value);
        }
    }
}
