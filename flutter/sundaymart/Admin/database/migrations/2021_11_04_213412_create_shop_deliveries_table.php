<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateShopDeliveriesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('shop_deliveries', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('shop_id')->unsigned();
            $table->integer('from_km');
            $table->integer('to_km')->nullable();
            $table->double('amount', 22, 2);
            $table->boolean('active')->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('shop_deliveries');
    }
}
