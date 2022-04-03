import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/config/global_config.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class ShopLogoUpload extends StatelessWidget {
  final Function() onUploadImage;
  final String image;
  const ShopLogoUpload(
      {Key? key, required this.onUploadImage, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 1.sw - 30,
      height: 70,
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: HexColor("#FFFFFF")),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: HexColor("#F1F1F1"),
                borderRadius: BorderRadius.circular(25)),
            child: image.length > 4
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(30),
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
                      size: 24.sp,
                    ),
                  ),
          ),
          InkWell(
            child: Container(
              margin: const EdgeInsets.only(right: 5),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  color: HexColor("#F9F9FA"),
                  borderRadius: BorderRadius.circular(15)),
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
          )
        ],
      ),
    );
  }
}
