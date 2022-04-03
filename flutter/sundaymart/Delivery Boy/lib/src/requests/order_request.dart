import 'dart:convert';

import 'package:deliveryboy/config/global_config.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> orderRequest(
    int idLang, int idDeliveryBoy, int status, int offset, int limit) async {
  String url = "$globalUrl/deliveryboy/order";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  Map<String, String> body = {
    "offset": offset.toString(),
    "limit": limit.toString(),
    "status": status.toString(),
    "id_lang": idLang.toString(),
    "id_delivery_boy": idDeliveryBoy.toString()
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
