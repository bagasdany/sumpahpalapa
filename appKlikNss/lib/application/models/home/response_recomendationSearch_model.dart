import '../ResponseJson.dart';

class ResponseRecomendationModel {
  ResponseRecomendationModel({
    this.results,
    this.commonData,
    this.recommendationss,
  });

  final ResponseJson? commonData;
  List<Resulttext>? results;

  Recommendationss? recommendationss;

  factory ResponseRecomendationModel.fromJson(Map<String, dynamic> json) =>
      ResponseRecomendationModel(
        results: json["results"] == null
            ? null
            : List<Resulttext>.from(
                json["results"].map((x) => Resulttext.fromJson(x))),
        recommendationss: json["recommendations"] == null
            ? null
            : Recommendationss.fromJson(json["recommendations"]),
      );

  factory ResponseRecomendationModel.errorJson(
      Map<String, dynamic> parsedJson) {
    return ResponseRecomendationModel(
      commonData: ResponseJson.errorJson(parsedJson),
      // results: [],
    );
  }

  Map<String, dynamic> toJson() => {
        "results": results == null
            ? null
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "recommendations":
            recommendationss == null ? null : recommendationss!.toJson(),
      };
}

class Recommendationss {
  Recommendationss({
    this.text,
    this.sections,
  });

  String? text;
  List<Sections>? sections;

  factory Recommendationss.fromJson(Map<String, dynamic> json) =>
      Recommendationss(
        text: json["text"],
        sections: List<Sections>.from(
            json["sections"].map((x) => Sections.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "sections": List<dynamic>.from(sections!.map((x) => x.toJson())),
      };
}

class Sections {
  Sections({
    this.type,
    this.text,
    this.items,
  });

  String? type;
  String? text;
  List<Itemss>? items;

  factory Sections.fromJson(Map<String, dynamic> json) => Sections(
        type: json["type"],
        text: json["text"],
        items: List<Itemss>.from(json["items"].map((x) => Itemss.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "text": text,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Itemss {
  Itemss({
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
  Typee? type;
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

  factory Itemss.fromJson(Map<String, dynamic> json) => Itemss(
        defaultImage: json["defaultImage"] == null
            ? null
            : DefaultImage.fromJson(json["defaultImage"]),
        type: json["_type"] == null ? null : typeValuess.map![json["_type"]],
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
        "_type": type == null ? null : typeValuess.reverse![type],
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

class Resulttext {
  Resulttext({
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
    this.resultType,
    this.brandId,
    this.code,
    this.alias,
    this.price,
    this.priceDiscount,
    this.qty,
  });

  DefaultImage? defaultImage;
  String? type;
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
  String? resultType;
  int? brandId;
  String? code;
  String? alias;
  int? price;
  int? priceDiscount;
  int? qty;

  factory Resulttext.fromJson(Map<String, dynamic> json) => Resulttext(
        defaultImage: json["defaultImage"] == null
            ? null
            : DefaultImage.fromJson(json["defaultImage"]),
        type: json["_type"] == null ? null : json["_type"],
        defaultImageUrl:
            json["defaultImageUrl"] == null ? null : json["defaultImageUrl"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
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
        reviewRate:
            json["reviewRate"] == null ? null : json["reviewRate"].toDouble(),
        discussionCount:
            json["discussionCount"] == null ? null : json["discussionCount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        images: json["images"] == null
            ? null
            : List<ImageElement>.from(
                json["images"].map((x) => ImageElement.fromJson(x))),
        resultType: json["type"] == null ? null : json["type"],
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
        "_type": type == null ? null : type,
        "defaultImageUrl": defaultImageUrl == null ? null : defaultImageUrl,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
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
        "reviewRate": reviewRate == null ? null : reviewRate,
        "discussionCount": discussionCount == null ? null : discussionCount,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "images": images == null
            ? null
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "type": resultType == null ? null : resultType,
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
        image: json["image"] == null
            ? null
            : DefaultImageImage.fromJson(json["image"]),
        id: json["id"] == null ? null : json["id"],
        seriesId: json["seriesId"] == null ? null : json["seriesId"],
        typeId: json["typeId"] == null ? null : json["typeId"],
        colorId: json["colorId"] == null ? null : json["colorId"],
        alt: json["alt"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image!.toJson(),
        "id": id == null ? null : id,
        "seriesId": seriesId == null ? null : seriesId,
        "typeId": typeId == null ? null : typeId,
        "colorId": colorId == null ? null : colorId,
        "alt": alt,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class DefaultImageImage {
  DefaultImageImage({
    this.path,
  });

  String? path;

  factory DefaultImageImage.fromJson(Map<String, dynamic> json) =>
      DefaultImageImage(
        path: json["path"] == null ? null : json["path"],
      );

  Map<String, dynamic> toJson() => {
        "path": path == null ? null : path,
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
        id: json["id"] == null ? null : json["id"],
        seriesId: json["seriesId"] == null ? null : json["seriesId"],
        typeId: json["typeId"] == null ? null : json["typeId"],
        colorId: json["colorId"] == null ? null : json["colorId"],
        alt: json["alt"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        sparepartId: json["sparepartId"] == null ? null : json["sparepartId"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        index: json["index"] == null ? null : json["index"],
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image!.toJson(),
        "id": id == null ? null : id,
        "seriesId": seriesId == null ? null : seriesId,
        "typeId": typeId == null ? null : typeId,
        "colorId": colorId == null ? null : colorId,
        "alt": alt,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "sparepartId": sparepartId == null ? null : sparepartId,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "index": index == null ? null : index,
      };
}

enum Typee { HMC }

final typeValuess = EnumValuess({"hmc": Typee.HMC});

class EnumValuess<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValuess(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
