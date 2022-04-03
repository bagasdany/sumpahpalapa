import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/config/global_config.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class ShopItem extends StatelessWidget {
  final String backimage;
  final String logo;
  final String shopName;
  final Function() onEdit;
  final Function() onDelete;
  final int deliveryRange;
  final bool isActive;
  const ShopItem(
      {Key? key,
      required this.isActive,
      required this.deliveryRange,
      required this.shopName,
      required this.backimage,
      required this.logo,
      required this.onDelete,
      required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 30,
      margin: const EdgeInsets.only(bottom: 12),
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              width: 1, color: HexColor("#2E3456").withOpacity(0.15)),
          color: HexColor("#ffffff")),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 130,
            width: 1.sw - 30,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: CachedNetworkImage(
                    width: 1.sw - 30,
                    height: 130,
                    imageUrl: "$globalImageUrl$backimage",
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
                Positioned(
                    bottom: 6,
                    left: 6,
                    child: Container(
                      height: 70,
                      width: 70,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 0.58),
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                          width: 50,
                          height: 50,
                          imageUrl: "$globalImageUrl$logo",
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
                            width: 50,
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
                    ))
              ],
            ),
          ),
          Container(
            width: 1.sw - 30,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: HexColor("#DBDBE1")))),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 1.sw - 180,
                  child: Text(
                    shopName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        color: HexColor("#000000"),
                        fontSize: 18.sp,
                        letterSpacing: -0.4),
                  ),
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
                      onTap: onEdit,
                    ),
                    // InkWell(
                    //   child: Container(
                    //     height: 36,
                    //     margin: const EdgeInsets.only(left: 10),
                    //     width: 36,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(18),
                    //         color: const Color.fromRGBO(0, 0, 0, 0.05)),
                    //     child: Icon(
                    //       const IconData(0xec24, fontFamily: 'MIcon'),
                    //       color: HexColor("#000000"),
                    //       size: 20.sp,
                    //     ),
                    //   ),
                    //   onTap: onDelete,
                    // )
                  ],
                )
              ],
            ),
          ),
          Container(
              width: 1.sw - 30,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: 58,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Delivery range",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: HexColor("#000000").withOpacity(0.5),
                              letterSpacing: -0.5),
                        ),
                        Text(
                          "$deliveryRange",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: HexColor("#000000"),
                              letterSpacing: -0.5),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: HexColor("#16AA16").withOpacity(0.1)),
                      child: Text(
                        isActive ? "Active" : "Inactive",
                        style: TextStyle(
                            color: HexColor("#16AA16"),
                            fontFamily: 'Inter',
                            fontSize: 14.sp,
                            letterSpacing: -0.4,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ]))
        ],
      ),
    );
  }
}
