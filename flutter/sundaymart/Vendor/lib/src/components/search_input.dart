import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchInput extends StatelessWidget {
  final String? title;
  final bool? hasSuffix;
  final Function(String)? onChange;
  final Function()? onTap;

  const SearchInput(
      {Key? key, this.title, this.hasSuffix = true, this.onChange, this.onTap})
      : super(key: key);

  onChangeHandler(value) {
    onChange!(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 1.sw,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Get.isDarkMode
                ? const Color.fromRGBO(26, 34, 44, 1)
                : const Color.fromRGBO(249, 249, 249, 1)),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 1.sw - 100,
              child: TextField(
                onChanged: onChangeHandler,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: title!,
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        const IconData(0xf0cd, fontFamily: 'MIcon'),
                        size: 20.sp,
                        color: Get.isDarkMode
                            ? const Color.fromRGBO(130, 139, 150, 1)
                            : const Color.fromRGBO(136, 136, 126, 1),
                      ),
                    ),
                    hintStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      letterSpacing: -0.5,
                      color: Get.isDarkMode
                          ? const Color.fromRGBO(130, 139, 150, 1)
                          : const Color.fromRGBO(136, 136, 126, 1),
                    )),
              ),
            ),
            if (hasSuffix!)
              IconButton(
                onPressed: onTap,
                icon: Icon(
                  const IconData(0xf162, fontFamily: 'MIcon'),
                  size: 20.sp,
                  color: const Color.fromRGBO(136, 136, 126, 1),
                ),
              )
          ],
        ));
  }
}
