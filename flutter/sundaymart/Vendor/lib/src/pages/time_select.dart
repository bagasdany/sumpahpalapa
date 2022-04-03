import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/delivery_day_item.dart';
import 'package:vendor/src/components/delivery_time_item.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class SelectTime extends GetView<OrderController> {
  SelectTime({Key? key}) : super(key: key);

  List<String> months = [
    "January".tr,
    "February".tr,
    "March".tr,
    "April".tr,
    "May".tr,
    "June".tr,
    "July".tr,
    "August".tr,
    "September".tr,
    "October".tr,
    "November".tr,
    "December".tr
  ];

  List<String> weekDays = [
    "Mon".tr,
    "Tue".tr,
    "Wed".tr,
    "Thu".tr,
    "Fri".tr,
    "Sat".tr,
    "Sun".tr
  ];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Obx(() {
      return Container(
          width: 1.sw,
          height: .8.sh,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          decoration: BoxDecoration(
              color: HexColor("#ffffff"),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Delivery time",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 22.sp,
                              letterSpacing: -0.4,
                              color: HexColor("#000000")),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                            width: 1.sw - 30,
                            margin: const EdgeInsets.only(top: 20),
                            decoration:
                                BoxDecoration(color: HexColor("#F8F8F8")),
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            const IconData(0xeb21,
                                                fontFamily: 'MIcon'),
                                            size: 24.sp,
                                            color: const Color.fromRGBO(
                                                0, 0, 0, 1),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${months[now.month - 1]} ${now.year}",
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                                letterSpacing: -0.4,
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 1)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 1.sw - 30,
                                  height: 60,
                                  child: ListView.builder(
                                      itemCount: 5,
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      itemBuilder: (context, index) {
                                        DateTime now = DateTime.now();
                                        DateTime date = DateTime(now.year,
                                            now.month, now.day + index);

                                        String day = "${date.day}";
                                        if (date.day < 10) day = "0${date.day}";

                                        return InkWell(
                                          child: DeliveryDayItem(
                                            day: day,
                                            weekDay: weekDays[date.weekday - 1],
                                            isSelected: controller
                                                    .tempDeliveryDate.value ==
                                                "${date.year}-${date.month}-$day",
                                          ),
                                          onTap: () {
                                            controller.dateName.value =
                                                "$day ${months[date.month - 1]}";
                                            controller.tempDeliveryDate.value =
                                                "${date.year}-${date.month}-$day";
                                          },
                                        );
                                      }),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: controller.deliveryTimes.map((item) {
                            List<String> times = item['name'].split("-");
                            List<String> time1 = times[0].split(":");
                            List<String> time2 = times[1].split(":");
                            String time =
                                "${time1[0]}:${time1[1]} - ${time2[0]}:${time2[1]}";

                            return InkWell(
                              child: DeliveryTimeItem(
                                date: controller.dateName.value,
                                time: time,
                                color: const Color.fromRGBO(136, 136, 126, 1),
                                isSelected: controller.deliveryTimeId.value ==
                                    item['id'],
                              ),
                              onTap: () {
                                controller.deliveryTimeId.value = item['id'];
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ]),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              controller.deliveryDate.value =
                                  controller.tempDeliveryDate.value;
                              Get.back();
                            },
                            child: Container(
                              height: 60,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: HexColor("#16AA16"),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Save delivery time",
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: HexColor("#ffffff"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ]),
          ));
    });
  }
}
