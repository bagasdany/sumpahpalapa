import '../ResponseJson.dart';

class ResponseOtpModel {
  final int? customerId;
  final int? verificationCode;
  final ResponseJson? commonData;
  ResponseOtpModel({this.customerId, this.verificationCode, this.commonData});

  factory ResponseOtpModel.fromJson(Map<String, dynamic> parsedJson) {
    return ResponseOtpModel(
        customerId: parsedJson['customerId'],
        verificationCode: parsedJson['verificationCode'],
        commonData: parsedJson['commonData']);
  }

  factory ResponseOtpModel.errorJson(Map<String, dynamic> parsedJson) {
    return ResponseOtpModel(commonData: ResponseJson.errorJson(parsedJson));
  }
}
