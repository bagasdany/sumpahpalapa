import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/config/global_config.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class ShopBackgroundImage extends StatelessWidget {
  final Function() onUploadImage;
  final String image;
  const ShopBackgroundImage(
      {Key? key, required this.image, required this.onUploadImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 30,
      height: 130,
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      decoration: BoxDecoration(
          color: HexColor("#F1F1F1"), borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: <Widget>[
          SizedBox(
            width: 1.sw - 30,
            height: 130,
            child: image.length > 4
                ? ClipRRect(
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
                          color: const Color.fromRGBO(233, 233, 230, 1),
                          size: 40.sp,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )
                : SizedBox(
                    child: Icon(
                      const IconData(0xee45, fontFamily: 'MIcon'),
                      color: HexColor("#000000"),
                      size: 40.sp,
                    ),
                  ),
          ),
          Positioned(
              bottom: 15,
              right: 15,
              child: InkWell(
                child: Container(
                  margin: const EdgeInsets.only(right: 5),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: HexColor("#ffffff"),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Upload foto",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: HexColor("#000000")),
                  ),
                ),
                onTap: onUploadImage,
              ))
        ],
      ),
    );
  }
}
