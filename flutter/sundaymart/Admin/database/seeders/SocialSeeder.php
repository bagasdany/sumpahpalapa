<?php

namespace Database\Seeders;

use App\Models\Social;
use Illuminate\Database\Seeder;

class SocialSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $socials = [
            [
                'id' => 1,
                'tag' => 'facebook',
                'name' => 'Facebook',
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 2,
                'tag' => 'instagram',
                'name' => 'Instagram',
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 3,
                'tag' => 'telegram',
                'name' => 'Telegram',
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 4,
                'tag' => 'tik-tok',
                'name' => 'Tik Tok',
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'id' => 5,
                'tag' => 'twitter',
                'name' => 'Twitter',
                'active' => 1,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ];

        foreach ($socials as $social){
            Social::updateOrInsert(['id' => $social['id']], $social);
        }
    }
}
