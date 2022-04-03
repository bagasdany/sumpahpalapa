import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:githubit/src/components/checkout_bottom_button.dart';
import 'package:githubit/src/controllers/cart_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderSuccess extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Get.isDarkMode
              ? Color.fromRGBO(19, 20, 21, 1)
              : Color.fromRGBO(243, 243, 240, 1),
          body: Container(
            width: 1.sw,
            height: 1.sh,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image(
                  image: AssetImage("lib/assets/images/light_mode/success.png"),
                  width: 0.8.sw,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Order successfully saved".tr,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 24.sp,
                        letterSpacing: -0.4,
                        color: Get.isDarkMode
                            ? Color.fromRGBO(255, 255, 255, 1)
                            : Color.fromRGBO(0, 0, 0, 1))),
                SizedBox(
                  height: 10,
                ),
                if (controller.orderId.value != null &&
                    controller.orderId.value > 0)
                  Obx(() {
                    return Text(
                        "Your order ID is ".tr +
                            controller.orderId.value.toString(),
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            letterSpacing: -0.4,
                            color: Get.isDarkMode
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(0, 0, 0, 1)));
                  }),
                if (controller.transactionId.value != null &&
                    controller.transactionId.value > 0)
                  Obx(() {
                    return Text(
                        "Your transaction ID is ".tr +
                            controller.transactionId.value.toString(),
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            letterSpacing: -0.4,
                            color: Get.isDarkMode
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(0, 0, 0, 1)));
                  }),
                SizedBox(
                  height: 50,
                ),
                if (controller.paymentUrl.value.length > 0)
                  SizedBox(
                    width: 0.5.sw,
                    child: CheckoutBottomButton(
                      title: "Finish payment".tr,
                      backgroundColor: Color.fromRGBO(0, 0, 0, 1),
                      onTap: () async {
                        if (!await launch(controller.paymentUrl.value))
                          throw 'Could not launch ${controller.paymentUrl.value}';
                      },
                    ),
                  ),
                if (controller.paymentUrl.value.length > 0)
                  SizedBox(
                    height: 10,
                  ),
                SizedBox(
                  width: 0.5.sw,
                  child: CheckoutBottomButton(
                    title: "Go back".tr,
                    backgroundColor: Color.fromRGBO(69, 165, 36, 1),
                    onTap: () {
                      Get.back();
                      Get.back();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        onWillPop: () async {
          Get.back();
          Get.back();

          return false;
        });
  }
}
