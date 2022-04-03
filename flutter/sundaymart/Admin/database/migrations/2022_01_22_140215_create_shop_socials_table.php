<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateShopSocialsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('shop_socials', function (Blueprint $table) {
            $table->id();
            $table->foreignId('shop_id');
            $table->foreignId('social_id')->constrained('socials')->onDelete('cascade');
            $table->string('link', 255)->nullable();
            $table->boolean('active')->default(1);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('shop_socials');
    }
}
