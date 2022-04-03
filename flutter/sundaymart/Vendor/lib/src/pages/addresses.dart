import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/config/global_config.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/dialog_error.dart';
import 'package:vendor/src/components/shadow/product_item_shadow.dart';
import 'package:vendor/src/controllers/admin_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/requests/address_delete_request.dart';

class Addresses extends GetView<AdminController> {
  const Addresses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: HexColor("#ECEFF3"),
        appBar: customAppBar(
            icon: const IconData(0xea60, fontFamily: 'MIcon'),
            onClickIcon: () {
              Get.back();
            },
            title: "Address"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 1.sw - 30,
                height: 1.sh - 100,
                child: NotificationListener(
                  onNotification: (t) {
                    if (t is ScrollEndNotification) {
                      if (t.metrics.atEdge &&
                          controller.scrollController.position.pixels > 0) {
                        controller.loadData.value = true;
                        controller.getClients();
                      }
                    }
                    return false;
                  },
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      itemCount: controller.loadData.value &&
                              controller.addresses.length % 10 == 0
                          ? controller.addresses.length + 10
                          : controller.addresses.length,
                      controller: controller.scrollController,
                      itemBuilder: (_, index) {
                        if (index > controller.addresses.length - 1) {
                          return const ProductItemShadow();
                        }
                        Map<String, dynamic> address =
                            controller.addresses[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: 1.sw - 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: HexColor("#ffffff")),
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 93,
                                width: 4,
                                decoration: BoxDecoration(
                                    color: address['active'] == 1
                                        ? HexColor("#45A524")
                                        : HexColor("#D21234"),
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    width: 1.sw - 60,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            padding: const EdgeInsets.all(5),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: HexColor("#F4F4F4"),
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text("${address['client']}",
                                                    style: TextStyle(
                                                        fontFamily: 'Inter',
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: -0.4,
                                                        color: HexColor(
                                                            "#000000"))),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5,
                                                      horizontal: 12),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color:
                                                          HexColor("#ffffff")),
                                                  margin: const EdgeInsets.only(
                                                      left: 15),
                                                  child: Text(
                                                      "ID - ${address['id']}",
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontFamily: 'Inter',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: HexColor(
                                                              "#88887E"))),
                                                )
                                              ],
                                            )),
                                        InkWell(
                                          child: Container(
                                            height: 36,
                                            margin:
                                                const EdgeInsets.only(left: 10),
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
                                                barrierColor:
                                                    HexColor("#000000")
                                                        .withOpacity(0.2),
                                                builder: (_) {
                                                  return DialogError(
                                                    title: "Delete address",
                                                    description:
                                                        "Do you want to delete address #${address['id']}",
                                                    onPressOk: () async {
                                                      Get.back();
                                                      await addressDeleteRequest(
                                                          address['id']);
                                                      controller.loadData
                                                          .value = true;
                                                      controller
                                                          .addresses.value = [];
                                                      controller.getAddresses();
                                                    },
                                                  );
                                                });
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color:
                                        HexColor("#000000").withOpacity(0.05),
                                  ),
                                  SizedBox(
                                    width: 1.sw - 60,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 1.sw - 220,
                                              child: Text(
                                                "Address",
                                                maxLines: 1,
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
                                              width: 1.sw - 220,
                                              child: Text(
                                                "${address['address']}",
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
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
