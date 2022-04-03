import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/order_product_item.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailInfoBottomModal extends GetView<OrderController> {
  final ScrollController scrollController;
  const OrderDetailInfoBottomModal({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        controller: scrollController,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          constraints: const BoxConstraints(minHeight: 500),
          width: 1.sw,
          decoration: BoxDecoration(
              color: HexColor("#ffffff"),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Order Detail info",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 22.sp,
                          letterSpacing: -0.4,
                          color: HexColor("#000000")),
                    ),
                    InkWell(
                      child: Container(
                        height: 35,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(22, 170, 22, 1),
                            borderRadius: BorderRadius.circular(18)),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              const IconData(0xea13, fontFamily: 'MIcon'),
                              color: HexColor("#ffffff"),
                              size: 14.sp,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add product",
                              style: TextStyle(
                                  color: HexColor("#ffffff"),
                                  fontFamily: 'Inter',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5),
                            )
                          ],
                        ),
                      ),
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (_) => Obx(() {
                                  return Container(
                                    width: 1.sw - 60,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 0.5.sh - 150, horizontal: 15),
                                    height: 200,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 30),
                                    child: Material(
                                      color: HexColor("#ffffff"),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Select product",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                color: HexColor("#000000"),
                                                fontFamily: "MIcon",
                                                fontSize: 16.sp,
                                                letterSpacing: -0.4),
                                          ),
                                          SelectInput(
                                            title: "Products",
                                            child: DropdownButton<int>(
                                              underline: Container(),
                                              value: controller
                                                  .productActiveId.value,
                                              isExpanded: true,
                                              icon: Icon(
                                                const IconData(0xea4e,
                                                    fontFamily: 'MIcon'),
                                                size: 28.sp,
                                                color: const Color.fromRGBO(
                                                    0, 0, 0, 1),
                                              ),
                                              items: controller.productActive
                                                  .map((value) {
                                                return DropdownMenuItem<int>(
                                                  value: value['id'],
                                                  child: Text(
                                                    value['name'].length >= 50
                                                        ? value['name']
                                                            .substring(0, 50)
                                                        : value['name'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            HexColor("#000000"),
                                                        fontFamily: "MIcon",
                                                        fontSize: 16.sp,
                                                        letterSpacing: -0.4),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (int? value) {
                                                controller.productActiveId
                                                    .value = value!;
                                              },
                                            ),
                                            width: 1.sw - 100,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              InkWell(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          HexColor("#16AA16"),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Save",
                                                    style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.sp,
                                                        letterSpacing: -0.4,
                                                        color: HexColor(
                                                            "#ffffff")),
                                                  ),
                                                ),
                                                onTap: () {
                                                  controller.onSelectProduct(
                                                      controller.productActiveId
                                                          .value);
                                                  Get.back();
                                                },
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  );
                                }));
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              for (int i = 0; i < controller.productList.length; i++)
                OrderProductItem(
                  product: controller.productList[i],
                ),
              const SizedBox(
                height: 35,
              ),
              Divider(
                color: HexColor("#000000").withOpacity(0.1),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total product price",
                      style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.3),
                    ),
                    Text(
                      controller.orderTotal.toStringAsFixed(2),
                      style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: 'Inter',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              Divider(
                color: HexColor("#000000").withOpacity(0.1),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Discount",
                      style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.3),
                    ),
                    Text(
                      "${controller.discountTotal}",
                      style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: 'Inter',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Delivery fee",
                      style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.3),
                    ),
                    Text(
                      "${controller.deliveryFee}",
                      style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: 'Inter',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Tax",
                      style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.3),
                    ),
                    Text(
                      (controller.tax.value + controller.shopTax.value)
                          .toStringAsFixed(2),
                      style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: 'Inter',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              Divider(
                color: HexColor("#000000").withOpacity(0.1),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: HexColor("#000000").withOpacity(0.1),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total amount",
                      style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.3),
                    ),
                    Text(
                      (controller.total.value + controller.shopTax.value)
                          .toStringAsFixed(2),
                      style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: 'Inter',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      );
    });
  }
}
