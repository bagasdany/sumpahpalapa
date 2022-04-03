<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddNewColumnsForShopDeliveries extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('shop_deliveries', function (Blueprint $table) {
            if (Schema::hasColumns('shop_deliveries', ['from_km', 'to_km']))
            {
                $table->dropColumn(['from_km', 'to_km']);
            }
            if (!Schema::hasColumns('shop_deliveries', ['delivery_type_id', 'type']))
            {
                $table->bigInteger('delivery_type_id')->unsigned();
                $table->tinyInteger('type')->default(1);
                $table->integer('start')->nullable();
                $table->integer('end')->nullable();
            }

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
