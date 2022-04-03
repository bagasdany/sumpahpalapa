import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/shop_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class ShopPayment extends GetView<ShopController> {
  const ShopPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        width: 1.sw,
        height: 1.sh,
        child: SingleChildScrollView(
            child: Column(
          children: controller.activePayments.map((element) {
            return Container(
              width: 1.sw - 30,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: HexColor("#ffffff")),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${element['language']['name']}",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                        color: HexColor("#000000")),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          controller.payments[element['id']] != null &&
                                  controller.payments[element['id']]
                                          ['active'] ==
                                      1
                              ? const IconData(0xeb80, fontFamily: 'MIcon')
                              : const IconData(0xeb7d, fontFamily: 'MIcon'),
                          color: controller.payments[element['id']] != null &&
                                  controller.payments[element['id']]
                                          ['active'] ==
                                      1
                              ? const Color.fromRGBO(0, 173, 16, 1)
                              : const Color.fromRGBO(0, 0, 0, 1),
                          size: 24.sp,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Active",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: HexColor("#000000")),
                        ),
                      ],
                    ),
                    onTap: () {
                      if (controller.payments[element['id']] == null) {
                        controller.payments[element['id']] = {
                          "payment_id": element['id'],
                          "private_key": "",
                          "public_key": ""
                        };
                      }

                      controller.payments[element['id']]['active'] = 1;
                      controller.payments.refresh();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          controller.payments[element['id']] != null &&
                                  controller.payments[element['id']]
                                          ['active'] ==
                                      0
                              ? const IconData(0xeb80, fontFamily: 'MIcon')
                              : const IconData(0xeb7d, fontFamily: 'MIcon'),
                          color: controller.payments[element['id']] != null &&
                                  controller.payments[element['id']]
                                          ['active'] ==
                                      0
                              ? const Color.fromRGBO(0, 173, 16, 1)
                              : const Color.fromRGBO(0, 0, 0, 1),
                          size: 24.sp,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Inactive",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: HexColor("#000000")),
                        ),
                      ],
                    ),
                    onTap: () {
                      if (controller.payments[element['id']] == null) {
                        controller.payments[element['id']] = {
                          "payment_id": element['id'],
                          "private_key": "",
                          "public_key": ""
                        };
                      }

                      controller.payments[element['id']]['active'] = 0;
                      controller.payments.refresh();
                    },
                  ),
                  if (int.parse(element['type'].toString()) == 2)
                    const SizedBox(
                      height: 15,
                    ),
                  if (int.parse(element['type'].toString()) == 2)
                    SelectInput(
                        title: "Published Key",
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            if (controller.payments[element['id']] == null) {
                              controller.payments[element['id']] = {
                                "payment_id": element['id'],
                                "private_key": "",
                                "public_key": ""
                              };
                            }

                            controller.payments[element['id']]['public_key'] =
                                text;
                            controller.payments.refresh();
                          },
                          controller: TextEditingController(
                              text: controller.payments[element['id']] != null
                                  ? controller.payments[element['id']]
                                      ['public_key']
                                  : "")
                            ..selection = TextSelection.fromPosition(
                              TextPosition(
                                  offset: controller.payments[element['id']] !=
                                              null &&
                                          controller.payments[element['id']]
                                                  ['public_key'] !=
                                              null
                                      ? controller
                                          .payments[element['id']]['public_key']
                                          .length
                                      : 0),
                            ),
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: HexColor("#000000"),
                              fontFamily: "MIcon",
                              fontSize: 16.sp,
                              letterSpacing: -0.4),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        )),
                  if (int.parse(element['type'].toString()) == 2)
                    const SizedBox(
                      height: 15,
                    ),
                  if (int.parse(element['type'].toString()) == 2)
                    SelectInput(
                        title: "Api key",
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            if (controller.payments[element['id']] == null) {
                              controller.payments[element['id']] = {
                                "payment_id": element['id'],
                                "private_key": "",
                                "public_key": ""
                              };
                            }

                            controller.payments[element['id']]['private_key'] =
                                text;
                            controller.payments.refresh();
                          },
                          controller: TextEditingController(
                              text: controller.payments[element['id']] != null
                                  ? controller.payments[element['id']]
                                      ['private_key']
                                  : "")
                            ..selection = TextSelection.fromPosition(
                              TextPosition(
                                  offset: controller.payments[element['id']] !=
                                              null &&
                                          controller.payments[element['id']]
                                                  ['private_key'] !=
                                              null
                                      ? controller
                                          .payments[element['id']]
                                              ['private_key']
                                          .length
                                      : 0),
                            ),
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: HexColor("#000000"),
                              fontFamily: "MIcon",
                              fontSize: 16.sp,
                              letterSpacing: -0.4),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        )),
                  if (controller.payments[element['id']] != null)
                    const SizedBox(
                      height: 20,
                    ),
                  if (controller.payments[element['id']] != null)
                    InkWell(
                      onTap: () {
                        controller.saveShopPayment(element['id']);
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                            color: HexColor("#16AA16"),
                            borderRadius: BorderRadius.circular(12)),
                        alignment: Alignment.center,
                        child: Text(
                          "Save",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              letterSpacing: -0.4,
                              color: HexColor("#ffffff")),
                        ),
                      ),
                    )
                ],
              ),
            );
          }).toList(),
        )),
      );
    });
  }
}
