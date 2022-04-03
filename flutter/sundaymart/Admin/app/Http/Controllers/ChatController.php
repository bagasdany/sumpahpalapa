<?php

namespace App\Http\Controllers;
use App\Http\Requests;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use LRedis;

class ChatController extends Controller {
    public function sendMessage(Request $request){
        $redis = LRedis::connection();
        $data = ['message' => $request->message, 'user' => $request->user];
        $result = $redis->publish('message', json_encode($data));
        return response()->json([
            $data,
            $result
        ]);
    }
}
