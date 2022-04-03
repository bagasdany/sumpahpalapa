import 'package:deliveryboy/src/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderDetailAccept extends GetView<OrderController> {
  final Map<String, dynamic>? data;
  final Function? onChangeStatus;
  const OrderDetailAccept({Key? key, this.data, this.onChangeStatus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? const Color.fromRGBO(37, 48, 63, 1)
            : const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: 1.sw - 30,
            decoration: BoxDecoration(
              color: Get.isDarkMode
                  ? const Color.fromRGBO(37, 48, 63, 1)
                  : const Color.fromRGBO(255, 255, 255, 1),
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
                          "Name",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.4,
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(130, 139, 150, 1)
                                  : const Color.fromRGBO(136, 136, 126, 1),
                              fontSize: 14.sp),
                        ),
                        Text(
                          "${data!['clients']['name']} ${data!['clients']['surname']}",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.5,
                              height: 1.4,
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : const Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 16.sp),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(19, 20, 21, 1)
                              : const Color.fromRGBO(243, 243, 240, 1)),
                      child: RichText(
                          text: TextSpan(
                              text: "Order — ",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5,
                                  color: Get.isDarkMode
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 12.sp),
                              children: <TextSpan>[
                            TextSpan(
                              text: "#${data!['id']}",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                  color: Get.isDarkMode
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 12.sp),
                            )
                          ])),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Phone number",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.4,
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(130, 139, 150, 1)
                                  : const Color.fromRGBO(136, 136, 126, 1),
                              fontSize: 14.sp),
                        ),
                        Text(
                          "${data!['clients']['phone']}",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.5,
                              height: 1.4,
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : const Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 16.sp),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Order amount",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.4,
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(130, 139, 150, 1)
                                  : const Color.fromRGBO(136, 136, 126, 1),
                              fontSize: 14.sp),
                        ),
                        Text(
                          "${data!['total_sum']}",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.5,
                              height: 1.4,
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : const Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 16.sp),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(69, 165, 36, 1),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            offset: Offset(0, 14),
                            blurRadius: 15,
                            spreadRadius: 0,
                            color: Color.fromRGBO(69, 165, 36, 0.26),
                          )
                        ]),
                    child: Icon(
                      const IconData(0xea47, fontFamily: 'MIcon'),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      size: 14.sp,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [1, 2, 3, 4, 5].map((e) {
                      return Container(
                        width: 4,
                        height: 4,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: const Color.fromRGBO(196, 196, 196, 0.44)),
                      );
                    }).toList(),
                  )
                ],
              ),
              SizedBox(
                width: 1.sw - 72,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Pickup address",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          height: 1.3,
                          letterSpacing: -0.4,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(130, 139, 150, 1)
                              : const Color.fromRGBO(136, 136, 126, 1)),
                    ),
                    Text(
                      "${data!['shop']['language']['name']}",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          height: 1.2,
                          letterSpacing: -0.4,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(255, 255, 255, 1)
                              : const Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    Text(
                      "${data!['shop']['language']['address']} ",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          height: 1.2,
                          letterSpacing: -0.4,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(255, 255, 255, 1)
                              : const Color.fromRGBO(0, 0, 0, 1)),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(222, 31, 54, 1),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            offset: Offset(0, 14),
                            blurRadius: 15,
                            spreadRadius: 0,
                            color: Color.fromRGBO(222, 31, 54, 0.26),
                          )
                        ]),
                    child: Icon(
                      const IconData(0xea47, fontFamily: 'MIcon'),
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      size: 14.sp,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 1.sw - 72,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Delivery addres",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          height: 1.3,
                          letterSpacing: -0.4,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(130, 139, 150, 1)
                              : const Color.fromRGBO(136, 136, 126, 1)),
                    ),
                    Text(
                      "${data!['clients']['name']} ${data!['clients']['surname']}",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          height: 1.2,
                          letterSpacing: -0.4,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(255, 255, 255, 1)
                              : const Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    Text(
                      "${data!['address']['address']}",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          height: 1.2,
                          letterSpacing: -0.4,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(255, 255, 255, 1)
                              : const Color.fromRGBO(0, 0, 0, 1)),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Obx(() => InkWell(
                    child: Container(
                      width: 0.4.sw,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromRGBO(69, 165, 36, 1)),
                      alignment: Alignment.center,
                      child: controller.loading.value &&
                              controller.status.value == 2
                          ? const SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "Accept".tr,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 1)),
                            ),
                    ),
                    onTap: () async {
                      controller.status.value = 2;
                      await controller.changeStatus(data!['id'], 2);
                      onChangeStatus!();
                      Get.back();
                    },
                  )),
              InkWell(
                child: Container(
                  width: 0.4.sw,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromRGBO(222, 31, 54, 1)),
                  alignment: Alignment.center,
                  child: controller.loading.value &&
                          controller.status.value == 5
                      ? const SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Reject".tr,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: const Color.fromRGBO(255, 255, 255, 1)),
                        ),
                ),
                onTap: () async {
                  controller.status.value = 5;
                  await controller.changeStatus(data!['id'], 5);
                  onChangeStatus!();
                  Get.back();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
