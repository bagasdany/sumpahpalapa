class RequestHomeModel {
  final String? token;

  RequestHomeModel({this.token});

  factory RequestHomeModel.fromJson(Map<String, dynamic> parsedJson) {
    return RequestHomeModel(token: parsedJson['token']);
  }
}
