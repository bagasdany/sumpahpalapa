import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:vendor/config/global_config.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class BrandItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String shopName;
  final Function() onPressEdit;
  final Function() onPressDelete;
  final bool isActive;
  final String brandCategoryName;
  const BrandItem(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.shopName,
      required this.onPressEdit,
      required this.onPressDelete,
      required this.brandCategoryName,
      required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 30,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.only(right: 10, top: 20, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: HexColor("#FFFFFF")),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 93,
            width: 4,
            decoration: BoxDecoration(
                color: isActive ? HexColor("#45A524") : HexColor("#D21234"),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: "$globalImageUrl$imageUrl",
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  // colorFilter:
                                  //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              width: 250,
                              alignment: Alignment.center,
                              child: Icon(
                                const IconData(0xee4b, fontFamily: 'MIcon'),
                                color: const Color.fromRGBO(233, 233, 230, 1),
                                size: 40.sp,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 1.sw - 220,
                            child: Text(
                              name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  color: HexColor("#000000"),
                                  fontSize: 14.sp,
                                  letterSpacing: -0.4),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 1.sw - 220,
                            child: Text(
                              "Shop - $shopName",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  color: HexColor("#88887E"),
                                  fontSize: 12.sp,
                                  letterSpacing: -0.4),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          height: 36,
                          width: 36,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: const Color.fromRGBO(0, 0, 0, 0.05)),
                          child: Icon(
                            const IconData(0xefe0, fontFamily: 'MIcon'),
                            color: HexColor("#000000"),
                            size: 20.sp,
                          ),
                        ),
                        onTap: onPressEdit,
                      ),
                      InkWell(
                        child: Container(
                          height: 36,
                          margin: const EdgeInsets.only(left: 10),
                          width: 36,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: const Color.fromRGBO(0, 0, 0, 0.05)),
                          child: Icon(
                            const IconData(0xec24, fontFamily: 'MIcon'),
                            color: HexColor("#000000"),
                            size: 20.sp,
                          ),
                        ),
                        onTap: onPressDelete,
                      )
                    ],
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 58),
                width: 0.8.sw - 30,
                height: 1,
                color: const Color.fromRGBO(0, 0, 0, 0.05),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 1.sw - 220,
                    child: Text(
                      "Category",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: HexColor("#000000").withOpacity(0.5),
                          fontSize: 12.sp,
                          letterSpacing: -0.4),
                    ),
                  ),
                  SizedBox(
                    width: 1.sw - 220,
                    child: Text(
                      brandCategoryName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: HexColor("#000000"),
                          fontSize: 14.sp,
                          letterSpacing: -0.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
