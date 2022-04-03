import 'package:deliveryboy/src/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsItem extends GetView<SettingsController> {
  final Widget? rightWidget;
  final IconData? icon;
  final String? text;

  const SettingsItem({Key? key, this.icon, this.text, this.rightWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = controller.isDarkTheme.value;

    return Container(
      width: 1.sw - 30,
      height: 60,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: isDarkMode
                    ? const Color.fromRGBO(23, 27, 32, 0.13)
                    : const Color.fromRGBO(169, 169, 150, 0.13),
                offset: const Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 0)
          ],
          color: isDarkMode
              ? const Color.fromRGBO(37, 48, 63, 1)
              : const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                icon,
                size: 24.sp,
                color: isDarkMode
                    ? const Color.fromRGBO(255, 255, 255, 1)
                    : const Color.fromRGBO(0, 0, 0, 1),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "$text",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  letterSpacing: -0.5,
                  color: isDarkMode
                      ? const Color.fromRGBO(255, 255, 255, 1)
                      : const Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ],
          ),
          if (rightWidget != null) rightWidget!
        ],
      ),
    );
  }
}
