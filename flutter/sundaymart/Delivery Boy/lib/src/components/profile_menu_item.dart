import 'package:deliveryboy/src/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileMenuItem extends GetView<SettingsController> {
  final String? title;
  final Function()? onClick;
  final bool? noUnderline;
  final IconData? icon;
  final Widget? rightWidget;

  const ProfileMenuItem(
      {Key? key,
      this.onClick,
      this.title,
      this.icon,
      this.noUnderline = false,
      this.rightWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = controller.isDarkTheme.value;

    return TextButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.all(0))),
        onPressed: onClick,
        child: Container(
            margin: const EdgeInsets.only(left: 25, right: 23),
            decoration: BoxDecoration(
                border: !noUnderline!
                    ? Border(
                        bottom: BorderSide(
                            width: 1,
                            color: isDarkMode
                                ? const Color.fromRGBO(130, 139, 150, 0.15)
                                : const Color.fromRGBO(136, 136, 126, 0.15)))
                    : null),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: 70,
                      margin: const EdgeInsets.only(right: 15),
                      child: Icon(
                        icon,
                        size: 24.sp,
                        color: isDarkMode
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    Text(
                      title!,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 16.sp,
                        letterSpacing: -0.4,
                        color: isDarkMode
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(0, 0, 0, 1),
                      ),
                    )
                  ],
                ),
                if (rightWidget != null) rightWidget!
              ],
            )));
  }
}
