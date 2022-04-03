<?php

namespace App\Repositories\Interfaces;

interface NotificationInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function get($id);

    public function getAllNotifications($collection = []);

    public function datatable($collection = []);

    public function send($id);
}
