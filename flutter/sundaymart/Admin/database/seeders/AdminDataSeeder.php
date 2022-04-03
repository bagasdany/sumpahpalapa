<?php

namespace Database\Seeders;

use App\Models\Admin;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class AdminDataSeeder extends Seeder
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
                'name' => 'Admin55',
                'surname' => 'Admin',
                'email' => 'admin@gmail.com',
                'password' => Hash::make('admin1234'),
                'active' => 1,
                'id_role' => 1,
            ]
        ];

        foreach ($data as $value) {
            Admin::firstOrCreate(['id' => $value['id']],$value);
        }
    }
}
