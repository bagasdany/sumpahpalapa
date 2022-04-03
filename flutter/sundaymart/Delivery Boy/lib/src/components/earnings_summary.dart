import 'package:deliveryboy/src/controllers/order_controller.dart';
import 'package:deliveryboy/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EarningSummary extends GetView<OrderController> {
  const EarningSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = controller.authController.user.value!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 15),
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? const Color.fromRGBO(37, 48, 63, 1)
            : const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Earnings",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Get.isDarkMode
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(0, 0, 0, 1)),
                  ),
                  Text(
                    "All time earnings",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.3,
                        color: Get.isDarkMode
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(0, 0, 0, 1)),
                  ),
                ],
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? const Color.fromRGBO(255, 255, 255, 1)
                        : const Color.fromRGBO(0, 0, 0, 1),
                    borderRadius: BorderRadius.circular(20)),
                child: Icon(
                  const IconData(0xeb24, fontFamily: 'MIcon'),
                  color: !Get.isDarkMode
                      ? const Color.fromRGBO(255, 255, 255, 1)
                      : const Color.fromRGBO(0, 0, 0, 1),
                  size: 20.sp,
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            width: 1.sw - 30,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode
                    ? const Color.fromRGBO(19, 20, 21, 1)
                    : const Color.fromRGBO(243, 243, 240, 1)),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 0.5.sw - 35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Monthly earnings",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.4,
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${user.totalBalance}",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.4,
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(0, 0, 0, 1)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 0.5.sw - 35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Daily earnings",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.4,
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${user.dailyBalance ?? 0}",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.4,
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(0, 0, 0, 1)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1.sw - 30,
            height: 280,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Get.isDarkMode
                    ? const Color.fromRGBO(19, 20, 21, 1)
                    : const Color.fromRGBO(255, 255, 255,
                        1) //const Color.fromRGBO(243, 243, 240, 1)
                ),
          )
        ],
      ),
    );
  }
}
