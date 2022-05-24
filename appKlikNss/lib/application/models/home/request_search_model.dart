class RequestSearchModel {
  final String? key;

  RequestSearchModel({this.key});

  factory RequestSearchModel.fromJson(Map<String, dynamic> parsedJson) {
    return RequestSearchModel(key: parsedJson['key']);
  }
}
