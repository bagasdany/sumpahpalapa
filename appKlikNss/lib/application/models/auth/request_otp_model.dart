import 'package:mobileapps/application/models/ResponseJson.dart';

class RequestOtpModel {
  final String? token;
  final String? mobileNumber;
  final ResponseJson? commonData;

  RequestOtpModel({
    this.mobileNumber,
    this.commonData,
    this.token,
  });

  factory RequestOtpModel.fromJson(Map<String, dynamic> parsedJson) {
    return RequestOtpModel(mobileNumber: parsedJson['mobileNumber']);
  }
}
