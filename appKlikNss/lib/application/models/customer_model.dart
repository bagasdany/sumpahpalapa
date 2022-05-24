class CustomerModel {
  final int? customerId;

  CustomerModel({this.customerId});

  factory CustomerModel.fromJson(Map<String, dynamic> parsedJson) {
    return CustomerModel(
      customerId: parsedJson['customerId'],
    );
  }
}
