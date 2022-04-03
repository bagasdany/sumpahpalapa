import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:vendor/config/global_config.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> clientSaveRequest(
    name, surname, email, phone, password, imagePath, active, id) async {
  String url = "$globalUrl/client/save";

  Map<String, dynamic> responseJson = {};
  final box = GetStorage();
  String jwtToken = box.read('jwtToken') ?? "";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $jwtToken"
  };
  Map<String, dynamic> body = {
    "name": name,
    "surname": surname,
    "email": email,
    "phone": phone,
    "password": password,
    "image_path": imagePath,
    "active": active,
    "id": id
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
