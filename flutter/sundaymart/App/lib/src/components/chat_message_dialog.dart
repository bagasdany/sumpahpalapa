import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:githubit/src/components/custom_btn.dart';

class ChatMessageDialog extends StatelessWidget {
  final String? message;
  final Function()? onTap;

  const ChatMessageDialog({Key? key, this.message, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode
                    ? Color.fromRGBO(0, 0, 0, 1)
                    : Color.fromRGBO(255, 255, 255, 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "New message",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    letterSpacing: -0.4,
                    color: Get.isDarkMode
                        ? Color.fromRGBO(255, 255, 255, 1)
                        : Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                Container(
                  width: 1.sw - 60,
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "$message",
                    softWrap: true,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      letterSpacing: -0.4,
                      color: Get.isDarkMode
                          ? Color.fromRGBO(255, 255, 255, 1)
                          : Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ),
                Divider(
                  color: !Get.isDarkMode
                      ? Color.fromRGBO(0, 0, 0, 0.1)
                      : Color.fromRGBO(255, 255, 255, 0.1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CustomButton(
                      width: 0.4.sw,
                      height: 60,
                      backColor: Color.fromRGBO(221, 35, 57, 1),
                      title: "Close",
                      onPress: () {
                        Get.back();
                      },
                    ),
                    CustomButton(
                      width: 0.4.sw,
                      height: 60,
                      backColor: Color.fromRGBO(69, 165, 36, 1),
                      title: "Open Chat",
                      onPress: this.onTap,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
