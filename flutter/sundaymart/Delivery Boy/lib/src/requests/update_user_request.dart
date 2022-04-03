import 'dart:convert';

import 'package:deliveryboy/config/global_config.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> updateUserRequest(
    int id,
    String name,
    String surname,
    String phone,
    String email,
    String password,
    String image,
    int gender,
    int idShop) async {
  String url = "$globalUrl/deliveryboy/update";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };
  Map<String, String> body = {
    "name": name,
    "surname": surname,
    "image_path": image,
    "email": email,
    "phone": phone,
    "id_role": "3",
    "password": password,
    "active": "1",
    "id_shop": idShop.toString()
  };

  Response response = await Dio().post(
    url,
    options: Options(headers: headers),
    data: json.encode(body),
  );

  Map<String, dynamic> responseJson = {};

  try {
    if (response.statusCode == 200) {
      responseJson = response.data;
    }
  } on FormatException {
    //print(e);
  }

  return responseJson;
}
