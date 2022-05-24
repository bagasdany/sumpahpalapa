// Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

// String welcomeToJson(Welcome data) => json.encode(data.toJson());

import '../ResponseJson.dart';

class ResponseSearchModel {
  ResponseSearchModel({
    this.histories,
    this.commonData,
    this.recommendations,
  });

  List<History>? histories;

  final ResponseJson? commonData;
  Recommendations? recommendations;
  factory ResponseSearchModel.errorJson(Map<String, dynamic> parsedJson) {
    return ResponseSearchModel(
      commonData: ResponseJson.errorJson(parsedJson),
      histories: [],
    );
  }
  factory ResponseSearchModel.fromJson(Map<String, dynamic> json) =>
      ResponseSearchModel(
        histories: List<History>.from(
            json["histories"].map((x) => History.fromJson(x))),
        recommendations: Recommendations.fromJson(json["recommendations"]),
      );

  Map<String, dynamic> toJson() => {
        "histories": List<dynamic>.from(histories!.map((x) => x.toJson())),
        "recommendations": recommendations!.toJson(),
      };
}

class History {
  History({
    this.id,
    this.text,
  });

  int? id;
  String? text;

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
      };
}

class Recommendations {
  Recommendations({
    this.text,
    this.sections,
  });

  String? text;
  List<Section>? sections;

  factory Recommendations.fromJson(Map<String, dynamic> json) =>
      Recommendations(
        text: json["text"],
        sections: List<Section>.from(
            json["sections"].map((x) => Section.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "sections": List<dynamic>.from(sections!.map((x) => x.toJson())),
      };
}

class Section {
  Section({
    this.type,
    this.text,
    this.items,
  });

  String? type;
  String? text;
  List<Item>? items;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        type: json["type"],
        text: json["text"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    this.defaultImage,
    this.type,
    this.defaultImageUrl,
    this.id,
    this.name,
    this.description,
    this.fullDescription,
    this.year,
    this.useStock,
    this.categoryId,
    this.otrPriceFrom,
    this.cashDiscountUpto,
    this.creditDiscountUpto,
    this.reviewCount,
    this.reviewRate,
    this.discussionCount,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.itemType,
    this.brandId,
    this.code,
    this.alias,
    this.price,
    this.priceDiscount,
    this.qty,
  });

  DefaultImage? defaultImage;
  Type? type;
  String? defaultImageUrl;
  int? id;
  String? name;
  String? description;
  String? fullDescription;
  int? year;
  int? useStock;
  int? categoryId;
  int? otrPriceFrom;
  int? cashDiscountUpto;
  int? creditDiscountUpto;
  int? reviewCount;
  double? reviewRate;
  int? discussionCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ImageElement>? images;
  String? itemType;
  int? brandId;
  String? code;
  String? alias;
  int? price;
  int? priceDiscount;
  int? qty;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        defaultImage: json["defaultImage"] == null
            ? null
            : DefaultImage.fromJson(json["defaultImage"]),
        type: json["_type"] == null ? null : typeValues.map![json["_type"]],
        defaultImageUrl: json["defaultImageUrl"],
        id: json["id"],
        name: json["name"],
        description: json["description"] == null ? null : json["description"],
        fullDescription:
            json["fullDescription"] == null ? null : json["fullDescription"],
        year: json["year"] == null ? null : json["year"],
        useStock: json["useStock"] == null ? null : json["useStock"],
        categoryId: json["categoryId"] == null ? null : json["categoryId"],
        otrPriceFrom:
            json["otrPriceFrom"] == null ? null : json["otrPriceFrom"],
        cashDiscountUpto:
            json["cashDiscountUpto"] == null ? null : json["cashDiscountUpto"],
        creditDiscountUpto: json["creditDiscountUpto"] == null
            ? null
            : json["creditDiscountUpto"],
        reviewCount: json["reviewCount"] == null ? null : json["reviewCount"],
        reviewRate: json["reviewRate"].toDouble(),
        discussionCount: json["discussionCount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        images: List<ImageElement>.from(
            json["images"].map((x) => ImageElement.fromJson(x))),
        itemType: json["type"] == null ? null : json["type"],
        brandId: json["brandId"] == null ? null : json["brandId"],
        code: json["code"] == null ? null : json["code"],
        alias: json["alias"] == null ? null : json["alias"],
        price: json["price"] == null ? null : json["price"],
        priceDiscount:
            json["priceDiscount"] == null ? null : json["priceDiscount"],
        qty: json["qty"] == null ? null : json["qty"],
      );

