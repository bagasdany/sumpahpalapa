import '../ResponseJson.dart';

class RequestVerificationModel {
  final int? customerId;
  final String? name;
  final String? email;
  final String? kodeReferal;
  final ResponseJson? commonData;

  RequestVerificationModel(
      {this.customerId,
      this.name,
      this.email,
      this.commonData,
      this.kodeReferal});

  factory RequestVerificationModel.fromJson(Map<String, dynamic> parsedJson) {
    return RequestVerificationModel(
        customerId: parsedJson['customerId'],
        name: parsedJson['name'],
        email: parsedJson['email'],
        kodeReferal: parsedJson['kodeReferal']);
  }
}
