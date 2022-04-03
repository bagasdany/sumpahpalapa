<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePaymentAttributeLanguagesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('payment_attribute_languages', function (Blueprint $table) {
            $table->id();
            $table->string('name')->nullable();

            $table->foreignId('payment_attribute_id')->references('id')
                ->on('payment_attributes')->onDelete('cascade');
            $table->bigInteger('lang_id')->unsigned();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('payment_attribute_languages');
    }
}
