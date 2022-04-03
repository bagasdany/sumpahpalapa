import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextInput extends StatefulWidget {
  final String? title;
  final String? placeholder;
  final String? defaultValue;
  final Function(String)? onChange;
  final TextInputType? type;
  final bool? isFull;

  const TextInput(
      {Key? key,
      this.title,
      this.placeholder,
      this.onChange,
      this.defaultValue = "",
      this.isFull = false,
      this.type = TextInputType.text})
      : super(key: key);

  @override
  TextInputState createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.023.sh),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title!,
            style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Get.isDarkMode
                    ? const Color.fromRGBO(255, 255, 255, 1)
                    : const Color.fromRGBO(0, 0, 0, 1)),
          ),
          SizedBox(
            width: widget.isFull! ? 1.sw : 0.845.sw,
            child: TextField(
              controller: TextEditingController(text: widget.defaultValue)
                ..selection = TextSelection.fromPosition(
                    TextPosition(offset: widget.defaultValue!.length)),
              onChanged: widget.onChange,
              keyboardType: widget.type,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: Get.isDarkMode
                      ? const Color.fromRGBO(255, 255, 255, 1)
                      : const Color.fromRGBO(0, 0, 0, 1)),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: Get.isDarkMode
                          ? const Color.fromRGBO(130, 139, 150, 1)
                          : const Color.fromRGBO(136, 136, 126, 0.26)),
                  hintText: widget.placeholder),
            ),
          )
        ],
      ),
    );
  }
}
