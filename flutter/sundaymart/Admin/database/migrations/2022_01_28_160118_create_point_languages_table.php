<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePointLanguagesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('point_languages', function (Blueprint $table) {
            $table->id();
            $table->foreignId('point_id')->constrained('points')->onDelete('cascade');
            $table->string('name', 255)->nullable();
            $table->text('description')->nullable();
            $table->unsignedInteger('lang_id');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('point_languages');
    }
}
