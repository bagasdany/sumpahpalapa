import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/controllers/admin_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:get/get.dart';

class DeliveryBoyOrderItem extends GetView<AdminController> {
  final int orderId;
  final double totalSum;
  final String orderDate;
  final int status;
  final String statusName;
  final String deliveryBoy;
  final Function() onEdit;
  const DeliveryBoyOrderItem({
    Key? key,
    required this.status,
    required this.statusName,
    required this.deliveryBoy,
    required this.orderId,
    required this.totalSum,
    required this.orderDate,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(orderDate);
    String hour = "${date.hour}";
    if (date.hour < 10) hour = "0" + hour;
    String minute = "${date.minute}";
    if (date.minute < 10) minute = "0" + minute;
    String day = "${date.day}";
    if (date.day < 10) day = "0" + day;
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

    return Container(
      width: 1.sw - 30,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: HexColor("#FFFFFF"),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 2,
                spreadRadius: 0,
                color: Color.fromRGBO(200, 200, 200, 0.25))
          ]),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: HexColor("#F4F4F4")),
                  child: RichText(
                      text: TextSpan(
                          text: "Order — ",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: HexColor("#000000"),
                              letterSpacing: -0.5),
                          children: <TextSpan>[
                        TextSpan(
                            text: "#$orderId",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                                color: HexColor("#000000"),
                                letterSpacing: -0.5))
                      ])),
                ),
                InkWell(
                  child: Container(
                    height: 36,
                    width: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: const Color.fromRGBO(0, 0, 0, 0.05)),
                    child: Icon(
                      const IconData(0xefe0, fontFamily: 'MIcon'),
                      color: HexColor("#000000"),
                      size: 20.sp,
                    ),
                  ),
                  onTap: onEdit,
                ),
              ],
            ),
          ),
          const Divider(
            color: Color.fromRGBO(0, 0, 0, 0.05),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                SizedBox(
                  width: 0.6.sw - 27,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Opacity(
                        opacity: 0.5,
                        child: Text("Date",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                height: 1.2,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                letterSpacing: -0.2)),
                      ),
                      Text(
                          "${months[date.month - 1]} $day, ${date.year} | $hour:$minute",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              height: 1.2,
                              color: HexColor("#000000"),
                              letterSpacing: -0.5))
                    ],
                  ),
                ),
                SizedBox(
                  width: 0.4.sw - 27,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Opacity(
                        opacity: 0.5,
                        child: Text("Amount",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                height: 1.2,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                letterSpacing: -0.2)),
                      ),
                      Text("$totalSum",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              height: 1.2,
                              color: HexColor("#000000"),
                              letterSpacing: -0.5))
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                SizedBox(
                  width: 0.6.sw - 27,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Opacity(
                        opacity: 0.5,
                        child: Text("Delivery boy",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                height: 1.2,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                letterSpacing: -0.2)),
                      ),
                      Text(deliveryBoy,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              height: 1.2,
                              color: HexColor("#000000"),
                              letterSpacing: -0.5))
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 34,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: controller.orderController.statusColors[status - 1]
                          .withOpacity(0.1)),
                  alignment: Alignment.center,
                  child: Text(
                    statusName,
                    style: TextStyle(
                        color:
                            controller.orderController.statusColors[status - 1],
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.4),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
