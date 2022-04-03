import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LineChartItemCircle extends StatelessWidget {
  final Color? backgroundColor;
  final String? count;

  const LineChartItemCircle({Key? key, this.backgroundColor, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 25,
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: backgroundColor!.withOpacity(0.32),
                offset: const Offset(0, 15),
                blurRadius: 15,
                spreadRadius: 0)
          ],
          border: Border.all(
              width: 2, color: const Color.fromRGBO(255, 255, 255, 1)),
          borderRadius: BorderRadius.circular(13),
          color: backgroundColor),
      alignment: Alignment.center,
      child: Text(
        "$count",
        style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
            letterSpacing: -0.4,
            color: const Color.fromRGBO(255, 255, 255, 1)),
      ),
    );
  }
}
