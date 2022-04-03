import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderInfoBottomModal extends GetView<OrderController> {
  final ScrollController scrollController;
  const OrderInfoBottomModal({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          constraints: const BoxConstraints(minHeight: 500),
          width: 1.sw,
          decoration: BoxDecoration(
              color: HexColor("#ffffff"),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Order info",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 0.5.sw - 20,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: HexColor("#F8F8F8"),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Total amount",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                  color: HexColor("#000000").withOpacity(0.3)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              controller.total.toStringAsFixed(2),
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.4,
                                  color: HexColor("#000000")),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 0.5.sw - 20,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: HexColor("#F8F8F8"),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Total discount",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                  color: HexColor("#000000").withOpacity(0.3)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${controller.discountTotal}",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.4,
                                  color: HexColor("#000000")),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SelectInput(
                    title: "Order status",
                    child: DropdownButton<int>(
                      underline: Container(),
                      value: controller.orderStatusId.value,
                      isExpanded: true,
                      icon: Icon(
                        const IconData(0xea4e, fontFamily: 'MIcon'),
                        size: 28.sp,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                      items: controller.orderStatuses.map((value) {
                        return DropdownMenuItem<int>(
                          value: value['id'],
                          child: Text(
                            "${value['name']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: HexColor("#000000"),
                                fontFamily: "MIcon",
                                fontSize: 16.sp,
                                letterSpacing: -0.4),
                          ),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        controller.orderStatusId.value = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SelectInput(
                    title: "Payment status",
                    child: DropdownButton<int>(
                      underline: Container(),
                      value: controller.paymentStatusId.value,
                      isExpanded: true,
                      icon: Icon(
                        const IconData(0xea4e, fontFamily: 'MIcon'),
                        size: 28.sp,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                      items: controller.paymentStatuses.map((value) {
                        return DropdownMenuItem<int>(
                          value: value['id'],
                          child: Text(
                            "${value['name']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: HexColor("#000000"),
                                fontFamily: "MIcon",
                                fontSize: 16.sp,
                                letterSpacing: -0.4),
                          ),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        controller.paymentStatusId.value = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SelectInput(
                    title: "Payment method",
                    child: DropdownButton<int>(
                      underline: Container(),
                      value: controller.paymentMethodId.value,
                      isExpanded: true,
                      icon: Icon(
                        const IconData(0xea4e, fontFamily: 'MIcon'),
                        size: 28.sp,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                      items: controller.paymentMethods.map((value) {
                        return DropdownMenuItem<int>(
                          value: value['id'],
                          child: Text(
                            "${value['payment']['language']['name']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: HexColor("#000000"),
                                fontFamily: "MIcon",
                                fontSize: 16.sp,
                                letterSpacing: -0.4),
                          ),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        controller.paymentMethodId.value = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Order comment",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.4,
                        color: const Color.fromRGBO(0, 0, 0, 0.3)),
                  ),
                  Container(
                    width: 1.sw - 30,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(143, 146, 161, 0.05),
                        borderRadius: BorderRadius.circular(15)),
                    child: TextField(
                      maxLines: 6,
                      controller: controller.orderCommentController,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          letterSpacing: -0.4,
                          color: HexColor("#000000")),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          border: InputBorder.none,
                          hintText: "Type here",
                          hintStyle: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              letterSpacing: -0.4,
                              color: HexColor("#AFAFAF"))),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        controller: scrollController,
      );
    });
  }
}
