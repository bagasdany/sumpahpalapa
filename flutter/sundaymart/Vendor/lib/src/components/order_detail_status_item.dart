import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class OrderDetailStatusItem extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;
  final Color statusBackColor;
  const OrderDetailStatusItem(
      {Key? key,
      required this.title,
      required this.status,
      required this.statusColor,
      required this.statusBackColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 30,
      height: 68,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: HexColor("#FFFFFF"), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: HexColor("#000000"),
                fontFamily: 'Inter',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4),
          ),
          Container(
            width: 100,
            height: 34,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: statusBackColor),
            alignment: Alignment.center,
            child: Text(
              status,
              style: TextStyle(
                  color: statusColor,
                  fontFamily: 'Inter',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.4),
            ),
          )
        ],
      ),
    );
  }
}
