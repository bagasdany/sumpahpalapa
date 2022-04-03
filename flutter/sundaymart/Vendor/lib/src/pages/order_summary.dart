import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/order_summary_product_item.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class OrderSummary extends GetView<OrderController> {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
              width: 1.sw,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              decoration: BoxDecoration(
                  color: HexColor("#ffffff"),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Products",
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
                  for (int i = 0;
                      i <
                          controller
                              .carts[controller.activeCartIndex.value]
                                  ['products']
                              .length;
                      i++)
                    OrderSummaryProductItem(
                        product:
                            controller.carts[controller.activeCartIndex.value]
                                ['products'][i]),
                  Column(
                    children: <Widget>[
                      Divider(
                        color: HexColor("#000000").withOpacity(0.05),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        width: 1.sw - 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Total product price",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  letterSpacing: -0.3,
                                  color: HexColor("#000000")),
                            ),
                            Text(
                              "${controller.carts[controller.activeCartIndex.value]['total_amount']}",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  color: HexColor("#000000")),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: HexColor("#000000").withOpacity(0.05),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        width: 1.sw - 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Discount",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  letterSpacing: -0.3,
                                  color: HexColor("#000000")),
                            ),
                            Text(
                              "${controller.carts[controller.activeCartIndex.value]['discount']}",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  color: HexColor("#000000")),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        width: 1.sw - 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Delivery",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  letterSpacing: -0.3,
                                  color: HexColor("#000000")),
                            ),
                            Text(
                              "${controller.deliveryFee.value}",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  color: HexColor("#000000")),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        width: 1.sw - 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Tax price",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  letterSpacing: -0.3,
                                  color: HexColor("#000000")),
                            ),
                            Text(
                              "${controller.carts[controller.activeCartIndex.value]['tax']}",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  color: HexColor("#000000")),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: HexColor("#000000").withOpacity(0.05),
                      ),
                      Divider(
                        color: HexColor("#000000").withOpacity(0.05),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        width: 1.sw - 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Total amount",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  letterSpacing: -0.3,
                                  color: HexColor("#000000")),
                            ),
                            Text(
                              "${(controller.carts[controller.activeCartIndex.value]['total'] + controller.deliveryFee.value)}",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.sp,
                                  color: HexColor("#000000")),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 120,
                      ),
                    ],
                  )
                ],
              ))),
      extendBody: true,
      bottomNavigationBar: Padding(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () {
                controller.orderSavePos(controller.activeCartIndex.value);
              },
              child: Container(
                height: 60,
                width: 0.5.sw - 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: HexColor("#16AA16"),
                    borderRadius: BorderRadius.circular(50)),
                child: controller.loading.value
                    ? SizedBox(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator(
                          color: HexColor("ffffff"),
                        ),
                      )
                    : Text(
                        "Confirm Order",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#ffffff"),
                            letterSpacing: -0.4),
                      ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 60,
                alignment: Alignment.center,
                width: 0.5.sw - 20,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: HexColor("#2E3456")),
                    color: HexColor("#ffffff"),
                    borderRadius: BorderRadius.circular(50)),
                child: Text(
                  "Close",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: HexColor("#000000"),
                      letterSpacing: -0.4),
                ),
              ),
            )
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      ),
    );
  }
}
