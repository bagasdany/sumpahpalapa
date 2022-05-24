import 'package:mobileapps/application/models/ResponseJson.dart';

class ResponseTokenModel {
  final String? token, refreshToken;
  final ResponseJson? commonData;
  ResponseTokenModel({this.token, this.refreshToken, this.commonData});

  factory ResponseTokenModel.fromJson(Map<String, dynamic> parsedJson) {
    return ResponseTokenModel(
        token: parsedJson['token'], refreshToken: parsedJson['refreshToken']);
  }

  factory ResponseTokenModel.errorJson(Map<String, dynamic> parsedJson) {
    return ResponseTokenModel(commonData: ResponseJson.errorJson(parsedJson));
  }
}
