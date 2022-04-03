import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Brands extends StatelessWidget {
  const Brands({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#ECEFF3"),
      appBar: customAppBar(
          icon: const IconData(0xea60, fontFamily: 'MIcon'),
          onClickIcon: () {
            Get.back();
          },
          title: "Brands"),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Get.toNamed("/brandsList");
                  },
                  child: Container(
                    height: 130,
                    width: 0.5.sw - 20,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: HexColor("#FFFFFF"),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              spreadRadius: 0,
                              color: Color.fromRGBO(212, 212, 212, 0.25))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          const IconData(0xef27, fontFamily: 'MIcon'),
                          color: HexColor("#4F4F4F"),
                          size: 24.sp,
                        ),
                        Text(
                          "Brands",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              letterSpacing: -0.4,
                              color: HexColor("#000000")),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed("/brandsCategory");
                  },
                  child: Container(
                    height: 130,
                    width: 0.5.sw - 20,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: HexColor("#FFFFFF"),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              spreadRadius: 0,
                              color: Color.fromRGBO(212, 212, 212, 0.25))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          const IconData(0xecf0, fontFamily: 'MIcon'),
                          color: HexColor("#4F4F4F"),
                          size: 24.sp,
                        ),
                        Text(
                          "Brands categories",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              letterSpacing: -0.4,
                              color: HexColor("#000000")),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
