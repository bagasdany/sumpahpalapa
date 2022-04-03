import 'dart:convert';

import 'package:deliveryboy/config/global_config.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> signInRequest(
    String phone, String password, String socialId, String pushToken) async {
  String url = "$globalUrl/deliveryboy/login";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  Map<String, String> body = {
    "phone": phone,
    "password": password,
    "push_token": pushToken
  };

  Map<String, dynamic> responseJson = {};

  try {
    Response response = await Dio().post(
      url,
      options: Options(headers: headers),
      data: json.encode(body),
    );

    try {
      if (response.statusCode == 200) responseJson = response.data;
    } on FormatException {
      //print(e);
    }
  } catch (e) {
    //print(e);
  }

  return responseJson;
}
