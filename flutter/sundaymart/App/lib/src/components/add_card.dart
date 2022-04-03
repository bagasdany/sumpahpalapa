import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:githubit/src/components/card_textfield.dart';
import 'package:githubit/src/controllers/cart_controller.dart';

class AddCard extends GetView<CartController> {
  final ScrollController? scrollController;

  AddCard({this.scrollController});

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
                    text: "Card number".tr,
                    textLimit: 16,
                    value: controller.cardNumber.value,
                    type: TextInputType.number,
                    onChange: (text) {
                      if (text.length <= 16) {
                        controller.cardNumber.value = text;
                        controller.cardNumber.refresh();
                      }
                    },
                  ),
                  CardTextField(
                    text: "Card Holder name".tr,
                    textLimit: 100,
                    value: controller.cardName.value,
                    onChange: (text) {
                      controller.cardName.value = text;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 0.25.sw,
                        child: CardTextField(
                          text: "Expiry date".tr,
                          textLimit: 5,
                          type: TextInputType.number,
                          value: controller.cardExpiredDate.value,
                          onChange: (text) {
                            int index = text.indexOf("/");

                            if (text.length > 2 && index == -1)
                              controller.cardExpiredDate.value =
                                  text.substring(0, 2) +
                                      "/" +
                                      text.substring(2, text.length);
                            else
                              controller.cardExpiredDate.value = text;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 0.25.sw,
                        child: CardTextField(
                          text: "CVC".tr,
                          textLimit: 3,
                          type: TextInputType.number,
                          value: controller.cvc.value,
                          onChange: (text) {
                            if (text.length <= 3) {
                              controller.cvc.value = text;
                              controller.cvc.refresh();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (controller.cardExpiredDate.value.length == 5 &&
                          controller.cardNumber.value.length == 16 &&
                          controller.cardName.value.length > 0 &&
                          controller.cvc.value.length == 3) Get.back();
                    },
                    child: Container(
                      width: 1.sw - 30,
                      height: 60,
                      decoration: BoxDecoration(
                          color: controller.cardExpiredDate.value.length == 5 &&
                                  controller.cardNumber.value.length == 16 &&
                                  controller.cardName.value.length > 0 &&
                                  controller.cvc.value.length == 3
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
