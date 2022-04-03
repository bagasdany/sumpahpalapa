<?php

namespace App\Repositories\Interfaces;

interface PaymentInterface
{
    public function methodDatatable($collection = []);

    public function statusDatatable($collection = []);

    public function getActiveStatus();

    public function getActiveMethod();

    public function createOrUpdate($collection = []);

    public function datatable($collection = []);

    public function delete($id);

    public function get($id);

    public function active();

    public function paymentAttributesSave($array = []);

    public function paymentAttributesGet($id);

    public function setPayment($array);

}
