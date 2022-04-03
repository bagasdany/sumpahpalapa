import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:githubit/config/global_config.dart';

class ImageViewer extends StatelessWidget {
  final String? imageUrl;

  const ImageViewer({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                child: Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      color: !Get.isDarkMode
                          ? Color.fromRGBO(255, 255, 255, 1)
                          : Color.fromRGBO(0, 0, 0, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      const IconData(0xeb99, fontFamily: 'MIcon'),
                      color: Get.isDarkMode
                          ? Color.fromRGBO(255, 255, 255, 1)
                          : Color.fromRGBO(0, 0, 0, 1),
                      size: 24,
                    )),
                onTap: () {
                  Get.back();
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? Color.fromRGBO(0, 0, 0, 1)
                      : Color.fromRGBO(255, 255, 255, 1)),
              child: InteractiveViewer(
                panEnabled: true,
                boundaryMargin: EdgeInsets.all(100),
                minScale: 0.5,
                maxScale: 2,
                child: CachedNetworkImage(
                  width: 1.sw,
                  fit: BoxFit.contain,
                  imageUrl: "$GLOBAL_IMAGE_URL$imageUrl",
                  placeholder: (context, url) => Container(
                    width: 1.sw,
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
            )
          ],
        ),
      ),
    );
  }
}
