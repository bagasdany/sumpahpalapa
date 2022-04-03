import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class DialogError extends StatelessWidget {
  final String title;
  final String description;
  final Function() onPressOk;
  const DialogError(
      {Key? key,
      required this.title,
      required this.description,
      required this.onPressOk})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 60,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 0.5.sh - 150),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: HexColor("#D21234").withOpacity(0.2),
            offset: const Offset(0, 10),
            blurRadius: 25,
            spreadRadius: 0)
      ], color: HexColor("#FFFFFF"), borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Material(
                color: HexColor("#ffffff"),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: HexColor("#D21234")),
                      child: Icon(
                        const IconData(0xee58, fontFamily: 'MIcon'),
                        color: HexColor("#ffffff"),
                        size: 20.sp,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                      width: 1.sw - 150,
                      child: Text(
                        title,
                        style: TextStyle(
                            color: HexColor("#000000"),
                            fontFamily: 'Inter',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
              Material(
                color: HexColor("#ffffff"),
                child: Container(
                  margin: const EdgeInsets.only(left: 45),
                  width: 1.sw - 150,
                  child: Text(
                    description,
                    style: TextStyle(
                        color: HexColor("#848484"),
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        height: 1.5,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
          Material(
            color: HexColor("#ffffff"),
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Container(
                    width: 0.5.sw - 50,
                    height: 40,
                    decoration: BoxDecoration(color: HexColor("#FFFFFF")),
                    alignment: Alignment.center,
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: HexColor("#000000").withOpacity(0.5),
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                InkWell(
                  child: Container(
                    width: 0.5.sw - 50,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: HexColor("#D21234"),
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      "Ok",
                      style: TextStyle(
                          color: HexColor("#FFFFFF"),
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: onPressOk,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
