import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class OrderDetailItem extends StatelessWidget {
  final String keyStr;
  final String value;
  final bool isUnderlined;
  const OrderDetailItem(
      {Key? key,
      required this.keyStr,
      required this.value,
      this.isUnderlined = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 30,
      height: 45,
      decoration: BoxDecoration(
          border: isUnderlined
              ? const Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(0, 0, 0, 0.05)))
              : null),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            keyStr,
            style: TextStyle(
                color: HexColor("#000000"),
                fontFamily: 'Inter',
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.5),
          ),
          Text(
            value,
            style: TextStyle(
                color: HexColor("#000000"),
                fontFamily: 'Inter',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.5),
          ),
        ],
      ),
    );
  }
}
