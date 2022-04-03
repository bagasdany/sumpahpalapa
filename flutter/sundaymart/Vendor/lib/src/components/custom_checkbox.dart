import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomCheckbox extends StatelessWidget {
  final bool? isChecked;

  const CustomCheckbox({Key? key, this.isChecked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      isChecked!
          ? const IconData(0xeb80, fontFamily: 'MIcon')
          : const IconData(0xeb7d, fontFamily: 'MIcon'),
      size: 24.sp,
      color: isChecked!
          ? const Color.fromRGBO(69, 165, 36, 1)
          : Get.isDarkMode
              ? const Color.fromRGBO(255, 255, 255, 1)
              : const Color.fromRGBO(0, 0, 0, 1),
    );
  }
}
