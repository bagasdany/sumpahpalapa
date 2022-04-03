import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class PosButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPress;
  const PosButton(
      {Key? key,
      required this.title,
      required this.icon,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 40,
        width: 1.sw - 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: HexColor("#F8F8F8"), borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: HexColor("#000000"),
              size: 20.sp,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                  fontFamily: 'Inter',
                  color: HexColor("#000000"),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
      onTap: () {
        onPress();
      },
    );
  }
}
