import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:githubit/src/utils/hex_color.dart';

class TransportButton extends StatelessWidget {
  final bool? isActive;
  final String? title;
  final IconData? icon;

  TransportButton({this.isActive, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5.sw - 19,
      height: 60,
      margin: EdgeInsets.only(bottom: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              isActive! ? Color.fromRGBO(69, 165, 36, 1) : HexColor("#F3F3F3")),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (this.icon != null)
            Icon(
              this.icon,
              size: 22.sp,
              color: isActive!
                  ? Color.fromRGBO(255, 255, 255, 1)
                  : Get.isDarkMode
                      ? Color.fromRGBO(255, 255, 255, 1)
                      : Color.fromRGBO(136, 136, 126, 1),
            ),
          SizedBox(
            width: 10,
          ),
          Text(
            title!,
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                letterSpacing: -0.5,
                color: isActive!
                    ? Color.fromRGBO(255, 255, 255, 1)
                    : Get.isDarkMode
                        ? Color.fromRGBO(255, 255, 255, 1)
                        : Color.fromRGBO(136, 136, 126, 1)),
          )
        ],
      ),
    );
  }
}
