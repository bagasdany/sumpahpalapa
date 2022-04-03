<?php

namespace App\Repositories\Interfaces;

interface OrderInterface
{
    public function delete($id);

    public function createOrUpdate($collection = []);

    public function createOrUpdateForRest($collection = []);

    public function get($id);

    public function changeOrderStatus($id_order, $status);

    public function getOrderDetailByStatusForRest($collection = []);

    public function getOrderCountByStatusAndClient($collection = []);

    public function orderStatusDatatable($collection = []);

    public function getActiveStatus();

    public function datatable($collection = []);

    public function orderCommentCreate($array);

    public function commentsDatatable($collection = []);

    public function getActiveClients();

    public function getTotalOrdersCount();

    public function getOrdersStaticByStatus();

    public function getShopsSalesInfo();

    public function getOrderForDeliveryBoy($collection = []);

    public function getDeliveryBoyStatistics($id_delivery_boy);

    public function deliveryBoyOrderStatus($order_id, $admin_id, $status);

    public function checkoutForRest($array = []);

    public function refundOrderTransaction($array = []);

    public function getDeliveryPayoutHistory($array = []);

}