  Map<String, dynamic> toJson() => {
        "defaultImage": defaultImage == null ? null : defaultImage!.toJson(),
        "_type": type == null ? null : typeValues.reverse![type],
        "defaultImageUrl": defaultImageUrl,
        "id": id,
        "name": name,
        "description": description == null ? null : description,
        "fullDescription": fullDescription == null ? null : fullDescription,
        "year": year == null ? null : year,
        "useStock": useStock == null ? null : useStock,
        "categoryId": categoryId == null ? null : categoryId,
        "otrPriceFrom": otrPriceFrom == null ? null : otrPriceFrom,
        "cashDiscountUpto": cashDiscountUpto == null ? null : cashDiscountUpto,
        "creditDiscountUpto":
            creditDiscountUpto == null ? null : creditDiscountUpto,
        "reviewCount": reviewCount == null ? null : reviewCount,
        "reviewRate": reviewRate,
        "discussionCount": discussionCount,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "type": itemType == null ? null : itemType,
        "brandId": brandId == null ? null : brandId,
        "code": code == null ? null : code,
        "alias": alias == null ? null : alias,
        "price": price == null ? null : price,
        "priceDiscount": priceDiscount == null ? null : priceDiscount,
        "qty": qty == null ? null : qty,
      };
}

class DefaultImage {
  DefaultImage({
    this.image,
    this.id,
    this.seriesId,
    this.typeId,
    this.colorId,
    this.alt,
    this.createdAt,
    this.updatedAt,
  });

  DefaultImageImage? image;
  int? id;
  int? seriesId;
  int? typeId;
  int? colorId;
  dynamic alt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DefaultImage.fromJson(Map<String, dynamic> json) => DefaultImage(
        image: DefaultImageImage.fromJson(json["image"]),
        id: json["id"],
        seriesId: json["seriesId"],
        typeId: json["typeId"],
        colorId: json["colorId"],
        alt: json["alt"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "image": image!.toJson(),
        "id": id,
        "seriesId": seriesId,
        "typeId": typeId,
        "colorId": colorId,
        "alt": alt,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}

class DefaultImageImage {
  DefaultImageImage({
    this.path,
  });

  String? path;

  factory DefaultImageImage.fromJson(Map<String, dynamic> json) =>
      DefaultImageImage(
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
      };
}

class ImageElement {
  ImageElement({
    this.image,
    this.id,
    this.seriesId,
    this.typeId,
    this.colorId,
    this.alt,
    this.createdAt,
    this.updatedAt,
    this.sparepartId,
    this.imageUrl,
    this.index,
  });

  DefaultImageImage? image;
  int? id;
  int? seriesId;
  int? typeId;
  int? colorId;
  dynamic alt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? sparepartId;
  String? imageUrl;
  int? index;

  factory ImageElement.fromJson(Map<String, dynamic> json) => ImageElement(
        image: json["image"] == null
            ? null
            : DefaultImageImage.fromJson(json["image"]),
        id: json["id"],
        seriesId: json["seriesId"] == null ? null : json["seriesId"],
        typeId: json["typeId"] == null ? null : json["typeId"],
        colorId: json["colorId"] == null ? null : json["colorId"],
        alt: json["alt"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        sparepartId: json["sparepartId"] == null ? null : json["sparepartId"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        index: json["index"] == null ? null : json["index"],
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image!.toJson(),
        "id": id,
        "seriesId": seriesId == null ? null : seriesId,
        "typeId": typeId == null ? null : typeId,
        "colorId": colorId == null ? null : colorId,
        "alt": alt,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "sparepartId": sparepartId == null ? null : sparepartId,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "index": index == null ? null : index,
      };
}

enum Type { HMC }

final typeValues = EnumValues({"hmc": Type.HMC});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
