import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/controllers/admin_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:get/get.dart';

class DeliveryBoyDataItem extends GetView<AdminController> {
  final String deliveryBoy;
  final int accepted;
  final int ready;
  final int inaway;
  final int delivered;
  final int canceled;
  final Function() onEdit;
  const DeliveryBoyDataItem({
    Key? key,
    required this.accepted,
    required this.canceled,
    required this.delivered,
    required this.inaway,
    required this.ready,
    required this.deliveryBoy,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Text(deliveryBoy,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 14.sp,
                        color: HexColor("#000000"),
                        letterSpacing: -0.5)),
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 0.3.sw - 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Opacity(
                        opacity: 0.5,
                        child: Text("Accepted",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                height: 1.2,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                letterSpacing: -0.2)),
                      ),
                      Text("$accepted",
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
                  width: 0.3.sw - 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Opacity(
                        opacity: 0.5,
                        child: Text("Ready to delivery",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                height: 1.2,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                letterSpacing: -0.2)),
                      ),
                      Text("$ready",
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
                  width: 0.3.sw - 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Opacity(
                        opacity: 0.5,
                        child: Text("In a way",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                height: 1.2,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                letterSpacing: -0.2)),
                      ),
                      Text("$inaway",
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 0.3.sw - 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Opacity(
                        opacity: 0.5,
                        child: Text("Delivered",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                height: 1.2,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                letterSpacing: -0.2)),
                      ),
                      Text("$delivered",
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
                  width: 0.3.sw - 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Opacity(
                        opacity: 0.5,
                        child: Text("Canceled",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                height: 1.2,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                                letterSpacing: -0.2)),
                      ),
                      Text("$canceled",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
