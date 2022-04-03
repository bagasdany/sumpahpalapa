import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/box_type_item.dart';
import 'package:vendor/src/components/checkout_button.dart';
import 'package:vendor/src/components/checkout_head.dart';
import 'package:vendor/src/components/shipping_type_item.dart';
import 'package:vendor/src/components/transport_button.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShippingPlanSelect extends GetView<OrderController> {
  const ShippingPlanSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> types = ["hours".tr, "days".tr, "km".tr];

    return Obx(() {
      return Container(
          width: 1.sw,
          height: (controller.shippingPlans.length > 4 ||
                  controller.shippingBoxs.length > 4)
              ? 1.sh
              : 0.8.sh,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: HexColor("#ffffff"),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Shipping detail",
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
                        Container(
                          margin: const EdgeInsets.only(top: 15, bottom: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                child: CheckoutButton(
                                  isActive:
                                      controller.deliveryTypeId.value == 1,
                                  title: "Delivery".tr,
                                  icon: controller.deliveryTypeId.value == 1
                                      ? const IconData(0xf1e1,
                                          fontFamily: 'MIcon')
                                      : const IconData(0xf1e2,
                                          fontFamily: 'MIcon'),
                                ),
                                onTap: () {
                                  controller.deliveryTypeId.value = 1;
                                  controller.shippingPlanId.value = 0;
                                  controller.shippingTransportId.value = 0;
                                  controller.shippingBoxId.value = 0;
                                },
                              ),
                              InkWell(
                                child: CheckoutButton(
                                  isActive:
                                      controller.deliveryTypeId.value == 2,
                                  title: "Pickup".tr,
                                  icon: controller.deliveryTypeId.value == 2
                                      ? const IconData(0xf115,
                                          fontFamily: 'MIcon')
                                      : const IconData(0xf116,
                                          fontFamily: 'MIcon'),
                                ),
                                onTap: () {
                                  controller.deliveryTypeId.value = 2;
                                  controller.shippingPlanId.value = 0;
                                  controller.shippingTransportId.value = 0;
                                  controller.shippingBoxId.value = 0;
                                },
                              ),
                            ],
                          ),
                        ),
                        if (controller.deliveryTypeId.value == 1 &&
                            controller.shippingPlans.isNotEmpty)
                          CheckoutHead(text: "Delivery Plan".tr),
                        if (controller.deliveryTypeId.value == 1 &&
                            controller.shippingPlans.isNotEmpty)
                          const SizedBox(
                            height: 15,
                          ),
                        if (controller.deliveryTypeId.value == 1 &&
                            controller.shippingPlans.isNotEmpty)
                          Column(
                            children: controller.shippingPlans.map((item) {
                              if (item['id'] == -1) return Container();
                              int index = controller.shippingPlans
                                  .indexWhere((element) => element == item);
                              if (index ==
                                  controller.shippingPlans.length - 1) {
                                return InkWell(
                                  child: ShippingType(
                                    hasBottom: true,
                                    name: item['delivery_type']['name'],
                                    price: item['amount'].toString(),
                                    isActive: controller.shippingPlanId.value ==
                                        item['id'],
                                    range:
                                        "${item['start']}-${item['end']} ${types[item['type'] - 1]}",
                                  ),
                                  onTap: () {
                                    controller.shippingPlanId.value =
                                        item['id'];
                                  },
                                );
                              }
                              return InkWell(
                                child: ShippingType(
                                  name: item['delivery_type']['name'],
                                  price: "${item['amount']}",
                                  isActive: controller.shippingPlanId.value ==
                                      item['id'],
                                  range:
                                      "${item['start']}-${item['end']} ${types[item['type'] - 1]}",
                                ),
                                onTap: () {
                                  controller.shippingPlanId.value = item['id'];
                                },
                              );
                            }).toList(),
                          ),
                        if (controller.deliveryTypeId.value == 1 &&
                            controller.shippingTransports.isNotEmpty)
                          const SizedBox(
                            height: 35,
                          ),
                        if (controller.deliveryTypeId.value == 1 &&
                            controller.shippingTransports.isNotEmpty)
                          CheckoutHead(text: "Delivery Transport".tr),
                        if (controller.deliveryTypeId.value == 1 &&
                            controller.shippingTransports.isNotEmpty)
                          const SizedBox(
                            height: 15,
                          ),
                        if (controller.deliveryTypeId.value == 1 &&
                            controller.shippingTransports.isNotEmpty)
                          Wrap(
                              spacing: 8,
                              children:
                                  controller.shippingTransports.map((item) {
                                if (item['id'] == -1) return Container();
                                return InkWell(
                                  child: TransportButton(
                                    isActive:
                                        controller.shippingTransportId.value ==
                                            item['id'],
                                    title: item['delivery_transport']['name'],
                                  ),
                                  onTap: () {
                                    controller.shippingTransportId.value =
                                        item['id'];
                                  },
                                );
                              }).toList()),
                        if (controller.deliveryTypeId.value == 1 &&
                            controller.shippingTransports.isNotEmpty)
                          const SizedBox(
                            height: 35,
                          ),
                        if (controller.deliveryTypeId.value == 1 &&
                            controller.shippingBoxs.isNotEmpty)
                          CheckoutHead(text: "Delivery Box type".tr),
                        if (controller.deliveryTypeId.value == 1 &&
                            controller.shippingBoxs.isNotEmpty)
                          const SizedBox(
                            height: 15,
                          ),
                        if (controller.deliveryTypeId.value == 1 &&
                            controller.shippingBoxs.isNotEmpty)
                          Column(
                            children: controller.shippingBoxs.map((item) {
                              if (item['id'] == -1) return Container();
                              int index = controller.shippingBoxs
                                  .indexWhere((element) => element == item);
                              if (index == controller.shippingBoxs.length - 1) {
                                return InkWell(
                                  child: BoxType(
                                    hasBottom: true,
                                    price: item['price'].toString(),
                                    isActive: controller.shippingBoxId.value ==
                                        item['id'],
                                    range:
                                        "${item['start']}-${item['end']} ${item['shipping_box']['name']}",
                                  ),
                                  onTap: () {
                                    controller.shippingBoxId.value = item['id'];
                                  },
                                );
                              }
                              return InkWell(
                                child: BoxType(
                                  price: "${item['price']}",
                                  isActive: controller.shippingBoxId.value ==
                                      item['id'],
                                  range:
                                      "${item['start']}-${item['end']} ${item['shipping_box']['name']}",
                                ),
                                onTap: () {
                                  controller.shippingBoxId.value = item['id'];
                                },
                              );
                            }).toList(),
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                      ]),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
          ));
    });
  }
}
