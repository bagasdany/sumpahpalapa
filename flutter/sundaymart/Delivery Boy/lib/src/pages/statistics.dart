import 'package:deliveryboy/src/components/chart.dart';
import 'package:deliveryboy/src/components/line_chart_item.dart';
import 'package:deliveryboy/src/components/line_chart_item_circle.dart';
import 'package:deliveryboy/src/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Statistics extends GetView<OrderController> {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.statistics['deliveredPercentage'] != null) {
      return Obx(() {
        double delivered =
            (controller.statistics['deliveredPercentage'] * 0.92) / 100;
        int measure = controller.statistics['measure'];

        return Scaffold(
          backgroundColor: Get.isDarkMode
              ? const Color.fromRGBO(19, 20, 21, 1)
              : const Color.fromRGBO(243, 243, 240, 1),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: 1.sw,
                  height: 1.sw + 30,
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? const Color.fromRGBO(37, 48, 63, 1)
                          : const Color.fromRGBO(255, 255, 255, 1),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            offset: const Offset(0, 2),
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(169, 169, 150, 0.13)
                                : const Color.fromRGBO(169, 169, 150, 0.13),
                            blurRadius: 2,
                            spreadRadius: 0)
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 0.7.sw,
                        height: 0.7.sw,
                        child: CustomPaint(
                          painter: Chart(delivered: delivered),
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "${controller.statistics['deliveredPercentage']}%",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w800,
                                      fontSize: 50.sp,
                                      letterSpacing: -3,
                                      height: 1.2,
                                      color: Get.isDarkMode
                                          ? const Color.fromRGBO(
                                              255, 255, 255, 1)
                                          : const Color.fromRGBO(0, 0, 0, 1)),
                                ),
                                Text(
                                  "Delivered",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.sp,
                                      letterSpacing: -0.6,
                                      height: 1.2,
                                      color: Get.isDarkMode
                                          ? const Color.fromRGBO(
                                              130, 139, 150, 1)
                                          : const Color.fromRGBO(
                                              136, 136, 126, 1)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 20,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 4,
                                          color: const Color.fromRGBO(
                                              69, 165, 36, 1))),
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: "Delivered — ",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            letterSpacing: -0.4,
                                            color: Get.isDarkMode
                                                ? const Color.fromRGBO(
                                                    255, 255, 255, 1)
                                                : const Color.fromRGBO(
                                                    0, 0, 0, 1)),
                                        children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              "${controller.statistics['deliveredPercentage']}%",
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp,
                                              letterSpacing: -0.4,
                                              color: Get.isDarkMode
                                                  ? const Color.fromRGBO(
                                                      255, 255, 255, 1)
                                                  : const Color.fromRGBO(
                                                      0, 0, 0, 1)))
                                    ]))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  height: 20,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 4,
                                          color: const Color.fromRGBO(
                                              222, 31, 54, 1))),
                                ),
                                RichText(
                                    text: TextSpan(
                                        text: "Canceled — ",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            letterSpacing: -0.4,
                                            color: Get.isDarkMode
                                                ? const Color.fromRGBO(
                                                    255, 255, 255, 1)
                                                : const Color.fromRGBO(
                                                    0, 0, 0, 1)),
                                        children: <TextSpan>[
                                      TextSpan(
                                          text:
                                              "${100 - controller.statistics['deliveredPercentage']}%",
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp,
                                              letterSpacing: -0.4,
                                              color: Get.isDarkMode
                                                  ? const Color.fromRGBO(
                                                      255, 255, 255, 1)
                                                  : const Color.fromRGBO(
                                                      0, 0, 0, 1)))
                                    ]))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 75,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  height: 230,
                  width: 1.sw - 50,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(222, 222, 217, 1)),
                          left: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(222, 222, 217, 1)))),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: (1.sw - 50) / 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            if (controller.activeStatus.value == 3)
                              LineChartItemCircle(
                                  count: "${controller.statistics['onaway']}",
                                  backgroundColor: Get.isDarkMode
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(0, 0, 0, 1)),
                            for (int i = 0;
                                i <
                                    (int.parse(controller.statistics['onaway']
                                            .toString()) *
                                        10 /
                                        int.parse(measure.toString()));
                                i++)
                              LineChartItem(
                                  backgroundColor: Get.isDarkMode
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(0, 0, 0, 1))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: (1.sw - 55) / 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            if (controller.activeStatus.value == 1)
                              LineChartItemCircle(
                                  count: "${controller.statistics['new']}",
                                  backgroundColor:
                                      const Color.fromRGBO(255, 184, 0, 1)),
                            for (int i = 0;
                                i <
                                    (int.parse(controller.statistics['new']
                                            .toString()) *
                                        10 /
                                        int.parse(measure.toString()));
                                i++)
                              const LineChartItem(
                                  backgroundColor:
                                      Color.fromRGBO(255, 184, 0, 1)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: (1.sw - 50) / 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            if (controller.activeStatus.value == 2)
                              LineChartItemCircle(
                                  count: "${controller.statistics['accepted']}",
                                  backgroundColor:
                                      const Color.fromRGBO(36, 119, 165, 1)),
                            for (int i = 0;
                                i <
                                    (int.parse(controller.statistics['accepted']
                                            .toString()) *
                                        10 /
                                        int.parse(measure.toString()));
                                i++)
                              const LineChartItem(
                                  backgroundColor:
                                      Color.fromRGBO(36, 119, 165, 1))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: (1.sw - 50) / 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            if (controller.activeStatus.value == 4)
                              LineChartItemCircle(
                                  count:
                                      "${controller.statistics['delivered']}",
                                  backgroundColor:
                                      const Color.fromRGBO(69, 165, 36, 1)),
                            for (int i = 0;
                                i <
                                    (int.parse(controller
                                            .statistics['delivered']
                                            .toString()) *
                                        10 /
                                        int.parse(measure.toString()));
                                i++)
                              const LineChartItem(
                                  backgroundColor:
                                      Color.fromRGBO(69, 165, 36, 1)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: (1.sw - 50) / 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            if (controller.activeStatus.value == 5)
                              LineChartItemCircle(
                                  count: "${controller.statistics['cancel']}",
                                  backgroundColor:
                                      const Color.fromRGBO(222, 31, 54, 1)),
                            for (int i = 0;
                                i <
                                    (int.parse(controller.statistics['cancel']
                                            .toString()) *
                                        10 /
                                        int.parse(measure.toString()));
                                i++)
                              const LineChartItem(
                                  backgroundColor:
                                      Color.fromRGBO(222, 31, 54, 1)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  width: 1.sw - 50,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: SizedBox(
                          width: (1.sw - 50) / 5,
                          child: Text(
                            "On way",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                letterSpacing: -0.4,
                                color: controller.activeStatus.value == 3
                                    ? Get.isDarkMode
                                        ? const Color.fromRGBO(255, 255, 255, 1)
                                        : const Color.fromRGBO(0, 0, 0, 1)
                                    : Get.isDarkMode
                                        ? const Color.fromRGBO(130, 139, 150, 1)
                                        : const Color.fromRGBO(
                                            136, 136, 126, 1)),
                          ),
                        ),
                        onTap: () {
                          controller.activeStatus.value = 3;
                        },
                      ),
                      InkWell(
                        child: SizedBox(
                          width: (1.sw - 50) / 5,
                          child: Text(
                            "New",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                letterSpacing: -0.4,
                                color: controller.activeStatus.value == 1
                                    ? Get.isDarkMode
                                        ? const Color.fromRGBO(255, 255, 255, 1)
                                        : const Color.fromRGBO(0, 0, 0, 1)
                                    : Get.isDarkMode
                                        ? const Color.fromRGBO(130, 139, 150, 1)
                                        : const Color.fromRGBO(
                                            136, 136, 126, 1)),
                          ),
                        ),
                        onTap: () {
                          controller.activeStatus.value = 1;
                        },
                      ),
                      InkWell(
                        child: SizedBox(
                          width: (1.sw - 50) / 5,
                          child: Text(
                            "Accepted",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                letterSpacing: -0.4,
                                color: controller.activeStatus.value == 2
                                    ? Get.isDarkMode
                                        ? const Color.fromRGBO(255, 255, 255, 1)
                                        : const Color.fromRGBO(0, 0, 0, 1)
                                    : Get.isDarkMode
                                        ? const Color.fromRGBO(130, 139, 150, 1)
                                        : const Color.fromRGBO(
                                            136, 136, 126, 1)),
                          ),
                        ),
                        onTap: () {
                          controller.activeStatus.value = 2;
                        },
                      ),
                      InkWell(
                        child: SizedBox(
                          width: (1.sw - 50) / 5,
                          child: Text(
                            "Delivered",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                letterSpacing: -0.4,
                                color: controller.activeStatus.value == 4
                                    ? Get.isDarkMode
                                        ? const Color.fromRGBO(255, 255, 255, 1)
                                        : const Color.fromRGBO(0, 0, 0, 1)
                                    : Get.isDarkMode
                                        ? const Color.fromRGBO(130, 139, 150, 1)
                                        : const Color.fromRGBO(
                                            136, 136, 126, 1)),
                          ),
                        ),
                        onTap: () {
                          controller.activeStatus.value = 4;
                        },
                      ),
                      InkWell(
                        child: SizedBox(
                          width: (1.sw - 50) / 5,
                          child: Text(
                            "Canceled",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                letterSpacing: -0.4,
                                color: controller.activeStatus.value == 5
                                    ? Get.isDarkMode
                                        ? const Color.fromRGBO(255, 255, 255, 1)
                                        : const Color.fromRGBO(0, 0, 0, 1)
                                    : Get.isDarkMode
                                        ? const Color.fromRGBO(130, 139, 150, 1)
                                        : const Color.fromRGBO(
                                            136, 136, 126, 1)),
                          ),
                        ),
                        onTap: () {
                          controller.activeStatus.value = 5;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 110,
                )
              ],
            ),
          ),
        );
      });
    } else {
      return const Scaffold(
        backgroundColor: Color.fromRGBO(243, 243, 240, 1),
      );
    }
  }
}
