<?php

namespace App\Repositories\Interfaces;

interface PointInterface
{
    public function datatable($array);

    public function createOrUpdate($array);

    public function get($id);

    public function active($array);

    public function pointRateSave($array);

    public function pointRateShow();
}
