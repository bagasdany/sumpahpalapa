import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeTabButton extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function()? onTap;
  final bool? isActive;
  final int? count;

  HomeTabButton(
      {this.icon, this.onTap, this.title, this.isActive, this.count = 0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 1.sw,
                height: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Icon(icon!,
                        color: isActive!
                            ? Color.fromRGBO(69, 165, 36, 1)
                            : Get.isDarkMode
                                ? Color.fromRGBO(130, 139, 150, 1)
                                : Color.fromRGBO(136, 136, 126, 1)),
                    if (count! > 0)
                      Positioned(
                          right: 5,
                          top: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromRGBO(255, 161, 0, 1)),
                            alignment: Alignment.center,
                            child: Text(
                              "$count",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  letterSpacing: -0.5,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            ),
                          ))
                  ],
                )),
            Text(
              "$title",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  letterSpacing: -0.5,
                  color: isActive!
                      ? Color.fromRGBO(69, 165, 36, 1)
                      : Get.isDarkMode
                          ? Color.fromRGBO(130, 139, 150, 1)
                          : Color.fromRGBO(136, 136, 126, 1)),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
