<?php

namespace App\Http\Controllers;

use App\Models\Admin;
use App\Models\Clients;
use App\Models\Dialog;
use App\Models\Message;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use LRedis;

class MessageController extends Controller
{
    public function dialog(Request $request)
    {
        $dialog = Dialog::with('messages')->where(function ($query) use ($request) {
            $query->where([
                'first_id' => $request->auth_id,
                'second_id' =>  $request->other_id,
                'type' => $request->type
            ]);
        })->orwhere(function ($query) use ($request) {
            $query->where([
                'second_id' => $request->auth_id,
                'first_id' => $request->other_id,
                'type' => $request->type
            ]);
        })->first();

        if (!$dialog) {
            $dialog = Dialog::create([
                'first_id' => $request->auth_id,
                'second_id' => $request->other_id,
                'type' => $request->type
            ]);
        }
        foreach ($dialog->messages as $message) {
            if ($message->user_id == $request->other_id) {
                $message->update(['is_read' => 1]);
            }
        }

        return response()->json($dialog);
    }

    public function sendMessage(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'text' => 'required|min:1|max:500'
        ]);


        if ($validator->fails()) {
            return response()->json($validator->errors());
        }

        $message = Message::create([
            'user_id' => $request->user_id,
            'text' => $request->text,
            'dialog_id' => $request->dialog_id
        ]);

        if ($message) {
            $dialog_id = $message->dialog_id;

            $dialog = Dialog::where('id', $dialog_id)->first();
            $dialog->update(['updated_at' => Carbon::now()]);

            $redis = LRedis::connection();
            $redis->publish('message', json_encode($message));

            return response()->json([
                'success' => 1,
                'msg' => "Message send"
            ]);
        }
    }

    public function getChatUsers(Request $request)
    {
        $dialogs = Dialog::where('second_id', '=', $request->id)->get();

        $users = [];
        foreach ($dialogs as $dialog) {
            $client = Clients::find($dialog['first_id']);
            if ($client)
                $users[] = [
                    "user" => $client,
                    "dialog_id" => $dialog['id']
                ];
            else {
                $admin = Admin::find($dialog['first_id']);
                if($admin)
                    $users[] = [
                        "user" => $admin,
                        "dialog_id" => $dialog['id']
                    ];
            }
        }

        return response()->json([
            'success' => 1,
            'msg' => "Success",
            'data' => $users
        ]);
    }

    public function getMessages(Request $request)
    {
        $dialog = Dialog::with('messages')->where("id", $request->dialog_id)->first();
        return response()->json([
            'success' => 1,
            'msg' => "Success",
            'data' => $dialog
        ]);
    }
}
