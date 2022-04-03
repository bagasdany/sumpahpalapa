<?php

namespace Database\Seeders;

use App\Models\DeliveryType;
use App\Models\PaymentsMethod;
use App\Models\Tax;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // \App\Models\User::factory(10)->create();
        $this->call(DeliveryTypeSeeder::class);
        $this->call(RoleDataSeeder::class);
        $this->call(AdminDataSeeder::class);
        $this->call(PermissionDataSeeder::class);
        $this->call(LanguageDataSeeder::class);
        $this->call(MobileParamsDataSeeder::class);
        $this->call(OrderStatusDataSeeder::class);
        $this->call(PaymentStatusDataSeeder::class);
        $this->call(ClientDataSeeder::class);
        $this->call(ProductExtraGroupTypeDataSeeder::class);
        $this->call(PaymentMethodSeed::class);
        $this->call(PaymentSeed::class);
        $this->call(SocialSeeder::class);

        // Tax::factory(25)->create();

    }
}
