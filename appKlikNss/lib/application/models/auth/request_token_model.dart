class RequestTokenModel {
  final String? token;

  RequestTokenModel({this.token});

  factory RequestTokenModel.fromJson(Map<String, dynamic> parsedJson) {
    return RequestTokenModel(token: parsedJson['token']);
  }
}
