import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:vendor/config/global_config.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> shippingTransportRequest(int shopId) async {
  String url =
      "$globalUrl/shop/transports/datatable?shop_id=" + shopId.toString();

  Map<String, dynamic> responseJson = {};
  final box = GetStorage();
  String jwtToken = box.read('jwtToken') ?? "";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $jwtToken"
  };

  Map<String, String> body = {};

  try {
    Response response = await Dio().get(
      url,
      options: Options(headers: headers),
    );

    try {
      if (response.statusCode == 200) {
        responseJson = response.data;
      }
    } on FormatException {
      //print(e);
    }
  } catch (e) {
    print(e);
  }

  return responseJson;
}
