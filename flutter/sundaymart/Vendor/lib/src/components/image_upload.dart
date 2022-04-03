import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/config/global_config.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class ImageUpload extends StatelessWidget {
  final Function() onUploadImage;
  final String image;
  const ImageUpload(
      {Key? key, required this.onUploadImage, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onUploadImage,
      child: Container(
        height: 142,
        width: 1.sw - 30,
        padding: EdgeInsets.symmetric(horizontal: 0.5.sw - 75),
        alignment: Alignment.center,
        child: Stack(
          fit: StackFit.passthrough,
          children: <Widget>[
            Positioned(
                top: 0,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 0, 0, 0.05),
                      borderRadius: BorderRadius.circular(20)),
                  child: image.length > 4
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
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
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        )
                      : Container(),
                )),
            Positioned(
                top: 98,
                left: 38,
                child: Container(
                  height: 44,
                  alignment: Alignment.center,
                  width: 44,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: HexColor("#C0C2CC"),
                      border: Border.all(width: 3, color: HexColor("#ffffff"))),
                  child: Icon(
                    const IconData(0xea12, fontFamily: 'MIcon'),
                    color: HexColor("#ffffff"),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
