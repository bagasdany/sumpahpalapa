<?php

namespace App\Jobs;

use App\Traits\SendNotification;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldBeUnique;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class SendSingleNotificationJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels, SendNotification;
    protected $key, $message;
    public $tries = 5;
    public $timeout = 120;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($key, $message)
    {
        $this->key = $key;
        $this->message = $message;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        $this->sendNotificationtoSingleUser($this->key, $this->message);
    }
}
