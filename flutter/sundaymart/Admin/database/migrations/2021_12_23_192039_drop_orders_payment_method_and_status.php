<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class DropOrdersPaymentMethodAndStatus extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('orders', function (Blueprint $table) {
            DB::statement('SET FOREIGN_KEY_CHECKS=0;');
            $table->dropForeign('orders_payment_method_foreign');
            $table->dropForeign('orders_payment_status_foreign');
            $table->dropColumn(['payment_status', 'payment_method']);
            DB::statement('SET FOREIGN_KEY_CHECKS=1;');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {

    }
}
