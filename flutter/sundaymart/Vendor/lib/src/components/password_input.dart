import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PasswordInput extends StatefulWidget {
  final String? title;
  final Function(String)? onChange;

  const PasswordInput({Key? key, this.title, this.onChange}) : super(key: key);

  @override
  PasswordInputState createState() => PasswordInputState();
}

class PasswordInputState extends State<PasswordInput> {
  bool isObscureText = true;

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
            width: 0.845.sw,
            child: TextField(
              onChanged: widget.onChange,
              textAlignVertical: TextAlignVertical.center,
              obscureText: isObscureText,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscureText = !isObscureText;
                        });
                      },
                      icon: Icon(
                        isObscureText
                            ? const IconData(0xecb3, fontFamily: 'MIcon')
                            : const IconData(0xecb5, fontFamily: 'MIcon'),
                        color: Get.isDarkMode
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(0, 0, 0, 1),
                        size: 20.sp,
                      )),
                  hintStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                      color: Get.isDarkMode
                          ? const Color.fromRGBO(130, 139, 150, 0.26)
                          : const Color.fromRGBO(136, 136, 126, 0.26)),
                  hintText: " * * * * * * * * * "),
            ),
          )
        ],
      ),
    );
  }
}
