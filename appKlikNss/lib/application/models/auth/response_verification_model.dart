import '../ResponseJson.dart';

class ResponseVerificationModel {
  final int? customerId, statusCode;
  final bool? isNewCustomer;
  final String? customerName;
  final ResponseJson? commonData;

  ResponseVerificationModel(
      {this.customerId,
      this.isNewCustomer,
      this.commonData,
      this.statusCode,
      this.customerName});

  factory ResponseVerificationModel.fromJson(Map<String, dynamic> parsedJson) {
    return ResponseVerificationModel(
        customerId: parsedJson['customerId'],
        isNewCustomer: parsedJson['isNewCustomer'],
        customerName: parsedJson['customerName']);
  }

  factory ResponseVerificationModel.errorJson(Map<String, dynamic> parsedJson) {
    return ResponseVerificationModel(
        commonData: ResponseJson.errorJson(parsedJson));
  }
}
