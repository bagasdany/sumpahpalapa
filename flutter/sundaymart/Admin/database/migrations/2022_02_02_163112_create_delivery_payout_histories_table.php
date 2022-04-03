<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateDeliveryPayoutHistoriesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('delivery_payout_histories', function (Blueprint $table) {
            $table->id();
            $table->foreignId('order_id');
            $table->foreignId('admin_id');
            $table->decimal('amount', 9)->nullable();
            $table->enum('status', ['success', 'cancel', 'processing']);
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
        Schema::dropIfExists('delivery_payout_histories');
    }
}
