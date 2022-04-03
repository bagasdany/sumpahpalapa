import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:vendor/config/global_config.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> categorySaveRequest(
    int id,
    Map<String, String> name,
    int parentCategoryId,
    int shopId,
    String imagePath,
    bool active) async {
  String url = "$globalUrl/category/save";

  Map<String, dynamic> responseJson = {};
  final box = GetStorage();
  String jwtToken = box.read('jwtToken') ?? "";

  Map<String, String> headers = {"Authorization": "Bearer $jwtToken"};
  Map<String, dynamic> body = {
    "id": id,
    "name": name,
    "active": active,
    "shop_id": shopId,
    "parent": parentCategoryId,
    "image_path": imagePath,
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
