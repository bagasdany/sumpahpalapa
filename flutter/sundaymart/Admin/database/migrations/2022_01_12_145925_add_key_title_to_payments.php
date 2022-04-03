<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddKeyTitleToPayments extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('payment_language', function (Blueprint $table) {
            if (!Schema::hasColumns('payment_language', ['key_title', 'secret_title']))
            {
                $table->string('key_title', 255)->nullable();
                $table->string('secret_title', 255)->nullable();
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
        Schema::table('payment_language', function (Blueprint $table) {
            //
        });
    }
}
