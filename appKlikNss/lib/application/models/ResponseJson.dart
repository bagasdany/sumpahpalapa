class ResponseJson {
  String? msg, code, data;
  Map? dataMap;

  ResponseJson({this.msg, this.code, this.data, this.dataMap});

  factory ResponseJson.errorJson(Map<String, dynamic> parsedJson) {
    Map<String, dynamic>? dataMap;

    // if (parsedJson['data'] != null) {
    //   dataMap = Map<String, dynamic>.from(parsedJson['data']);
    // }

    return ResponseJson(
      msg: parsedJson['errors'],
      // dataMap: dataMap,
    );
  }
}
