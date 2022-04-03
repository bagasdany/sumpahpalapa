import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:vendor/config/global_config.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> shopsDeliverySaveRequest(
    int id,
    int shopId,
    int active,
    int deliveryTypeId,
    int type,
    double toDay,
    double fromDay,
    double amount) async {
  String url = "$globalUrl/shop/deliveries/save${id != 0 ? "?id=$id" : ""}";

  Map<String, dynamic> responseJson = {};
  final box = GetStorage();
  String jwtToken = box.read('jwtToken') ?? "";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $jwtToken"
  };
  Map<String, dynamic> body = {
    "shop_id": shopId,
    "active": active,
    "delivery_type_id": deliveryTypeId,
    "type": type,
    "start": fromDay,
    "end": toDay,
    "amount": amount
  };

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
