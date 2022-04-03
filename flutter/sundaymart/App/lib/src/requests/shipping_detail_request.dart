import 'dart:convert';

import 'package:githubit/config/global_config.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> shippingDetailRequest(int idShop) async {
  String url = "$GLOBAL_URL/shops/$idShop";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  final client = new http.Client();

  final response = await client.post(Uri.parse(url), headers: headers);

  Map<String, dynamic> responseJson = {};

  try {
    if (response.statusCode == 200)
      responseJson = json.decode(response.body) as Map<String, dynamic>;
  } on FormatException catch (e) {
    print(e);
  }

  return responseJson;
}
