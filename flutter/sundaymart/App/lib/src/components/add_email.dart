import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:githubit/src/components/card_textfield.dart';
import 'package:githubit/src/controllers/cart_controller.dart';

class AddEmail extends GetView<CartController> {
  final ScrollController? scrollController;

  AddEmail({this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
            decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? Color.fromRGBO(37, 48, 63, 1)
                    : Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 0.1.sw,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(204, 204, 204, 1),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CardTextField(
                    text: "Email".tr,
                    textLimit: 100,
                    value: controller.paymentEmail.value,
                    onChange: (text) {
                      controller.paymentEmail.value = text;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (controller.paymentEmail.value.length > 0) Get.back();
                    },
                    child: Container(
                      width: 1.sw - 30,
                      height: 60,
                      decoration: BoxDecoration(
                          color: controller.paymentEmail.value.length > 0
                              ? Color.fromRGBO(69, 165, 36, 1)
                              : Color.fromRGBO(136, 136, 126, 1),
                          borderRadius: BorderRadius.circular(30)),
                      alignment: Alignment.center,
                      child: Text(
                        "Next".tr,
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                            color: Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ]),
          ));
    });
  }
}
