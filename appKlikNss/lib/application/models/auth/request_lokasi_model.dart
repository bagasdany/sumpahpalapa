import '../ResponseJson.dart';

class RequestTokenModel {
  final String? lat;
  final String? lng;
  final ResponseJson? commonData;

  RequestTokenModel({this.lat, this.lng, this.commonData});

  factory RequestTokenModel.fromJson(Map<String, dynamic> parsedJson) {
    return RequestTokenModel(lat: parsedJson['lat'], lng: parsedJson['lng']);
  }
}
