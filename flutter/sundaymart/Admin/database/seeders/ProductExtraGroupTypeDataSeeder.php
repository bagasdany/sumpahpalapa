<?php

namespace Database\Seeders;

use App\Models\ProductExtras;
use App\Models\ProductExtrasGroup;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductExtraGroupTypeDataSeeder extends Seeder
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
                'name' => 'Button with image',
                'active' => 1,
            ],
            [
                'id' => 2,
                'name' => 'Button with color',
                'active' => 1,
            ],
            [
                'id' => 3,
                'name' => 'Button with title',
                'active' => 1,
            ]
        ];

        foreach ($data as $value) {
            DB::table('product_extra_input_types')->updateOrInsert(
                ['id' => $value['id']],
                [
                    'name' => $value['name'],
                    'active' => $value['active'],
                ]);
        }
    }
}
