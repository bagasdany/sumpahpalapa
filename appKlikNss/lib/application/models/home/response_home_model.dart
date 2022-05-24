import '../ResponseJson.dart';

class ResponseHomeModel {
  ResponseHomeModel(
      {this.banners, this.categories, this.sections, this.commonData});

  List<Banner>? banners;
  List<Category>? categories;
  List<Section>? sections;
  final ResponseJson? commonData;

  factory ResponseHomeModel.fromJson(Map<String, dynamic> json) =>
      ResponseHomeModel(
        banners: json["banners"] == null
            ? null
            : List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        sections: json["sections"] == null
            ? null
            : List<Section>.from(
                json["sections"].map((x) => Section.fromJson(x))),
      );
  factory ResponseHomeModel.errorJson(Map<String, dynamic> parsedJson) {
    return ResponseHomeModel(
        commonData: ResponseJson.errorJson(parsedJson),
        sections: [],
        banners: [],
        categories: []);
  }
  Map<String, dynamic> toJson() => {
        "banners":
            banners == null ? null : List<dynamic>.from(banners!.map((x) => x)),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "sections": sections == null
            ? null
            : List<dynamic>.from(sections!.map((x) => x.toJson())),
      };
}

class Banner {
  Banner({
    this.imageUrl,
    this.target,
  });

  String? imageUrl;
  String? target;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        target: json["target"] == null ? null : json["target"],
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl == null ? null : imageUrl,
        "target": target == null ? null : target,
      };
}

class Category {
  Category({
    this.imageUrl,
    this.text,
    this.to,
  });

  String? imageUrl;
  String? text;
  String? to;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        text: json["text"] == null ? null : json["text"],
        to: json["to"] == null ? null : json["to"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl == null ? null : imageUrl,
        "text": text == null ? null : text,
        "to": to == null ? null : to,
      };
}

class Section {
  Section({
    this.type,
    this.items,
    this.linkText,
    this.link,
    this.title,
    this.cols,
    this.brands,
    this.text,
  });

  String? type;
  List<Item>? items;
  String? linkText;
  String? link;
  String? title;
  int? cols;
  List<Brand>? brands;
  String? text;

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        type: json["type"] == null ? null : json["type"],
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        linkText: json["link_text"] == null ? null : json["link_text"],
        link: json["link"] == null ? null : json["link"],
        title: json["title"] == null ? null : json["title"],
        cols: json["cols"] == null ? null : json["cols"],
        brands: json["brands"] == null
            ? null
            : List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
        text: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "link_text": linkText == null ? null : linkText,
        "link": link == null ? null : link,
        "title": title == null ? null : title,
        "cols": cols == null ? null : cols,
        "brands": brands == null
            ? null
            : List<dynamic>.from(brands!.map((x) => x.toJson())),
        "text": text == null ? null : text,
      };
}

class Brand {
  Brand({
    this.text,
    this.to,
  });

  String? text;
  String? to;

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        text: json["text"] == null ? null : json["text"],
        to: json["to"] == null ? null : json["to"],
      );

  Map<String, dynamic> toJson() => {
        "text": text == null ? null : text,
        "to": to == null ? null : to,
      };
}

class Item {
  Item({
    this.defaultImageUrl,
    this.id,
    this.name,
    this.description,
    this.otrPriceFrom,
    this.reviewRate,
    this.to,
    this.text,
    this.imageUrl,
    this.type,
    this.code,
    this.alias,
    this.price,
    this.priceDiscount,
    this.qty,
    this.discussionCount,
    this.title,
    this.updatedAt,
  });

  String? defaultImageUrl;
  int? id;
  String? name;
  String? description;
  int? otrPriceFrom;
  double? reviewRate;
  String? to;
  String? text;
  String? imageUrl;
  String? type;
  String? code;
  String? alias;
  int? price;
  int? priceDiscount;
  int? qty;
  int? discussionCount;
  String? title;
  DateTime? updatedAt;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        defaultImageUrl:
            json["defaultImageUrl"] == null ? null : json["defaultImageUrl"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        otrPriceFrom:
            json["otrPriceFrom"] == null ? null : json["otrPriceFrom"],
        reviewRate:
            json["reviewRate"] == null ? null : json["reviewRate"].toDouble(),
        to: json["to"] == null ? null : json["to"],
        text: json["text"] == null ? null : json["text"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        type: json["type"] == null ? null : json["type"],
        code: json["code"] == null ? null : json["code"],
        alias: json["alias"] == null ? null : json["alias"],
        price: json["price"] == null ? null : json["price"],
        priceDiscount:
            json["priceDiscount"] == null ? null : json["priceDiscount"],
        qty: json["qty"] == null ? null : json["qty"],
        discussionCount:
            json["discussionCount"] == null ? null : json["discussionCount"],
        title: json["title"] == null ? null : json["title"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "defaultImageUrl": defaultImageUrl == null ? null : defaultImageUrl,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "otrPriceFrom": otrPriceFrom == null ? null : otrPriceFrom,
        "reviewRate": reviewRate == null ? null : reviewRate,
        "to": to == null ? null : to,
        "text": text == null ? null : text,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "type": type == null ? null : type,
        "code": code == null ? null : code,
        "alias": alias == null ? null : alias,
        "price": price == null ? null : price,
        "priceDiscount": priceDiscount == null ? null : priceDiscount,
        "qty": qty == null ? null : qty,
        "discussionCount": discussionCount == null ? null : discussionCount,
        "title": title == null ? null : title,
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
