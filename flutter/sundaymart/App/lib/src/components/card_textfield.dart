import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:githubit/src/utils/hex_color.dart';

class CardTextField extends StatelessWidget {
  final String? text;
  final String? value;
  final int? textLimit;
  final TextInputType? type;
  final Function(String)? onChange;

  CardTextField(
      {this.text,
      this.value,
      this.onChange,
      this.type = TextInputType.text,
      this.textLimit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: TextEditingController(text: value)
          ..selection =
              TextSelection.fromPosition(TextPosition(offset: value!.length)),
        maxLength: textLimit,
        onChanged: onChange,
        keyboardType: type,
        style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
            height: 1.4,
            letterSpacing: -0.4,
            color: Get.isDarkMode
                ? Color.fromRGBO(255, 255, 255, 1)
                : Color.fromRGBO(136, 136, 126, 1)),
        decoration: InputDecoration(
            border: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: Get.isDarkMode
                        ? Color.fromRGBO(102, 110, 121, 1)
                        : HexColor("#88887E"))),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: Get.isDarkMode
                        ? Color.fromRGBO(102, 110, 121, 1)
                        : HexColor("#88887E"))),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: Get.isDarkMode
                        ? Color.fromRGBO(102, 110, 121, 1)
                        : HexColor("#88887E"))),
            labelText: text,
            labelStyle: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                letterSpacing: -0.4,
                color: Get.isDarkMode
                    ? Color.fromRGBO(102, 110, 121, 1)
                    : Color.fromRGBO(0, 0, 0, 0.3))),
      ),
    );
  }
}
