<?php

namespace Database\Seeders;

use App\Models\DeliveryType;
use App\Models\DeliveryTypeLanguage;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class DeliveryTypeSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $types = [
            [
                'id' => 1,
                'status' => 1,
            ],
            [
                'id' => 2,
                'status' => 1,
            ],
            [
                'id' => 3,
                'status' => 1,
            ],
        ];
        $typeLang = [
            [
                'id' => 1,
                'name' => 'Free',
                'description' => 'Free type description',
                'delivery_type_id' => 1,
                'lang_id' => 2,
            ],
            [
                'id' => 2,
                'name' => 'Free',
                'description' => 'Free type description',
                'delivery_type_id' => 1,
                'lang_id' => 1,
            ],
            [
                'id' => 3,
                'name' => 'Standard',
                'description' => 'Standard type description',
                'delivery_type_id' => 2,
                'lang_id' => 2,
            ],
            [
                'id' => 4,
                'name' => 'Standard',
                'description' => 'Standard type description',
                'delivery_type_id' => 2,
                'lang_id' => 1,
            ],
            [
                'id' => 5,
                'name' => 'Express',
                'description' => 'Express type description',
                'delivery_type_id' => 3,
                'lang_id' => 2,
            ],
            [
                'id' => 6,
                'name' => 'Express',
                'description' => 'Express type description',
                'delivery_type_id' => 3,
                'lang_id' => 1,
            ],
        ];
        foreach($types as $type) {
            DeliveryType::firstOrCreate(['id' => $type['id']],$type);
        }
        foreach($typeLang as $lang) {
            DeliveryTypeLanguage::firstOrCreate(['id' => $lang['id']],$lang);
        }
    }
}
