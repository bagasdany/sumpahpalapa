import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectInput extends StatelessWidget {
  final String title;
  final bool? isDateTimeSelect;
  final double? width;
  final Widget child;
  const SelectInput(
      {Key? key,
      required this.title,
      required this.child,
      this.width,
      this.isDateTimeSelect = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 1.sw,
      decoration: const BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.2)))),
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            overflow: TextOverflow.clip,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4,
                color: const Color.fromRGBO(0, 0, 0, 0.3)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width: width ?? 1.sw - 60, child: child),
            ],
          )
        ],
      ),
    );
  }
}
