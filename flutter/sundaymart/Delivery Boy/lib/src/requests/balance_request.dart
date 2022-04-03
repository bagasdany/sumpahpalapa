import 'package:deliveryboy/config/global_config.dart';
import 'package:dio/dio.dart';

Future<Map<String, dynamic>> balanceRequest(int id) async {
  String url = "$globalUrl/deliveryboy/balance/$id";
  Map<String, dynamic> responseJson = {};

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

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
    //print(e);
  }

  return responseJson;
}
