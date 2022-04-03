<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateShopShippingBoxesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('shop_shipping_boxes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('shop_id');
            $table->foreignId('shipping_box_id');
            $table->integer('start')->default(0);
            $table->integer('end')->nullable();
            $table->double('price',22, 2)->default(0);
            $table->boolean('active');
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
        Schema::dropIfExists('shop_shipping_boxes');
    }
}
