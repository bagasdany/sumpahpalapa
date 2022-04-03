<?php

namespace App\Http\Controllers;

use App\Repositories\Interfaces\NotificationInterface;
use Illuminate\Http\Request;


class NotificationsController extends Controller
{
    private $notificationRepository;

    public function __construct(NotificationInterface $notification)
    {
        $this->notificationRepository = $notification;
    }

    public function save(Request $request)
    {
        return $this->notificationRepository->createOrUpdate($request->all());
    }

    public function datatable(Request $request)
    {
        return $this->notificationRepository->datatable($request->all());
    }

    public function get(Request $request)
    {
        return $this->notificationRepository->get($request->id);
    }

    public function delete(Request $request)
    {
        return $this->notificationRepository->delete($request->id);
    }

    public function sendNotification(Request $request)
    {
        return $this->notificationRepository->send($request->id);
    }
}
