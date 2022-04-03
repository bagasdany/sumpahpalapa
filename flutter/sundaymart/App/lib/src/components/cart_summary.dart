import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:githubit/src/components/cart_summary_item.dart';
import 'package:githubit/src/components/error_dialog.dart';
import 'package:githubit/src/controllers/cart_controller.dart';
import 'package:githubit/src/models/user.dart';

class CartSummary extends GetView<CartController> {
  final ScrollController? scrollController;

  CartSummary({this.scrollController});

  @override
  Widget build(BuildContext context) {
    double total = controller.calculateAmount() -
        controller.calculateDiscount() +
        controller.calculateTaxAmount();
    String currency = controller.currencyController.getActiveCurrencySymbol();
    User? user = controller.shopController.authController.user.value;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: 1.sw,
            padding: EdgeInsets.only(top: 30, bottom: 40, left: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Get.isDarkMode
                    ? Color.fromRGBO(37, 48, 63, 1)
                    : Color.fromRGBO(255, 255, 255, 1)),
            child: Text(
              "Cart summary".tr,
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 20.sp,
                  letterSpacing: -1,
                  color: Get.isDarkMode
                      ? Color.fromRGBO(255, 255, 255, 1)
                      : Color.fromRGBO(0, 0, 0, 1)),
            ),
          ),
          Container(
            color:
                Get.isDarkMode ? Color.fromRGBO(37, 48, 63, 1) : Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Obx(() => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: controller.cartProducts.map((element) {
                          return CartSummaryItem(product: element);
                        }).toList(),
                      )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Divider(
                          color: Get.isDarkMode
                              ? Color.fromRGBO(255, 255, 255, 0.04)
                              : Color.fromRGBO(
                                  0,
                                  0,
                                  0,
                                  0.04,
                                )),
                      SizedBox(
                        height: 20,
                      ),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Get.isDarkMode
                            ? Color.fromRGBO(255, 255, 255, 1)
                            : Color.fromRGBO(0, 0, 0, 1),
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Total product price".tr,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                letterSpacing: -0.3,
                                color: Get.isDarkMode
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1)),
                          ),
                          Text(
                            "${controller.calculateAmount().toStringAsFixed(2)} $currency",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                height: 1.9,
                                letterSpacing: -0.4,
                                color: Get.isDarkMode
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.0,
                        dashLength: 4.0,
                        dashColor: Get.isDarkMode
                            ? Color.fromRGBO(255, 255, 255, 1)
                            : Color.fromRGBO(0, 0, 0, 1),
                        dashRadius: 0.0,
                        dashGapLength: 4.0,
                        dashGapColor: Colors.transparent,
                        dashGapRadius: 0.0,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Discount".tr,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                letterSpacing: -0.3,
                                color: Get.isDarkMode
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1)),
                          ),
                          Text(
                            "- ${controller.calculateDiscount()} $currency",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                height: 1.9,
                                letterSpacing: -0.4,
                                color: Get.isDarkMode
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Tax".tr,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                letterSpacing: -0.3,
                                color: Get.isDarkMode
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1)),
                          ),
                          Text(
                            "${controller.calculateTaxAmount()} $currency",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                height: 1.9,
                                letterSpacing: -0.4,
                                color: Get.isDarkMode
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1)),
                          ),
                        ],
                      ),
                      Divider(
                        color: Get.isDarkMode
                            ? Color.fromRGBO(255, 255, 255, 1)
                            : Color.fromRGBO(0, 0, 0, 1),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Get.isDarkMode
                            ? Color.fromRGBO(255, 255, 255, 1)
                            : Color.fromRGBO(0, 0, 0, 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Total amount".tr,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                letterSpacing: -0.3,
                                color: Get.isDarkMode
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1)),
                          ),
                          Text(
                            "${total.toStringAsFixed(2)} $currency",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 24.sp,
                                letterSpacing: -0.4,
                                color: Get.isDarkMode
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(EdgeInsets.all(0))),
                              onPressed: () {
                                Get.back();
                              },
                              child: Container(
                                height: 60,
                                width: 0.4.sw,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: Get.isDarkMode
                                          ? Color.fromRGBO(255, 255, 255, 1)
                                          : Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                    borderRadius: BorderRadius.circular(30)),
                                alignment: Alignment.center,
                                child: Text(
                                  "Cancel".tr,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                      color: Get.isDarkMode
                                          ? Color.fromRGBO(255, 255, 255, 1)
                                          : Color.fromRGBO(0, 0, 0, 1)),
                                ),
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(EdgeInsets.all(0))),
                              onPressed: () {
                                if (user != null &&
                                    user.id != null &&
                                    user.id! > 0) {
                                  Get.back();
                                  Get.toNamed("/checkout");
                                } else {
                                  Get.bottomSheet(ErrorAlert(
                                    message:
                                        "To finish order, please, sign in first"
                                            .tr,
                                    onClose: () {
                                      Get.back();
                                    },
                                  ));
                                }
                              },
                              child: Container(
                                height: 60,
                                width: 0.4.sw,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(69, 165, 36, 1),
                                    borderRadius: BorderRadius.circular(30)),
                                alignment: Alignment.center,
                                child: Text(
                                  "Order now".tr,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                      color: Color.fromRGBO(255, 255, 255, 1)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      controller: scrollController,
    );
  }
}
