import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:vendor/config/global_config.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> ordersRequest(
    int status, int limit, int offset, String search) async {
  search = search +
      (search.length > 1 ? "" : "?=") +
      (status != 0
          ? "&status=" + (status == 2 ? "2,3" : status.toString())
          : "");

  String url = "$globalUrl/order/datatable$search";

  Map<String, dynamic> responseJson = {};
  final box = GetStorage();
  String jwtToken = box.read('jwtToken') ?? "";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $jwtToken"
  };

  Map<String, String> body = {
    "length": limit.toString(),
    "start": offset.toString()
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
    print(e);
  }

  return responseJson;
}
