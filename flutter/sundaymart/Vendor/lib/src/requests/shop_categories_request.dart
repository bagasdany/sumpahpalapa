import 'package:get_storage/get_storage.dart';
import 'package:vendor/config/global_config.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> shopCategoriesRequest() async {
  String url = "$globalUrl/shop-category/active";

  Map<String, dynamic> responseJson = {};
  final box = GetStorage();
  String jwtToken = box.read('jwtToken') ?? "";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $jwtToken"
  };

  try {
    Response response = await Dio().post(
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
    //print(e);
  }

  return responseJson;
}
