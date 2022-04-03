<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTicketsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tickets', function (Blueprint $table) {
            $table->id();
            $table->bigInteger('client_id');
            $table->bigInteger('shop_id')->nullable();
            $table->bigInteger('order_id')->nullable();
            $table->bigInteger('parent_id')->default(0);
            $table->string('type')->default('question');
            $table->string('subject', 255);
            $table->text('content');
            $table->enum('status',['created', 'accepted', 'approved', 'rejected'])->default('created');
            $table->boolean('is_read')->default(false);
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
        Schema::dropIfExists('tickets');
    }
}
