import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:githubit/src/controllers/auth_controller.dart';
import 'package:githubit/src/controllers/shop_controller.dart';
import 'package:githubit/src/models/chat_user.dart';
import 'package:githubit/src/models/dialog.dart';
import 'package:githubit/src/models/message.dart';
import 'package:githubit/src/models/shop.dart';
import 'package:githubit/src/models/user.dart';
import 'package:githubit/src/requests/chat_dialog_request.dart';
import 'package:githubit/src/requests/chat_message_request.dart';
import 'package:githubit/src/requests/shop_user_request.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatController extends GetxController {
  final ShopController shopController = Get.put(ShopController());
  final AuthController authController = Get.put(AuthController());
  var user = Rxn<ChatUser>();
  final List<dynamic> messages = [];
  var dialogs = <Dialog>[].obs;
  var activeDialogId = 0.obs;
  TextEditingController? textEditingController = new TextEditingController();
  final ScrollController scrollController = ScrollController();
  IO.Socket? socket;
  var unreadedMessage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getShopUser();
    initSocket();
  }

  void initSocket() async {
    try {
      socket = IO.io(
        'https://sundaymart.net:3001',
        IO.OptionBuilder()
            .disableAutoConnect()
            .setTransports(['websocket']).build(),
      );

      socket!.onConnect((_) => print('connect'));
      socket!.on('message', (data) {
        User client = authController.user.value!;
        data = jsonDecode(data);
        int dialogId = int.parse(data['dialog_id'].toString());
        int index = dialogs.indexWhere((element) => element.id == dialogId);

        if (index > -1) {
          List<Message> messageList = dialogs[index].messages!;
          messageList.add(Message(
              text: data['text'],
              sendDateTime: DateTime.parse(data['created_at'].toString()),
              userId: int.parse(data['user_id'].toString()),
              isSent: int.parse(data['user_id'].toString()) == client.id,
              isRead: data['is_read'] != null
                  ? int.parse(data['is_read'].toString())
                  : 1));

          dialogs.add(Dialog(id: dialogId, messages: messageList));

          //unreadedMessage.value = unreadedMessage.value + 1;

          // if (int.parse(data['user_id'].toString()) != client.id)
          //   Get.dialog(ChatMessageDialog(
          //     message: data['text'],
          //     onTap: () {
          //       this.dialog(user.value!.id!, 1);
          //       Get.back();
          //       Get.toNamed("/chat");
          //     },
          //   ));
        }
      });

      socket!.onDisconnect((_) => print('disconnect'));

      socket!.connect();
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getShopUser() async {
    Shop? shop = shopController.defaultShop.value;
    int shopId = -1;
    if (shop != null && shop.id != null) {
      shopId = shop.id!;
    }
    Map<String, dynamic> data = await shopsUserRequest(shopId);

    if (data['success']) {
      user.value = ChatUser(
          id: data['data']['id'],
          name: "${data['data']['name']} ${data['data']['surname']}",
          imageUrl: data['data']['image_url'],
          role: int.parse(data['data']['id_role'].toString()));

      user.refresh();

      if (authController.user.value != null &&
          authController.user.value!.id != null)
        this.dialog(data['data']['id'], 1);
    }
  }

  void send() async {
    User client = authController.user.value!;
    String text = textEditingController!.text;
    await chatMessageRequest(client.id!, activeDialogId.value, text);

    textEditingController!.text = "";
  }

  void dialog(userId, type) async {
    User client = authController.user.value!;
    Map<String, dynamic> data =
        await chatDialogRequest(client.id!, userId, type);

    List<Message> messageList = [];
    int id = data['id'];
    activeDialogId.value = id;
    int index = dialogs.indexWhere((item) => item.id == id);
    if (index == -1) {
      if (data['messages'].length > 0) {
        for (int i = 0; i < data['messages'].length; i++) {
          messageList.add(Message(
              sendDateTime:
                  DateTime.parse(data['messages'][i]['created_at'].toString()),
              text: data['messages'][i]['text'],
              userId: data['messages'][i]['user_id'],
              isSent: data['messages'][i]['user_id'] == client.id,
              isRead: data['messages'][i]['is_read'],
              isNew: false));
        }
      }

      dialogs.add(Dialog(id: id, messages: messageList));
    } else {
      if (data['messages'].length > 0) {
        for (int i = 0; i < data['messages'].length; i++) {
          messageList.add(Message(
              text: data['messages'][i]['text'],
              sendDateTime:
                  DateTime.parse(data['messages'][i]['created_at'].toString()),
              userId: data['messages'][i]['user_id'],
              isSent: data['messages'][i]['user_id'] == client.id,
              isRead: data['messages'][i]['is_read'],
              isNew: false));
        }
      }

      dialogs[index].messages = messageList;
    }
  }

  List<Message> getActiveDialogMessages() {
    List<Message> messageList = [];

    int index = dialogs.indexWhere((item) => item.id == activeDialogId.value);
    if (index > -1) {
      messageList = dialogs[index].messages!;
    }

    return messageList.reversed.toList();
  }

  void getNewMessageCount(int dialogId) {
    int count = 0;
    int index = dialogs.indexWhere((item) => item.id == dialogId);
    if (index > -1) {
      count = dialogs[index]
          .messages!
          .where((item) => item.isNew == true)
          .toList()
          .length;
    }

    unreadedMessage.value = count;
  }

  void makeReaded(int dialogId) {
    int index = dialogs.indexWhere((item) => item.id == dialogId);
    if (index > -1) {
      List<Message> message = dialogs[index].messages!;
      for (int i = 0; i < message.length; i++) {
        if (message[i].isNew!) {
          message[i].isNew = false;
        }
      }

      dialogs[index].messages = message;
      dialogs.refresh();
    }
  }
}
