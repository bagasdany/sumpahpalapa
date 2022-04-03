import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeTabButton extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function()? onTap;
  final bool? isActive;

  const HomeTabButton(
      {Key? key, this.icon, this.onTap, this.title, this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isActive!
                ? const Color.fromRGBO(69, 165, 36, 1)
                : Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon!,
                color: isActive!
                    ? const Color.fromRGBO(255, 255, 255, 1)
                    : Get.isDarkMode
                        ? const Color.fromRGBO(130, 139, 150, 1)
                        : const Color.fromRGBO(136, 136, 126, 1)),
            const SizedBox(
              width: 10,
            ),
            Text(
              "$title",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  letterSpacing: -0.5,
                  color: isActive!
                      ? const Color.fromRGBO(255, 255, 255, 1)
                      : Get.isDarkMode
                          ? const Color.fromRGBO(130, 139, 150, 1)
                          : const Color.fromRGBO(136, 136, 126, 1)),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
