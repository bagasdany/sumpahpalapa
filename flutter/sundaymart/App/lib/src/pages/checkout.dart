import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:githubit/src/components/add_card.dart';
import 'package:githubit/src/components/add_email.dart';
import 'package:githubit/src/components/appbar.dart';
import 'package:githubit/src/components/box_type_item.dart';
import 'package:githubit/src/components/card_item.dart';
import 'package:githubit/src/components/cart_summary_item.dart';
import 'package:githubit/src/components/checkout_bottom_button.dart';
import 'package:githubit/src/components/checkout_button.dart';
import 'package:githubit/src/components/checkout_dot.dart';
import 'package:githubit/src/components/checkout_head.dart';
import 'package:githubit/src/components/checkout_textfield.dart';
import 'package:githubit/src/components/shipping_type_item.dart';
import 'package:githubit/src/components/transport_button.dart';
import 'package:githubit/src/controllers/cart_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:githubit/src/models/address.dart';
import 'package:githubit/src/models/user.dart';
import 'package:githubit/src/requests/coupon_check_request.dart';
import 'package:githubit/src/utils/hex_color.dart';

class Checkout extends GetView<CartController> {
  List<String> types = ["hours".tr, "days".tr, "km".tr];

  @override
  Widget build(BuildContext context) {
    String currency = controller.currencyController.getActiveCurrencySymbol();

    return Obx(() {
      Address address =
          controller.shopController.addressController.getDefaultAddress();
      User? user = controller.shopController.authController.user.value;
      controller.checkoutData();
      var statusBarHeight = MediaQuery.of(context).padding.top;
      var appBarHeight = AppBar().preferredSize.height;

      return Scaffold(
          backgroundColor: Get.isDarkMode
              ? Color.fromRGBO(19, 20, 21, 1)
              : Color.fromRGBO(243, 243, 240, 1),
          appBar: PreferredSize(
              preferredSize: Size(1.sw, statusBarHeight + appBarHeight),
              child: AppBarCustom(
                title: "Checkout".tr,
                hasBack: true,
                onBack: () {
                  controller.proccess.value = 0;
                  controller.orderSent.value = false;
                },
              )),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: 1.sw - 30,
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? Color.fromRGBO(37, 48, 63, 1)
                          : Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 15, bottom: 20),
                        child: RichText(
                            text: TextSpan(
                                text: "${"Complate your order".tr} — ",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    letterSpacing: -0.4,
                                    color: Get.isDarkMode
                                        ? Color.fromRGBO(255, 255, 255, 1)
                                        : Color.fromRGBO(0, 0, 0, 1)),
                                children: <TextSpan>[
                              TextSpan(
                                  text:
                                      "${controller.proccessPercentage.value}%",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                      letterSpacing: -0.4,
                                      color: Get.isDarkMode
                                          ? Color.fromRGBO(255, 255, 255, 1)
                                          : Color.fromRGBO(0, 0, 0, 1)))
                            ])),
                      ),
                      Container(
                        width: 1.sw - 30,
                        margin: EdgeInsets.only(bottom: 15),
                        height: 60,
                        child: Stack(
                          children: [
                            Container(
                              width: 1.sw - 90,
                              height: 18,
                              margin: EdgeInsets.only(left: 30, top: 9),
                              decoration: BoxDecoration(
                                  color: controller.proccess.value == 2
                                      ? Color.fromRGBO(69, 165, 36, 1)
                                      : Get.isDarkMode
                                          ? Color.fromRGBO(26, 34, 44, 1)
                                          : Color.fromRGBO(241, 241, 236, 1)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width: 24,
                                  ),
                                  CheckoutDot(
                                    isFilled: controller.proccess.value >= 0,
                                    isLast: controller.proccess.value == 2,
                                  ),
                                  CheckoutDot(
                                    isFilled: controller.proccess.value >= 0,
                                    isLast: controller.proccess.value == 2,
                                  ),
                                  CheckoutDot(
                                    isFilled: controller.proccess.value >= 0,
                                    isLast: controller.proccess.value == 2,
                                  ),
                                  CheckoutDot(
                                    isFilled: controller.proccess.value >= 0,
                                    isLast: controller.proccess.value == 2,
                                  ),
                                  CheckoutDot(
                                    isFilled: controller.proccess.value >= 0,
                                    isLast: controller.proccess.value == 2,
                                  ),
                                  CheckoutDot(
                                    isFilled: controller.proccess.value >= 0,
                                    isLast: controller.proccess.value == 2,
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  CheckoutDot(
                                    isFilled: controller.proccess.value >= 1,
                                    isLast: controller.proccess.value == 2,
                                  ),
                                  CheckoutDot(
                                    isFilled: controller.proccess.value >= 1,
                                    isLast: controller.proccess.value == 2,
                                  ),
                                  CheckoutDot(
                                    isFilled: controller.proccess.value >= 1,
                                    isLast: controller.proccess.value == 2,
                                  ),
                                  CheckoutDot(
                                    isFilled: controller.proccess.value >= 1,
                                    isLast: controller.proccess.value == 2,
                                  ),
                                  CheckoutDot(
                                    isFilled: controller.proccess.value >= 1,
                                    isLast: controller.proccess.value == 2,
                                  ),
                                  CheckoutDot(
                                    isFilled: controller.proccess.value >= 1,
                                    isLast: controller.proccess.value == 2,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                left: 10,
                                top: 0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                          color: controller.proccess.value == 2
                                              ? Color.fromRGBO(69, 165, 36, 1)
                                              : controller.proccess.value >= 0
                                                  ? Color.fromRGBO(
                                                      255, 184, 0, 1)
                                                  : Get.isDarkMode
                                                      ? Color.fromRGBO(
                                                          26, 34, 44, 1)
                                                      : Color.fromRGBO(
                                                          241, 241, 236, 1),
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Icon(
                                        const IconData(0xef09,
                                            fontFamily: 'MIcon'),
                                        size: 20.sp,
                                        color: controller.proccess.value >= 0
                                            ? Colors.white
                                            : Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    130, 139, 150, 1)
                                                : Color.fromRGBO(
                                                    173, 173, 149, 1),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      "Shipping".tr,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                          letterSpacing: -0.4,
                                          color: Get.isDarkMode
                                              ? Color.fromRGBO(255, 255, 255, 1)
                                              : Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                  ],
                                )),
                            Positioned(
                                left: 0.5.sw - 40,
                                top: 0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                          color: controller.proccess.value == 2
                                              ? Color.fromRGBO(69, 165, 36, 1)
                                              : controller.proccess.value >= 1
                                                  ? Color.fromRGBO(
                                                      255, 184, 0, 1)
                                                  : Get.isDarkMode
                                                      ? Color.fromRGBO(
                                                          26, 34, 44, 1)
                                                      : Color.fromRGBO(
                                                          241, 241, 236, 1),
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Icon(
                                        const IconData(0xf2ab,
                                            fontFamily: 'MIcon'),
                                        size: 20.sp,
                                        color: controller.proccess.value >= 1
                                            ? Colors.white
                                            : Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    130, 139, 150, 1)
                                                : Color.fromRGBO(
                                                    173, 173, 149, 1),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      "Payment".tr,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                          letterSpacing: -0.4,
                                          color: Get.isDarkMode
                                              ? Color.fromRGBO(255, 255, 255, 1)
                                              : Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                  ],
                                )),
                            Positioned(
                                right: 10,
                                top: 0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                          color: controller.proccess.value == 2
                                              ? Color.fromRGBO(69, 165, 36, 1)
                                              : Get.isDarkMode
                                                  ? Color.fromRGBO(
                                                      26, 34, 44, 1)
                                                  : Color.fromRGBO(
                                                      241, 241, 236, 1),
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Icon(
                                        const IconData(0xf0ff,
                                            fontFamily: 'MIcon'),
                                        size: 20.sp,
                                        color: controller.proccess.value >= 2
                                            ? Colors.white
                                            : Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    130, 139, 150, 1)
                                                : Color.fromRGBO(
                                                    173, 173, 149, 1),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Text(
                                      "Verify".tr,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                          letterSpacing: -0.4,
                                          color: Get.isDarkMode
                                              ? Color.fromRGBO(255, 255, 255, 1)
                                              : Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                if (controller.proccess.value == 0)
                  Container(
                    width: 1.sw,
                    constraints: BoxConstraints(minHeight: 1.sh),
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? Color.fromRGBO(37, 48, 63, 1)
                            : Colors.white),
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CheckoutHead(text: "Delivery type".tr),
                        Container(
                          margin: EdgeInsets.only(top: 15, bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                child: CheckoutButton(
                                  isActive: controller.deliveryType.value == 1,
                                  title: "Delivery".tr,
                                  icon: controller.deliveryType.value == 1
                                      ? const IconData(0xf1e1,
                                          fontFamily: 'MIcon')
                                      : const IconData(0xf1e2,
                                          fontFamily: 'MIcon'),
                                ),
                                onTap: () {
                                  controller.deliveryType.value = 1;
                                  controller.deliveryPlan.value = 0;
                                  controller.deliveryTransport.value = 0;
                                  controller.deliveryBoxType.value = 0;
                                },
                              ),
                              InkWell(
                                child: CheckoutButton(
                                  isActive: controller.deliveryType.value == 2,
                                  title: "Pickup".tr,
                                  icon: controller.deliveryType.value == 2
                                      ? const IconData(0xf115,
                                          fontFamily: 'MIcon')
                                      : const IconData(0xf116,
                                          fontFamily: 'MIcon'),
                                ),
                                onTap: () {
                                  controller.deliveryType.value = 2;
                                  controller.deliveryPlan.value = 0;
                                  controller.deliveryTransport.value = 0;
                                  controller.deliveryBoxType.value = 0;
                                },
                              ),
                            ],
                          ),
                        ),
                        if (controller.deliveryType.value == 1 &&
                            controller.deliveryPlanList.length > 0)
                          CheckoutHead(text: "Delivery Plan".tr),
                        if (controller.deliveryType.value == 1 &&
                            controller.deliveryPlanList.length > 0)
                          SizedBox(
                            height: 15,
                          ),
                        if (controller.deliveryType.value == 1 &&
                            controller.deliveryPlanList.length > 0)
                          Column(
                            children: controller.deliveryPlanList.map((item) {
                              int index = controller.deliveryPlanList
                                  .indexWhere((element) => element == item);
                              if (index ==
                                  controller.deliveryPlanList.length - 1)
                                return InkWell(
                                  child: ShippingType(
                                    hasBottom: true,
                                    name: item['delivery_type']['name'],
                                    price: item['amount'].toString(),
                                    isActive: controller.deliveryPlan.value ==
                                        item['id'],
                                    range:
                                        "${item['start']}-${item['end']} ${types[item['type'] - 1]}",
                                  ),
                                  onTap: () {
                                    controller.deliveryPlan.value = item['id'];
                                  },
                                );
                              return InkWell(
                                child: ShippingType(
                                  name: item['delivery_type']['name'],
                                  price: "${item['amount']} $currency",
                                  isActive: controller.deliveryPlan.value ==
                                      item['id'],
                                  range:
                                      "${item['start']}-${item['end']} ${types[item['type'] - 1]}",
                                ),
                                onTap: () {
                                  controller.deliveryPlan.value = item['id'];
                                },
                              );
                            }).toList(),
                          ),
                        if (controller.deliveryType.value == 1 &&
                            controller.deliveryTransportList.length > 0)
                          SizedBox(
                            height: 35,
                          ),
                        if (controller.deliveryType.value == 1 &&
                            controller.deliveryTransportList.length > 0)
                          CheckoutHead(text: "Delivery Transport".tr),
                        if (controller.deliveryType.value == 1 &&
                            controller.deliveryPlanList.length > 0)
                          SizedBox(
                            height: 15,
                          ),
                        if (controller.deliveryType.value == 1 &&
                            controller.deliveryTransportList.length > 0)
                          Wrap(
                              spacing: 8,
                              children:
                                  controller.deliveryTransportList.map((item) {
                                return InkWell(
                                  child: TransportButton(
                                    isActive:
                                        controller.deliveryTransport.value ==
                                            item['id'],
                                    title: item['delivery_transport']['name'],
                                  ),
                                  onTap: () {
                                    controller.deliveryTransport.value =
                                        item['id'];
                                  },
                                );
                              }).toList()),
                        if (controller.deliveryType.value == 1 &&
                            controller.deliveryTransportList.length > 0)
                          SizedBox(
                            height: 35,
                          ),
                        if (controller.deliveryType.value == 1 &&
                            controller.deliveryBoxTypeList.length > 0)
                          CheckoutHead(text: "Delivery Box type".tr),
                        if (controller.deliveryType.value == 1 &&
                            controller.deliveryPlanList.length > 0)
                          SizedBox(
                            height: 15,
                          ),
                        if (controller.deliveryType.value == 1 &&
                            controller.deliveryBoxTypeList.length > 0)
                          Column(
                            children:
                                controller.deliveryBoxTypeList.map((item) {
                              int index = controller.deliveryBoxTypeList
                                  .indexWhere((element) => element == item);
                              if (index ==
                                  controller.deliveryBoxTypeList.length - 1)
                                return InkWell(
                                  child: BoxType(
                                    hasBottom: true,
                                    price: item['price'].toString(),
                                    isActive:
                                        controller.deliveryBoxType.value ==
                                            item['id'],
                                    range:
                                        "${item['start']}-${item['end']} ${item['shipping_box']['name']}",
                                  ),
                                  onTap: () {
                                    controller.deliveryBoxType.value =
                                        item['id'];
                                  },
                                );
                              return InkWell(
                                child: BoxType(
                                  price: "${item['price']} $currency",
                                  isActive: controller.deliveryBoxType.value ==
                                      item['id'],
                                  range:
                                      "${item['start']}-${item['end']} ${item['shipping_box']['name']}",
                                ),
                                onTap: () {
                                  controller.deliveryBoxType.value = item['id'];
                                },
                              );
                            }).toList(),
                          ),
                        if (controller.deliveryType.value == 1 &&
                            controller.deliveryBoxTypeList.length > 0)
                          SizedBox(
                            height: 35,
                          ),
                        CheckoutTextfield(
                          text: "Default address".tr,
                          value: "${address.address}",
                          hasButton: true,
                          onTap: () {
                            Get.toNamed("/locationList");
                          },
                        ),
                        CheckoutTextfield(
                          text: "Full name".tr,
                          value: "${user!.name}",
                          hasButton: false,
                          onTap: () {
                            Get.toNamed("/profileSettings");
                          },
                        ),
                        CheckoutTextfield(
                          text: "Phone number".tr,
                          value: "${user.phone}",
                          hasButton: false,
                          onTap: () {
                            Get.toNamed("/profileSettings");
                          },
                        ),
                      ],
                    ),
                  ),
                if (controller.proccess.value == 1)
                  Container(
                    width: 1.sw,
                    constraints: BoxConstraints(minHeight: 1.sh),
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? Color.fromRGBO(37, 48, 63, 1)
                            : Colors.white),
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CheckoutHead(text: "Payment method".tr),
                        InkWell(
                          child: CardItem(
                            title: "Stripe",
                            isActive: controller.paymentType.value == 3,
                          ),
                          onTap: () {
                            controller.paymentType.value = 3;
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) {
                                return DraggableScrollableSheet(
                                  expand: false,
                                  builder: (_, controller) {
                                    return AddCard(
                                      scrollController: controller,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        InkWell(
                          child: CardItem(
                            title: "Paystack",
                            isActive: controller.paymentType.value == 4,
                          ),
                          onTap: () {
                            controller.paymentType.value = 4;
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) {
                                return DraggableScrollableSheet(
                                  expand: false,
                                  builder: (_, controller) {
                                    return AddEmail(
                                      scrollController: controller,
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
                        InkWell(
                          child: CardItem(
                            title: "Terminal",
                            isActive: controller.paymentType.value == 2,
                            icon: const IconData(0xea91, fontFamily: 'MIcon'),
                          ),
                          onTap: () {
                            controller.paymentType.value = 2;
                          },
                        ),
                        InkWell(
                          child: CardItem(
                            title: "Cash",
                            icon: const IconData(0xedf0, fontFamily: 'MIcon'),
                            isActive: controller.paymentType.value == 1,
                          ),
                          onTap: () {
                            controller.paymentType.value = 1;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                if (controller.proccess.value == 2)
                  Container(
                    width: 1.sw - 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Get.isDarkMode
                            ? Color.fromRGBO(37, 48, 63, 1)
                            : Color.fromRGBO(255, 255, 255, 1)),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              const IconData(0xeb24, fontFamily: 'MIcon'),
                              color: Get.isDarkMode
                                  ? Color.fromRGBO(255, 255, 255, 1)
                                  : Color.fromRGBO(0, 0, 0, 1),
                              size: 20.sp,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Delivery date".tr,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      letterSpacing: -0.4,
                                      color: Color.fromRGBO(136, 136, 126, 1)),
                                ),
                                Text(
                                  "${controller.shopController.deliveryDateString}, \n${controller.shopController.deliveryTimeString}",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14.sp,
                                      height: 1.4,
                                      letterSpacing: -0.4,
                                      color: Get.isDarkMode
                                          ? Color.fromRGBO(255, 255, 255, 1)
                                          : Color.fromRGBO(0, 0, 0, 1)),
                                )
                              ],
                            )
                          ],
                        ),
                        InkWell(
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromRGBO(0, 0, 0, 1)),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            child: Text(
                              "Change".tr,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  letterSpacing: -0.4,
                                  color: Color.fromRGBO(255, 255, 255, 1)),
                            ),
                          ),
                          onTap: () {
                            Get.toNamed("/shopInfo",
                                arguments: {"tab_index": 1});
                          },
                        )
                      ],
                    ),
                  ),
                if (controller.proccess.value == 2)
                  Container(
                    width: 1.sw,
                    constraints: BoxConstraints(minHeight: 1.sh),
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? Color.fromRGBO(37, 48, 63, 1)
                            : Colors.white),
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CheckoutTextfield(
                          text: "Comment".tr,
                          value: controller.orderComment.value,
                          enabled: true,
                          onChange: (text) {
                            controller.orderComment.value = text;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 1.sw - 160,
                              child: TextField(
                                controller: TextEditingController(
                                    text: controller.couponValue.value)
                                  ..selection = TextSelection.fromPosition(
                                      TextPosition(
                                          offset: controller
                                              .couponValue.value.length)),
                                onChanged: (text) {
                                  controller.couponValue.value = text;
                                },
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                    height: 1.4,
                                    letterSpacing: -0.4,
                                    color: Get.isDarkMode
                                        ? Color.fromRGBO(255, 255, 255, 1)
                                        : Color.fromRGBO(0, 0, 0, 1)),
                                maxLines: 3,
                                minLines: 1,
                                decoration: InputDecoration(
                                    suffixIcon: (controller.couponResult.value >
                                            0)
                                        ? Icon(
                                            controller.couponResult.value == 1
                                                ? const IconData(0xeb80,
                                                    fontFamily: 'MIcon')
                                                : const IconData(0xeb96,
                                                    fontFamily: 'MIcon'),
                                            color:
                                                controller.couponResult.value ==
                                                        1
                                                    ? HexColor("#45A524")
                                                    : HexColor("#DE1F36"),
                                          )
                                        : null,
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    130, 139, 150, 0.2)
                                                : Color.fromRGBO(
                                                    136, 136, 126, 0.2))),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    130, 139, 150, 0.2)
                                                : Color.fromRGBO(
                                                    136, 136, 126, 0.2))),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    130, 139, 150, 0.2)
                                                : Color.fromRGBO(136, 136, 126, 0.2))),
                                    labelText: "Coupon".tr,
                                    labelStyle: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 18.sp, letterSpacing: -0.4, color: Get.isDarkMode ? Color.fromRGBO(130, 139, 150, 1) : Color.fromRGBO(136, 136, 126, 1))),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: HexColor("#000000")),
                                alignment: Alignment.center,
                                child: Text(
                                  "Apply",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: HexColor("#ffffff"),
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              onTap: () async {
                                Map<String, dynamic> data =
                                    await couponCheckRequest(
                                        controller.couponValue.value);
                                print(data);
                                if (data['data'] == true) {
                                  controller.couponResult.value = 1;
                                } else {
                                  controller.couponResult.value = 2;
                                }
                              },
                            )
                          ],
                        ),
                        if (controller.couponResult.value > 0)
                          Text(
                            controller.couponResult.value == 1
                                ? "Coupon accepted".tr
                                : "Coupon is not active".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                letterSpacing: -0.4,
                                height: 1.2,
                                color: controller.couponResult.value == 1
                                    ? HexColor("#45A524")
                                    : HexColor("#DE1F36"),
                                fontFamily: 'Inter'),
                          ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Your order".tr,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              letterSpacing: -0.4,
                              color: Get.isDarkMode
                                  ? Color.fromRGBO(255, 255, 255, 1)
                                  : Color.fromRGBO(136, 136, 126, 1)),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          color: Get.isDarkMode
                              ? Color.fromRGBO(37, 48, 63, 1)
                              : Colors.white,
                          child: Column(
                            children: <Widget>[
                              Column(
                                children:
                                    controller.cartProducts.map((element) {
                                  return CartSummaryItem(
                                    product: element,
                                  );
                                }).toList(),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Divider(
                                      color: Get.isDarkMode
                                          ? Color.fromRGBO(255, 255, 255, 1)
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
                                        : Colors.black,
                                    dashRadius: 0.0,
                                    dashGapLength: 4.0,
                                    dashGapColor: Colors.transparent,
                                    dashGapRadius: 0.0,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Total product price".tr,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            letterSpacing: -0.3,
                                            color: Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    255, 255, 255, 1)
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
                                                ? Color.fromRGBO(
                                                    255, 255, 255, 1)
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
                                        : Colors.black,
                                    dashRadius: 0.0,
                                    dashGapLength: 4.0,
                                    dashGapColor: Colors.transparent,
                                    dashGapRadius: 0.0,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Discount".tr,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            letterSpacing: -0.3,
                                            color: Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    255, 255, 255, 1)
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
                                                ? Color.fromRGBO(
                                                    255, 255, 255, 1)
                                                : Color.fromRGBO(0, 0, 0, 1)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Tax".tr,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            letterSpacing: -0.3,
                                            color: Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    255, 255, 255, 1)
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
                                                ? Color.fromRGBO(
                                                    255, 255, 255, 1)
                                                : Color.fromRGBO(0, 0, 0, 1)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  if (controller.deliveryType.value == 1)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Delivery".tr,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              letterSpacing: -0.3,
                                              color: Get.isDarkMode
                                                  ? Color.fromRGBO(
                                                      255, 255, 255, 1)
                                                  : Color.fromRGBO(0, 0, 0, 1)),
                                        ),
                                        Text(
                                          "${controller.calculateDeliveryFee()} $currency",
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp,
                                              height: 1.9,
                                              letterSpacing: -0.4,
                                              color: Get.isDarkMode
                                                  ? Color.fromRGBO(
                                                      255, 255, 255, 1)
                                                  : Color.fromRGBO(0, 0, 0, 1)),
                                        ),
                                      ],
                                    ),
                                  if (controller.deliveryType.value == 1)
                                    SizedBox(
                                      height: 30,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        "Total amount".tr,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                            letterSpacing: -0.3,
                                            color: Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    255, 255, 255, 1)
                                                : Color.fromRGBO(0, 0, 0, 1)),
                                      ),
                                      Text(
                                        "${(controller.calculateAmount() + controller.calculateTaxAmount() - controller.calculateDiscount() + (controller.deliveryType.value == 1 ? controller.calculateDeliveryFee() : 0)).toStringAsFixed(2)} $currency",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24.sp,
                                            letterSpacing: -0.4,
                                            color: Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    255, 255, 255, 1)
                                                : Color.fromRGBO(0, 0, 0, 1)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                SizedBox(
                  height: 120,
                )
              ],
            ),
          ),
          extendBody: true,
          bottomNavigationBar: Container(
              height: 100,
              width: 1.sw,
              decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? Color.fromRGBO(37, 48, 63, 0.7)
                      : Color.fromRGBO(255, 255, 255, 0.7)),
              alignment: Alignment.topCenter,
              child: ClipRect(
                  child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  height: 100,
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: controller.proccess.value == 2
                        ? MainAxisAlignment.spaceBetween
                        : controller.proccess.value == 0
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      if (controller.proccess.value == 0)
                        CheckoutBottomButton(
                          title: "Continue".tr,
                          backgroundColor: Color.fromRGBO(0, 0, 0, 1),
                          isActive: controller.proccessPercentage.value >= 46 &&
                              (controller.deliveryType.value == 2 ||
                                  (controller.deliveryType.value == 1 &&
                                      (controller.deliveryPlanList.length ==
                                              0 ||
                                          (controller.deliveryPlanList.length >
                                                  0 &&
                                              controller.deliveryPlan.value >
                                                  0)) &&
                                      (controller.deliveryTransportList
                                                  .length ==
                                              0 ||
                                          (controller.deliveryTransportList
                                                      .length >
                                                  0 &&
                                              controller
                                                      .deliveryTransport.value >
                                                  0)) &&
                                      (controller.deliveryBoxTypeList.length ==
                                              0 ||
                                          (controller.deliveryBoxTypeList
                                                      .length >
                                                  0 &&
                                              controller.deliveryBoxType.value >
                                                  0)))),
                          onTap: () {
                            if (controller.proccessPercentage.value >= 46 &&
                                (controller.deliveryType.value == 2 ||
                                    (controller.deliveryType.value == 1 &&
                                        (controller.deliveryPlanList.length ==
                                                0 ||
                                            (controller.deliveryPlanList
                                                        .length >
                                                    0 &&
                                                controller.deliveryPlan.value >
                                                    0)) &&
                                        (controller.deliveryTransportList
                                                    .length ==
                                                0 ||
                                            (controller.deliveryTransportList
                                                        .length >
                                                    0 &&
                                                controller.deliveryTransport
                                                        .value >
                                                    0)) &&
                                        (controller.deliveryBoxTypeList
                                                    .length ==
                                                0 ||
                                            (controller.deliveryBoxTypeList
                                                        .length >
                                                    0 &&
                                                controller
                                                        .deliveryBoxType.value >
                                                    0)))))
                              controller.proccess.value = 1;
                          },
                        ),
                      if (controller.proccess.value == 1)
                        CheckoutBottomButton(
                          title: "Continue".tr,
                          isActive: (controller.paymentType.value == 4 &&
                                  controller.paymentEmail.value.length > 0) ||
                              (controller.paymentType.value == 3 &&
                                  controller.cardExpiredDate.value.length ==
                                      5 &&
                                  controller.cardNumber.value.length == 16 &&
                                  controller.cardName.value.length > 0 &&
                                  controller.cvc.value.length == 3) ||
                              (controller.paymentType.value < 3 &&
                                  controller.paymentType.value > 0),
                          backgroundColor: Color.fromRGBO(0, 0, 0, 1),
                          onTap: () {
                            if ((controller.paymentType.value == 4 &&
                                    controller.paymentEmail.value.length > 0) ||
                                (controller.paymentType.value == 3 &&
                                    controller.cardExpiredDate.value.length ==
                                        5 &&
                                    controller.cardNumber.value.length == 16 &&
                                    controller.cardName.value.length > 0 &&
                                    controller.cvc.value.length == 3) ||
                                (controller.paymentType.value < 3 &&
                                    controller.paymentType.value > 0))
                              controller.proccess.value = 2;
                          },
                        ),
                      if (controller.proccess.value == 2)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Total amount".tr,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  letterSpacing: -0.4,
                                  color: Get.isDarkMode
                                      ? Color.fromRGBO(130, 139, 150, 1)
                                      : Color.fromRGBO(136, 136, 126, 1)),
                            ),
                            Text(
                              "${(controller.calculateAmount() + controller.calculateTaxAmount() - controller.calculateDiscount() + (controller.deliveryType.value == 1 ? controller.calculateDeliveryFee() : 0)).toStringAsFixed(2)} $currency",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28.sp,
                                  height: 1.3,
                                  letterSpacing: -0.4,
                                  color: Get.isDarkMode
                                      ? Color.fromRGBO(255, 255, 255, 1)
                                      : Color.fromRGBO(0, 0, 0, 1)),
                            ),
                          ],
                        ),
                      if (controller.proccess.value == 2 &&
                          !controller.orderSent.value)
                        SizedBox(
                          width: 0.5.sw,
                          child: CheckoutBottomButton(
                            title: "Confirm & Pay".tr,
                            backgroundColor: controller.shopController
                                        .deliveryDateString.value.length >
                                    0
                                ? Color.fromRGBO(69, 165, 36, 1)
                                : Color.fromRGBO(136, 136, 126, 1),
                            onTap: () {
                              if (controller.shopController.deliveryDateString
                                      .value.length >
                                  0) {
                                controller.orderSave();
                              }
                            },
                          ),
                        ),
                      if (controller.proccess.value == 2 &&
                          controller.orderSent.value)
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: Color.fromRGBO(69, 165, 36, 1),
                          ),
                        ),
                    ],
                  ),
                ),
              ))));
    });
  }
}
