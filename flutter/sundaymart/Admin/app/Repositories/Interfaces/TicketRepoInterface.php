<?php

namespace App\Repositories\Interfaces;

interface TicketRepoInterface
{
    public function datatable($array);

    public function createOrUpdate($array);

    public function get($id, $is_read = null);

    public function changeStatus($id, $status);
}
