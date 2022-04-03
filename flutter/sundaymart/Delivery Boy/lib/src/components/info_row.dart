import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InfoRow extends StatelessWidget {
  final String? title;
  final String? value;
  final bool? hasUnderline;

  const InfoRow({Key? key, this.title, this.value, this.hasUnderline = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 30,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          border: hasUnderline!
              ? const Border(
                  bottom:
                      BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)))
              : null),
      child: Row(
        children: <Widget>[
          Container(
            width: 0.25.sw,
            margin: const EdgeInsets.only(right: 10),
            child: Text(
              "$title",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  letterSpacing: -0.4,
                  color: Get.isDarkMode
                      ? const Color.fromRGBO(130, 139, 150, 1)
                      : const Color.fromRGBO(136, 136, 126, 1)),
            ),
          ),
          SizedBox(
            width: 0.75.sw - 40,
            child: Text(
              "$value",
              softWrap: true,
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  letterSpacing: -0.4,
                  color: Get.isDarkMode
                      ? const Color.fromRGBO(255, 255, 255, 1)
                      : const Color.fromRGBO(0, 0, 0, 1)),
            ),
          ),
        ],
      ),
    );
  }
}
