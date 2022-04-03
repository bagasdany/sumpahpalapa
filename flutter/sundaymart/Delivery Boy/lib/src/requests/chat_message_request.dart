import 'dart:convert';

import 'package:deliveryboy/config/global_config.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> chatMessageRequest(
    int userId, int dialogId, String text) async {
  String url = "$globalUrl/chat/send";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  final client = http.Client();

  Map<String, String> body = {
    "user_id": userId.toString(),
    "dialog_id": dialogId.toString(),
    "text": text
  };

  final response = await client.post(Uri.parse(url),
      headers: headers, body: json.encode(body));

  Map<String, dynamic> responseJson = {};

  try {
    if (response.statusCode == 200) {
      responseJson = json.decode(response.body) as Map<String, dynamic>;
    }
  } on FormatException {
    //print(e);
  }

  return responseJson;
}
