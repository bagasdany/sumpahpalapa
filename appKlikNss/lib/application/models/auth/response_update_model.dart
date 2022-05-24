import '../ResponseJson.dart';

class ResponseUpdateModel {
  final String? name;
  final String? email;
  final ResponseJson? commonData;

  ResponseUpdateModel({this.name, this.email, this.commonData});

  factory ResponseUpdateModel.fromJson(Map<String, dynamic> parsedJson) {
    return ResponseUpdateModel(
      name: parsedJson['name'],
      email: parsedJson['email'],
    );
  }

  factory ResponseUpdateModel.errorJson(Map<String, dynamic> parsedJson) {
    return ResponseUpdateModel(commonData: ResponseJson.errorJson(parsedJson));
  }
}
