<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePaymentAttributesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('payment_attributes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('payment_id');
            $table->string('tag');
            $table->tinyInteger('position')->nullable();
            $table->string('mask')->nullable();
            $table->string('validation')->nullable();
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
        Schema::dropIfExists('payment_attributes');
    }
}
