// To parse this JSON data, do
//
//     final ResponseGetLokasiModel = ResponseGetLokasiModelFromJson(jsonString);

// import 'dart:convert';

// ResponseGetLokasiModel ResponseGetLokasiModelFromJson(String str) => ResponseGetLokasiModel.fromJson(json.decode(str));

// String ResponseGetLokasiModelToJson(ResponseGetLokasiModel data) => json.encode(data.toJson());

import '../ResponseJson.dart';

class ResponseGetLokasiModel {
  ResponseGetLokasiModel({
    this.provinces,
    this.commonData,
  });

  List<Province>? provinces;
  ResponseJson? commonData;

  factory ResponseGetLokasiModel.fromJson(Map<String, dynamic> json) =>
      ResponseGetLokasiModel(
        provinces: json["provinces"] == null
            ? null
            : List<Province>.from(
                json["provinces"].map((x) => Province.fromJson(x))),
      );

  factory ResponseGetLokasiModel.errorJson(Map<String, dynamic> parsedJson) {
    return ResponseGetLokasiModel(
      commonData: ResponseJson.errorJson(parsedJson),
      // cities: [],
    );
  }

  Map<String, dynamic> toJson() => {
        "provinces": provinces == null
            ? null
            : List<dynamic>.from(provinces!.map((x) => x.toJson())),
      };
}

class Province {
  Province({
    this.id,
    this.code,
    this.name,
    this.alias,
    this.cities,
    this.commonData,
  });

  int? id;
  String? code;
  String? name;
  String? alias;
  List<City>? cities;
  ResponseJson? commonData;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
        alias: json["alias"] == null ? null : json["alias"],
        cities: json["cities"] == null
            ? null
            : List<City>.from(json["cities"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "name": name == null ? null : name,
        "alias": alias == null ? null : alias,
        "cities": cities == null
            ? null
            : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}

class City {
  City({
    this.id,
    this.isActive,
    this.code,
    this.name,
    this.alias,
    this.provinceId,
    this.kecamatanCount,
    this.m4WArea,
    this.i24,
    this.latitude,
    this.longitude,
    this.tag,
    this.createdAt,
    this.updatedAt,
    this.cityProvinceId,
  });

  int? id;
  int? isActive;
  String? code;
  String? name;
  String? alias;
  int? provinceId;
  int? kecamatanCount;
  int? m4WArea;
  int? i24;
  double? latitude;
  double? longitude;
  String? tag;
  dynamic createdAt;
  DateTime? updatedAt;
  int? cityProvinceId;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"] == null ? null : json["id"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
        alias: json["alias"] == null ? null : json["alias"],
        provinceId: json["provinceId"] == null ? null : json["provinceId"],
        kecamatanCount:
            json["kecamatanCount"] == null ? null : json["kecamatanCount"],
        m4WArea: json["m4wArea"] == null ? null : json["m4wArea"],
        i24: json["i24"] == null ? null : json["i24"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        tag: json["tag"] == null ? null : json["tag"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        cityProvinceId:
            json["province_id"] == null ? null : json["province_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "isActive": isActive == null ? null : isActive,
        "code": code == null ? null : code,
        "name": name == null ? null : name,
        "alias": alias == null ? null : alias,
        "provinceId": provinceId == null ? null : provinceId,
        "kecamatanCount": kecamatanCount == null ? null : kecamatanCount,
        "m4wArea": m4WArea == null ? null : m4WArea,
        "i24": i24 == null ? null : i24,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "tag": tag == null ? null : tag,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "province_id": cityProvinceId == null ? null : cityProvinceId,
      };
}
