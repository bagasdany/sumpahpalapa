import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/shop_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class ShopTransportAdd extends GetView<ShopController> {
  const ShopTransportAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: HexColor("#F9F9FA"),
        appBar: customAppBar(
          icon: const IconData(0xea60, fontFamily: 'MIcon'),
          onClickIcon: () {
            Get.back();
          },
          title: controller.shopTransportEdit.value
              ? "Shop transport edit"
              : "Shop transport Add",
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              SelectInput(
                title: "Delivery transport",
                child: DropdownButton<int>(
                  underline: Container(),
                  value: controller.shopTransportInput['type'],
                  isExpanded: true,
                  icon: Icon(
                    const IconData(0xea4e, fontFamily: 'MIcon'),
                    size: 28.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                  items: controller.transports.map((value) {
                    return DropdownMenuItem<int>(
                      value: value['id'],
                      child: Text(
                        "${value['language']['name']}",
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
                    controller.shopTransportInput['type'] = value!;
                  },
                ),
                width: 1.sw - 30,
              ),
              const SizedBox(
                height: 30,
              ),
              SelectInput(
                  title: "Amount",
                  child: TextField(
                    onChanged: (text) {
                      controller.shopTransportInput['price'] = text;
                    },
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                        text: controller.shopTransportInput['price'])
                      ..selection = TextSelection.fromPosition(
                        TextPosition(
                            offset: controller.shopTransportInput['price'] !=
                                    null
                                ? controller.shopTransportInput['price'].length
                                : 0),
                      ),
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: HexColor("#000000"),
                        fontFamily: "MIcon",
                        fontSize: 16.sp,
                        letterSpacing: -0.4),
                    decoration: const InputDecoration(border: InputBorder.none),
                  )),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Default",
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
                          !(controller.shopTransportInput['default'] == 1)
                              ? const IconData(0xeb7d, fontFamily: 'MIcon')
                              : const IconData(0xeb80, fontFamily: 'MIcon'),
                          color:
                              !(controller.shopTransportInput['default'] == 1)
                                  ? const Color.fromRGBO(0, 0, 0, 1)
                                  : const Color.fromRGBO(0, 173, 16, 1),
                          size: 24.sp,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          (controller.shopTransportInput['default'] == 1)
                              ? "Default"
                              : "No default",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: HexColor("#000000")),
                        ),
                      ],
                    ),
                    onTap: () {
                      if (controller.shopTransportInput['default'] == 0) {
                        controller.shopTransportInput['default'] = 1;
                      } else {
                        controller.shopTransportInput['default'] = 0;
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Status",
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
                          !(controller.shopTransportInput['active'] == 1)
                              ? const IconData(0xeb7d, fontFamily: 'MIcon')
                              : const IconData(0xeb80, fontFamily: 'MIcon'),
                          color: !(controller.shopTransportInput['active'] == 1)
                              ? const Color.fromRGBO(0, 0, 0, 1)
                              : const Color.fromRGBO(0, 173, 16, 1),
                          size: 24.sp,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          (controller.shopTransportInput['active'] == 1)
                              ? "Active"
                              : "Inactive",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: HexColor("#000000")),
                        ),
                      ],
                    ),
                    onTap: () {
                      if (controller.shopTransportInput['active'] == 0) {
                        controller.shopTransportInput['active'] = 1;
                      } else {
                        controller.shopTransportInput['active'] = 0;
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 120,
              ),
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: InkWell(
          onTap: () {
            if (controller.shopTransportInput['price'] != null) {
              controller.saveShopTransport();
            }
          },
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            width: 1.sw - 30,
            height: 60,
            decoration: BoxDecoration(
                color: (controller.shopTransportInput['price'] != null)
                    ? HexColor("#16AA16")
                    : HexColor("#F1F1F1"),
                borderRadius: BorderRadius.circular(30)),
            alignment: Alignment.center,
            child: controller.loading.value
                ? SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: HexColor("ffffff"),
                    ),
                  )
                : Text(
                    "Save",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 18.sp,
                        letterSpacing: -0.4,
                        color: HexColor("#ffffff")),
                  ),
          ),
        ),
      );
    });
  }
}
