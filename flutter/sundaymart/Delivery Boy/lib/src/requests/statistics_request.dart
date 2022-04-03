import 'dart:convert';

import 'package:deliveryboy/config/global_config.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> statisticsRequest(int idDeliveryBoy) async {
  String url = "$globalUrl/deliveryboy/statistics";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  Map<String, String> body = {"id_delivery_boy": idDeliveryBoy.toString()};

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
