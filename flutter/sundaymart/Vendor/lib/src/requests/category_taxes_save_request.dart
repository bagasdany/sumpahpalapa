import 'package:get_storage/get_storage.dart';
import 'package:vendor/config/global_config.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> categoryTaxesSaveRequest(
    int categoryId, int taxId, String id) async {
  String url =
      "$globalUrl/category/tax?category_id=$categoryId&tax_id=$taxId" + id;

  Map<String, dynamic> responseJson = {};
  final box = GetStorage();
  String jwtToken = box.read('jwtToken') ?? "";

  Map<String, String> headers = {"Authorization": "Bearer $jwtToken"};
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
