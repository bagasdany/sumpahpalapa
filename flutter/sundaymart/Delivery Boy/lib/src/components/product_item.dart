import 'package:cached_network_image/cached_network_image.dart';
import 'package:deliveryboy/config/global_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductItem extends StatelessWidget {
  final Map<String, dynamic>? orderItem;
  final bool? hasUnderline;
  final bool? isSelected;
  final int? type;
  final bool? checkEnabled;
  const ProductItem(
      {Key? key,
      this.hasUnderline = true,
      this.isSelected = false,
      this.orderItem,
      this.type = 1,
      this.checkEnabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: type == 3
                ? [
                    const Color.fromRGBO(222, 31, 54, 0.12),
                    const Color.fromRGBO(222, 31, 54, 0),
                  ]
                : type == 2
                    ? [
                        const Color.fromRGBO(88, 150, 39, 0.17),
                        const Color.fromRGBO(69, 165, 36, 0),
                      ]
                    : [
                        Get.isDarkMode
                            ? const Color.fromRGBO(37, 48, 63, 1)
                            : const Color.fromRGBO(255, 255, 255, 1),
                        Get.isDarkMode
                            ? const Color.fromRGBO(37, 48, 63, 1)
                            : const Color.fromRGBO(255, 255, 255, 1),
                      ],
          ),
          border: hasUnderline!
              ? const Border(
                  bottom:
                      BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)))
              : null),
      child: Row(
        children: <Widget>[
          if (checkEnabled!)
            Container(
              width: 40,
              alignment: Alignment.centerLeft,
              child: Icon(
                isSelected!
                    ? const IconData(0xeb86, fontFamily: 'MIcon')
                    : const IconData(0xeb85, fontFamily: 'MIcon'),
                size: 28.sp,
                color: const Color.fromRGBO(136, 136, 126, 1),
              ),
            ),
          Container(
              width: 70,
              height: 70,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: const Color.fromRGBO(255, 255, 255, 1)),
              child: ClipRRect(
                child: CachedNetworkImage(
                  width: 0.25.sw,
                  fit: BoxFit.contain,
                  imageUrl:
                      "$globalImageUrl${orderItem!['product']['images'][0]['image_url']}",
                  placeholder: (context, url) => Container(
                    width: 0.25.sw,
                    alignment: Alignment.center,
                    child: Icon(
                      const IconData(0xee4b, fontFamily: 'MIcon'),
                      color: const Color.fromRGBO(233, 233, 230, 1),
                      size: 40.sp,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                borderRadius: BorderRadius.circular(7),
              )),
          SizedBox(
            width: 1.sw - 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${orderItem!['product']['language']['name']}",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      letterSpacing: -0.4,
                      height: 1.5,
                      color: Get.isDarkMode
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(0, 0, 0, 1)),
                ),
                if (type! < 3)
                  Text(
                    "${orderItem!['price']} x ${orderItem!['quantity']}",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                        height: 1.7,
                        letterSpacing: -0.4,
                        color: Get.isDarkMode
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(0, 0, 0, 1)),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
