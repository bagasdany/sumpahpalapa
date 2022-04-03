<?php

namespace App\Http\Controllers;

use App\Repositories\Interfaces\OrderInterface;
use App\Traits\SendNotification;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    use SendNotification;

    private $orderRepository;

    public function __construct(OrderInterface $order)
    {
        $this->orderRepository = $order;
    }

    public function save(Request $request)
    {
        return $this->orderRepository->createOrUpdate($request->all());
    }

    public function statusDatatable(Request $request)
    {
        return $this->orderRepository->orderStatusDatatable($request->all());
    }

    public function activeStatus()
    {
        return $this->orderRepository->getActiveStatus();
    }

    public function datatable(Request $request)
    {
        return $this->orderRepository->datatable($request->all());
    }

    public function delete(Request $request)
    {
        return $this->orderRepository->delete($request->id);
    }

    public function get(Request $request)
    {
        return $this->orderRepository->get($request->id);
    }

    public function commentsDatatable(Request $request)
    {
        return $this->orderRepository->commentsDatatable($request->all());
    }

    public function getActiveClients()
    {
        return $this->orderRepository->getActiveClients();
    }

    public function getTotalOrdersCount()
    {
        return $this->orderRepository->getTotalOrdersCount();
    }

    public function getOrdersStaticByStatus()
    {
        return $this->orderRepository->getOrdersStaticByStatus();
    }

    public function getShopsSalesInfo()
    {
        return $this->orderRepository->getShopsSalesInfo();
    }

    public function getDeliveryBoyOrder(Request $request)
    {
        return $this->orderRepository->getOrderForDeliveryBoy($request->all());
    }

    public function getDeliveryBoyStatistics(Request $request) {
        return $this->orderRepository->getDeliveryBoyStatistics($request->id_delivery_boy);
    }

    public function changeStatus(Request $request) {
        return $this->orderRepository->changeOrderStatus($request->id, $request->status);
    }

    public function deliveryBoyOrderStatus(Request $request)
    {
        return $this->orderRepository->deliveryBoyOrderStatus($request->order_id, $request->admin_id, $request->status);
    }

    public function orderDeliveryCount(Request $request){
        return $this->orderRepository->deliveryCount($request->all());
    }

    public function refundOrderTransaction(Request $request){
        return $this->orderRepository->refundOrderTransaction($request->all());
    }

    public function getDeliveryBoyPayoutHistory(Request $request) {
        return $this->orderRepository->getDeliveryPayoutHistory($request->all());
    }
}
