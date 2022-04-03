<?php
namespace App\Traits;

trait SendNotification {
    private $push_token = "AAAA5_EU5F8:APA91bHHXoSXt4cToBeCDNKPnKlxdqRA9dhLC33KQ8rQtXVYt51JFmS9_7wATcNX08cvG3DEbxn8DtAaT09iQFYizKLzktyVkmbpGBs9TRfFJ2k77RVfNfTyjU93Iuzbxa15mXzz5nYv";

    public function sendNotification($senders, $title) {
        $url = 'https://fcm.googleapis.com/fcm/send';

        $fields = array(
            'registration_ids' => $senders,
            "notification" => [
                "body" => $title,
                "title" => "Githubit.com",
                //"icon" => "ic_launcher"
            ],
        );
        $fields = json_encode($fields);

        $headers = array(
            'Authorization: key=' . $this->push_token,
            'Content-Type: application/json'
        );

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);

        $result = curl_exec($ch);
        curl_close($ch);

        return $result;
    }

    public function sendNotificationtoSingleUser($id, $message) {
        $url = 'https://fcm.googleapis.com/fcm/send';

        $fields = array(
            'to' => $id,
            "notification" => [
                "body" => $message,
                "title" => "Githubit.com",
                //"icon" => "ic_launcher"
            ],
        );
        $fields = json_encode($fields);

        $headers = array(
            'Authorization: key=' . $this->push_token,
            'Content-Type: application/json'
        );

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);

        $result = curl_exec($ch);
        curl_close($ch);

        return $result;
    }
}
