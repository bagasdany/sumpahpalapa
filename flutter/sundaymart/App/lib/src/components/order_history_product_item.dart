import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:githubit/config/global_config.dart';

class OrderHistoryProductItem extends StatelessWidget {
  final int? type;
  final Map<String, dynamic>? product;
  final String? currency;

  OrderHistoryProductItem({this.type = 1, this.product, this.currency});

  @override
  Widget build(BuildContext context) {
    print(product!['extras']);
    String unit = product!['product']['units'] != null
        ? product!['product']['units']['language']['name']
        : "";
    String extras = product!['extras'].length > 0
        ? "( " +
            product!['extras']
                .map((e) => e['language']['name'])
                .toList()
                .join(",") +
            " )"
        : "";

    double extrasPrice = product!['extras'].length > 0
        ? double.parse(product!['extras']
            .fold(0, (prev, current) => prev + current["price"])
            .toString())
        : 0;

    return Container(
      width: 1.sw,
      height: 70,
      margin: EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: type == 3
              ? [
                  Color.fromRGBO(222, 31, 54, 0.12),
                  Color.fromRGBO(222, 31, 54, 0),
                ]
              : type == 2
                  ? [
                      Color.fromRGBO(88, 150, 39, 0.17),
                      Color.fromRGBO(69, 165, 36, 0),
                    ]
                  : [
                      Get.isDarkMode
                          ? Color.fromRGBO(37, 48, 63, 1)
                          : Color.fromRGBO(255, 255, 255, 1),
                      Get.isDarkMode
                          ? Color.fromRGBO(37, 48, 63, 1)
                          : Color.fromRGBO(255, 255, 255, 1),
                    ],
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 70,
            margin: EdgeInsets.only(right: 15),
            width: type == 1 ? 0 : 9,
            decoration: BoxDecoration(
                color: type == 3
                    ? Color.fromRGBO(222, 31, 54, 1)
                    : type == 2
                        ? Color.fromRGBO(88, 150, 39, 1)
                        : Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
          ),
          Container(
            width: 70,
            height: 70,
            child: CachedNetworkImage(
              width: 70,
              fit: BoxFit.contain,
              imageUrl:
                  "$GLOBAL_IMAGE_URL${product!['product']['images'][0]['image_url']}",
              placeholder: (context, url) => Container(
                width: 70,
                alignment: Alignment.center,
                child: Icon(
                  const IconData(0xee4b, fontFamily: 'MIcon'),
                  color: Color.fromRGBO(233, 233, 230, 1),
                  size: 40.sp,
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            width: 1.sw - 115,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      text: product!['product']['language']['name'].length > 50
                          ? "${product!['product']['language']['name'].substring(0, 50)}..."
                          : product!['product']['language']['name'],
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          letterSpacing: -0.4,
                          color: Get.isDarkMode
                              ? Color.fromRGBO(255, 255, 255, 1)
                              : Color.fromRGBO(0, 0, 0, 1)),
                      children: [
                        TextSpan(
                          text: " $extras",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              letterSpacing: -0.4,
                              color: Get.isDarkMode
                                  ? Color.fromRGBO(255, 255, 255, 1)
                                  : Color.fromRGBO(0, 0, 0, 1)),
                        ),
                      ]),
                ),
                Text(
                  extrasPrice > 0
                      ? "(${product!['price']} + $extrasPrice) $currency x ${product!['quantity']} $unit"
                      : "${product!['price']} $currency x ${product!['quantity']} $unit",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      height: 1.9,
                      letterSpacing: -0.4,
                      color: Get.isDarkMode
                          ? Color.fromRGBO(255, 255, 255, 1)
                          : Color.fromRGBO(0, 0, 0, 1)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
