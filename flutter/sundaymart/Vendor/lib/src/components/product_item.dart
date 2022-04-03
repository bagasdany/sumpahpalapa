import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/config/global_config.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class ProductItem extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  final double price;
  final Function(int) onEdit;
  final Function(int) onDelete;
  const ProductItem(
      {Key? key,
      required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 30,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: HexColor("#ffffff"), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 0.2.sw,
            height: 0.2.sw,
            margin: const EdgeInsets.only(right: 18),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.05),
                borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: "$globalImageUrl$image",
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
                    color: Color.fromRGBO(233, 233, 230, 1),
                    size: 40.sp,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(
            width: 0.8.sw - 72,
            height: 0.2.sw,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      color: HexColor("#000000"),
                      fontSize: 14.sp,
                      letterSpacing: -0.5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "$price",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          color: HexColor("#000000"),
                          fontSize: 16.sp,
                          letterSpacing: -0.5),
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
                          onTap: () {
                            onEdit(id);
                          },
                        ),
                        InkWell(
                          child: Container(
                            height: 36,
                            margin: const EdgeInsets.only(left: 8),
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
                          onTap: () {
                            onDelete(id);
                          },
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
