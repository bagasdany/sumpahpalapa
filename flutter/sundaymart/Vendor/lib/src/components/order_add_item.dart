import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class OrderAddItem extends StatelessWidget {
  final String title;
  final Function() onPress;
  const OrderAddItem({Key? key, required this.title, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 60,
        width: 1.sw - 30,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: HexColor("#ffffff")),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: HexColor("#000000"),
                  fontFamily: 'Inter',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.4),
            ),
            Icon(
              const IconData(0xea6e, fontFamily: 'MIcon'),
              color: HexColor("#000000"),
              size: 24.sp,
            )
          ],
        ),
      ),
      onTap: onPress,
    );
  }
}
