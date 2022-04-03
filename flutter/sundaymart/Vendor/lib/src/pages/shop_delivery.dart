import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/dialog_error.dart';
import 'package:vendor/src/controllers/shop_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class ShopDeliveries extends GetView<ShopController> {
  const ShopDeliveries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: controller.shopDeliveriesList.map((element) {
              var index = controller.type
                  .indexWhere((item) => item['id'] == element['type']);

              return Container(
                width: 1.sw - 30,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: HexColor("#ffffff")),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 4,
                      decoration: BoxDecoration(
                          color: element['active'] == 1
                              ? HexColor("#45A524")
                              : HexColor("#D21234"),
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: 0.3.sw,
                                    child: Text(
                                      "Shop delivery name",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#000000")
                                              .withOpacity(0.5),
                                          fontSize: 12.sp,
                                          letterSpacing: -0.4),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 0.3.sw,
                                    child: Text(
                                      element['delivery_type']['name'],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          color: HexColor("#000000"),
                                          fontSize: 14.sp,
                                          letterSpacing: -0.7),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  InkWell(
                                    child: Container(
                                      height: 36,
                                      width: 36,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 0.05)),
                                      child: Icon(
                                        const IconData(0xefe0,
                                            fontFamily: 'MIcon'),
                                        color: HexColor("#000000"),
                                        size: 20.sp,
                                      ),
                                    ),
                                    onTap: () {
                                      controller.getShopDeliveryTypes();
                                      controller
                                          .getShopDeliveryById(element['id']);
                                      controller.shopDeliveryId.value =
                                          element['id'];
                                      controller.shopDeliveryEdit.value = true;
                                      Get.toNamed("/shopDeliveryAdd");
                                    },
                                  ),
                                  InkWell(
                                    child: Container(
                                      height: 36,
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 36,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 0.05)),
                                      child: Icon(
                                        const IconData(0xec24,
                                            fontFamily: 'MIcon'),
                                        color: HexColor("#000000"),
                                        size: 20.sp,
                                      ),
                                    ),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          barrierColor: HexColor("#000000")
                                              .withOpacity(0.2),
                                          builder: (_) {
                                            return DialogError(
                                              title: "Delete shop delivery",
                                              description:
                                                  "Do you want to delete shop delivery #${element['id']}",
                                              onPressOk: () async {
                                                Get.back();
                                                controller
                                                    .deleteShopDeliveryById(
                                                        element['id']);
                                              },
                                            );
                                          });
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                          width: 1.sw - 70,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          child: Divider(
                            color: HexColor("#000000").withOpacity(0.05),
                          ),
                          width: 1.sw - 70,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 0.25.sw - 20,
                                  child: Text(
                                    "Price",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: HexColor("#000000")
                                            .withOpacity(0.5),
                                        fontSize: 12.sp,
                                        letterSpacing: -0.4),
                                  ),
                                ),
                                SizedBox(
                                  width: 0.25.sw - 20,
                                  child: Text(
                                    "${element['amount']}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: HexColor("#000000"),
                                        fontSize: 14.sp,
                                        letterSpacing: -0.7),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 0.25.sw - 20,
                                  child: Text(
                                    "Start",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: HexColor("#000000")
                                            .withOpacity(0.5),
                                        fontSize: 12.sp,
                                        letterSpacing: -0.4),
                                  ),
                                ),
                                SizedBox(
                                  width: 0.25.sw - 20,
                                  child: Text(
                                    "${element['start']}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: HexColor("#000000"),
                                        fontSize: 14.sp,
                                        letterSpacing: -0.7),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 0.25.sw - 20,
                                  child: Text(
                                    "End",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: HexColor("#000000")
                                            .withOpacity(0.5),
                                        fontSize: 12.sp,
                                        letterSpacing: -0.4),
                                  ),
                                ),
                                SizedBox(
                                  width: 0.25.sw - 20,
                                  child: Text(
                                    "${element['end']}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: HexColor("#000000"),
                                        fontSize: 14.sp,
                                        letterSpacing: -0.7),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: 0.25.sw - 20,
                                  child: Text(
                                    "type",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: HexColor("#000000")
                                            .withOpacity(0.5),
                                        fontSize: 12.sp,
                                        letterSpacing: -0.4),
                                  ),
                                ),
                                SizedBox(
                                  width: 0.25.sw - 20,
                                  child: Text(
                                    "${controller.type[index]['name']}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: HexColor("#000000"),
                                        fontSize: 14.sp,
                                        letterSpacing: -0.7),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          ));
    });
  }
}
