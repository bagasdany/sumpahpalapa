<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTransactionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('transactions', function (Blueprint $table) {
            $table->increments('id');
            $table->bigInteger('shop_id');
            $table->bigInteger('client_id')->nullable();
            $table->bigInteger('admin_id')->nullable();
            $table->bigInteger('order_id')->nullable();
            $table->string('payment_sys_trans_id', 255)->default('shop');
            $table->integer('payment_sys_id')->nullable();
            $table->string('type')->default('credit');
            $table->bigInteger('amount');
            $table->text('note')->nullable();
            $table->string('currency')->nullable();
            $table->timestamp('perform_time')->nullable();
            $table->timestamp('refund_time')->nullable();
            $table->string('status');
            $table->string('status_description');
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
        Schema::dropIfExists('transactions');
    }
}
