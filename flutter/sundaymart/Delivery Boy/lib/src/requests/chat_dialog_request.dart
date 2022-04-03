import 'dart:convert';

import 'package:deliveryboy/config/global_config.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> chatDialogRequest(
    int authId, int otherId, int type) async {
  String url = "$globalUrl/chat/dialog";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  final client = http.Client();

  Map<String, String> body = {
    "auth_id": authId.toString(),
    "other_id": otherId.toString(),
    "type": type.toString()
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
