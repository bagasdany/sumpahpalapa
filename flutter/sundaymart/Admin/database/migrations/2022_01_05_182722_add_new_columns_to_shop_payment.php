<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddNewColumnsToShopPayment extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('shop_payment', function (Blueprint $table) {
            if (Schema::hasColumns('shop_payment', ['api_key', 'status']))
            {
                $table->dropColumn(['api_key', 'status']);
            }
            if (!Schema::hasColumns('shop_payment', ['key_id', 'secret_id']))
            {
                $table->string('key_id', 255)->nullable();
                $table->string('secret_id', 255)->nullable();
                $table->boolean('active')->default(1);
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
        Schema::table('shop_payment', function (Blueprint $table) {
            //
        });
    }
}
