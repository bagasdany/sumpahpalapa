import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class DashboardItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final int amount;
  final String title;
  const DashboardItem(
      {Key? key,
      required this.icon,
      required this.color,
      required this.amount,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5.sw - 20,
      height: 0.5.sw - 60,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: HexColor("#FFFFFF"), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20)),
            child: Icon(
              icon,
              color: color,
              size: 24.sp,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$amount",
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: HexColor("#000000"),
                    fontSize: 20.sp,
                    letterSpacing: -0.5),
              ),
              Opacity(
                opacity: 0.3,
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: HexColor("#000000"),
                      letterSpacing: -0.5),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
