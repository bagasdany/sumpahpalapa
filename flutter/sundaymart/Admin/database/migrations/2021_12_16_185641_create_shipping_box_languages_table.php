<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateShippingBoxLanguagesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('shipping_box_languages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('shipping_box_id')->references('id')
                ->on('shipping_boxes')->onDelete('cascade');
            $table->foreignId('lang_id');
            $table->string('name')->nullable();
            $table->string('description')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('shipping_box_languages');
    }
}
