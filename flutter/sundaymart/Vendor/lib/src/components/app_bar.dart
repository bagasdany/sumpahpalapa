import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/helpers/hex_color.dart';

PreferredSizeWidget customAppBar(
    {required IconData icon,
    required String title,
    List<Widget> actions = const [],
    Function()? onClickIcon}) {
  return PreferredSize(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        width: 1.sw,
        height: 100,
        decoration: BoxDecoration(
            color: HexColor("#ffffff"),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Color.fromRGBO(223, 226, 235, 0.79),
                  offset: Offset(0, 2),
                  blurRadius: 2,
                  spreadRadius: 0)
            ]),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                InkWell(
                  child: Icon(
                    icon,
                    color: HexColor("#2E3456"),
                    size: 24.sp,
                  ),
                  onTap: onClickIcon,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 18),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: HexColor("#000000"),
                        fontFamily: 'Inter',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.5),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions,
            )
          ],
        ),
      ),
      preferredSize: Size(1.sw, 100));
}
