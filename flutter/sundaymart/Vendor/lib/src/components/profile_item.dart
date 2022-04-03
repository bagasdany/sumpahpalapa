import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function() onPress;
  const ProfileItem(
      {Key? key,
      required this.icon,
      required this.onPress,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        width: 1.sw - 30,
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: HexColor("#000000"),
              size: 24.sp,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(title,
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: HexColor("#000000"),
                    letterSpacing: -0.5))
          ],
        ),
      ),
      onTap: onPress,
    );
  }
}
