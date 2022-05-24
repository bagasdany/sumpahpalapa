import '../ResponseJson.dart';

class RequestVerificationModel {
  final int? customerId;
  final int? verificationCode;
  final String? token;

  final ResponseJson? commonData;

  RequestVerificationModel(
      {this.customerId, this.verificationCode, this.token, this.commonData});

  factory RequestVerificationModel.fromJson(Map<String, dynamic> parsedJson) {
    return RequestVerificationModel(
        customerId: parsedJson['customerId'],
        verificationCode: parsedJson['verificationCode'],
        token: parsedJson['token']);
  }
}
