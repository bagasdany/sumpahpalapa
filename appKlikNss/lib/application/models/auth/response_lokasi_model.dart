import '../ResponseJson.dart';

class ResponseLokasiModel {
  final int? id;
  final String? code;
  final String? name;
  final String? alias;
  final ResponseJson? commonData;

  ResponseLokasiModel(
      {this.id, this.code, this.name, this.alias, this.commonData});

  factory ResponseLokasiModel.fromJson(Map<String, dynamic> parsedJson) {
    return ResponseLokasiModel(
      id: parsedJson['id'],
      code: parsedJson['code'],
      name: parsedJson['name'],
      alias: parsedJson['alias'],
    );
  }

  factory ResponseLokasiModel.errorJson(Map<String, dynamic> parsedJson) {
    return ResponseLokasiModel(commonData: ResponseJson.errorJson(parsedJson));
  }
}
