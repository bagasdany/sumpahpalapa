import 'dart:convert';

import 'package:deliveryboy/config/global_config.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> translationRequest() async {
  String url = "$globalUrl/language/language";
  Map<String, dynamic> responseJson = {};

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };
  Map<String, String> body = {};

  try {
    Response response = await Dio().post(
      url,
      options: Options(headers: headers),
      data: json.encode(body),
    );

    try {
      if (response.statusCode == 200) {
        responseJson = response.data;
      }
    } on FormatException {
      //print(e);
    }
  } catch (e) {
    //print(e);
  }

  return responseJson;
}
