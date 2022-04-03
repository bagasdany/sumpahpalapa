import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/config/global_config.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class OrderSummaryProductItem extends StatelessWidget {
  final Map<String, dynamic> product;
  const OrderSummaryProductItem({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String extrasName = "";
    double extrasPrice = 0;
    if (product['extras'].length > 0) {
      extrasName = product['extras']
          .map((item) {
            return item['extras_name'];
          })
          .toList()
          .join(",");

      extrasPrice = double.parse(
          product['extras'].fold(0, (e, t) => e + t['price']).toString());
    }

    return Container(
      width: 1.sw - 30,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: HexColor("#EFEFEF"))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: "$globalImageUrl${product['image_url']}",
            height: 90,
            width: 90,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fitHeight,
                  // colorFilter:
                  //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              width: 90,
              alignment: Alignment.center,
              child: Icon(
                const IconData(0xee4b, fontFamily: 'MIcon'),
                color: const Color.fromRGBO(233, 233, 230, 1),
                size: 40.sp,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                child: Text(
                  "${product['name']}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Inter',
                      height: 1.4,
                      color: HexColor("#000000"),
                      fontWeight: FontWeight.w400),
                ),
                width: 1.sw - 180,
              ),
              if (extrasName.isNotEmpty)
                SizedBox(
                  child: Text(
                    "( $extrasName )",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                        height: 1.4,
                        color: HexColor("#DE1F36"),
                        fontWeight: FontWeight.w400),
                  ),
                  width: 1.sw - 180,
                ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                    text: "${product['price']}",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: 'Inter',
                        height: 1.7,
                        letterSpacing: -0.4,
                        color: HexColor("#000000"),
                        fontWeight: FontWeight.w700),
                    children: <TextSpan>[
                      if (extrasName.isNotEmpty)
                        TextSpan(
                          text: " + $extrasPrice",
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: 'Inter',
                              height: 1.7,
                              letterSpacing: -0.4,
                              color: HexColor("#DE1F36"),
                              fontWeight: FontWeight.w500),
                        ),
                      TextSpan(
                        text: " x ${product['qty']}",
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Inter',
                            height: 1.7,
                            letterSpacing: -0.4,
                            color: HexColor("#DE1F36"),
                            fontWeight: FontWeight.w700),
                      )
                    ]),
              ),
            ],
          )
        ],
      ),
    );
  }
}
