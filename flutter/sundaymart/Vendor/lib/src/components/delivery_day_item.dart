import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class DeliveryDayItem extends StatelessWidget {
  final String? day;
  final String? weekDay;
  final bool? isSelected;
  const DeliveryDayItem(
      {Key? key, this.day, this.weekDay, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 46,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: HexColor("#F8F8F8"),
          ),
          color: isSelected!
              ? HexColor("#45A524")
              : HexColor("#1F1F1F").withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "$day",
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                letterSpacing: -0.4,
                color: isSelected!
                    ? Color.fromRGBO(255, 255, 255, 1)
                    : Get.isDarkMode
                        ? Color.fromRGBO(130, 139, 150, 1)
                        : Color.fromRGBO(136, 136, 126, 1)),
          ),
          Text(
            "$weekDay",
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                letterSpacing: -0.4,
                color: isSelected!
                    ? Color.fromRGBO(255, 255, 255, 1)
                    : Get.isDarkMode
                        ? Color.fromRGBO(130, 139, 150, 1)
                        : Color.fromRGBO(136, 136, 126, 1)),
          )
        ],
      ),
    );
  }
}
