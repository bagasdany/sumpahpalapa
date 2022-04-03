import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class DeliveryTimeItem extends StatelessWidget {
  final String? date;
  final String? time;
  final Color? color;
  final bool? isSelected;

  const DeliveryTimeItem(
      {Key? key, this.date, this.time, this.color, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1.sw - 30,
        height: 90,
        padding: const EdgeInsets.only(left: 24),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: HexColor("#F8F8F8"),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  date!,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      letterSpacing: -0.4,
                      color: color),
                ),
                Text(
                  "$time",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      letterSpacing: -0.4,
                      height: 1.7,
                      color: Get.isDarkMode
                          ? Color.fromRGBO(255, 255, 255, 1)
                          : Color.fromRGBO(0, 0, 0, 1)),
                ),
              ],
            ),
            if (isSelected!)
              Container(
                height: 60,
                width: 4,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(69, 165, 36, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10))),
              ),
          ],
        ));
  }
}
