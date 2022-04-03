import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/pos_button.dart';
import 'package:vendor/src/components/pos_summary_product_item.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:vendor/src/pages/order_summary.dart';
import 'package:vendor/src/pages/shipping_plan_select.dart';
import 'package:vendor/src/pages/time_select.dart';

class CartDetail extends StatelessWidget {
  const CartDetail({Key? key}) : super(key: key);

  void showOrderSummaryDialog(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        builder: (BuildContext context) {
          return OrderSummary();
        });
  }

  void showShippingPlanDialog(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        builder: (BuildContext context) {
          return ShippingPlanSelect();
        });
  }

  void showDeliveryTimeDialog(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        builder: (BuildContext context) {
          return SelectTime();
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (controller) {
      return Scaffold(
        backgroundColor: HexColor("#ECEFF3"),
        appBar: customAppBar(
            icon: const IconData(0xea60, fontFamily: 'MIcon'),
            onClickIcon: () {
              Get.back();
            },
            title: "Bag — ${controller.activeCartIndex.value + 1}"),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(color: HexColor("#FFFFFF")),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          width: 1.sw - 80,
                          child: SelectInput(
                            title: "Client",
                            child: DropdownButton<int>(
                              underline: Container(),
                              value: controller.clientId.value,
                              isExpanded: true,
                              icon: Icon(
                                const IconData(0xea4e, fontFamily: 'MIcon'),
                                size: 28.sp,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                              ),
                              items: controller.clients.map((value) {
                                return DropdownMenuItem<int>(
                                  value: value['id'],
                                  child: Text(
                                    "${value['name']} ${value['surname']}",
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
                                controller.clientId.value = value!;
                                controller.addresses.value = [];
                                controller.getClientAddresses(value);
                                controller.update();
                              },
                            ),
                            width: 1.sw - 80,
                          ),
                        ),
                        InkWell(
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: HexColor("#16AA16")),
                              child: Icon(
                                const IconData(0xea13, fontFamily: 'MIcon'),
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                            onTap: () {
                              Get.toNamed("/clientAdd");
                            })
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 1.sw - 80,
                          child: SelectInput(
                            title: "Address",
                            child: DropdownButton<int>(
                              underline: Container(),
                              value: controller.addressId.value,
                              isExpanded: true,
                              icon: Icon(
                                const IconData(0xea4e, fontFamily: 'MIcon'),
                                size: 28.sp,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                              ),
                              items: controller.addresses.map((value) {
                                return DropdownMenuItem<int>(
                                  value: value['id'],
                                  child: Text(
                                    value['address'],
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
                                controller.addressId.value = value!;
                              },
                            ),
                            width: 1.sw - 80,
                          ),
                        ),
                        InkWell(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: HexColor("#16AA16")),
                            child: Icon(
                              const IconData(0xea13, fontFamily: 'MIcon'),
                              color: Colors.white,
                              size: 24.sp,
                            ),
                          ),
                          onTap: () {
                            Get.toNamed("/addressAdd");
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PosButton(
                      onPress: () {
                        showShippingPlanDialog(context);
                      },
                      icon: const IconData(0xef88, fontFamily: 'MIcon'),
                      title: "Shipping detail",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PosButton(
                      onPress: () {
                        showDeliveryTimeDialog(context);
                      },
                      icon: const IconData(0xf20f, fontFamily: 'MIcon'),
                      title: "Add delivery time",
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Filter",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              letterSpacing: -0.4,
                              color: HexColor("#000000")),
                        ),
                        InkWell(
                          child: Text(
                            "Clear all",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                letterSpacing: -0.4,
                                color: HexColor("#D21234")),
                          ),
                          onTap: () {
                            controller.carts[controller.activeCartIndex.value]
                                ['products'] = [];
                            controller.update();
                            Get.back();
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    for (int i = 0;
                        i <
                            controller
                                .carts[controller.activeCartIndex.value]
                                    ['products']
                                .length;
                        i++)
                      PosSummaryProductItem(
                          onDecrement: () {
                            controller.onDecrementPos(controller
                                    .carts[controller.activeCartIndex.value]
                                ['products'][i]['id']);
                          },
                          onIncrement: () {
                            controller.onIncrementPos(controller
                                    .carts[controller.activeCartIndex.value]
                                ['products'][i]['id']);
                          },
                          onDelete: () {
                            controller.onDeletePos(controller
                                    .carts[controller.activeCartIndex.value]
                                ['products'][i]['id']);
                          },
                          product:
                              controller.carts[controller.activeCartIndex.value]
                                  ['products'][i]),
                  ],
                ),
              ),
              const SizedBox(
                height: 120,
              ),
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: Container(
          width: 1.sw,
          height: 110,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(boxShadow: <BoxShadow>[
            BoxShadow(
                offset: const Offset(15, 0),
                spreadRadius: 0,
                blurRadius: 20,
                color: HexColor("#000000").withOpacity(0.1))
          ], color: HexColor("#ffffff")),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Total amount",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#88887E"),
                        letterSpacing: -0.4),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${controller.carts[controller.activeCartIndex.value]["total"]}",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700,
                        color: HexColor("#000000"),
                        letterSpacing: -0.4),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  showOrderSummaryDialog(context);
                },
                child: Container(
                  height: 60,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  decoration: BoxDecoration(
                      color: HexColor("#16AA16"),
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Place order",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#ffffff"),
                        letterSpacing: -0.4),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
