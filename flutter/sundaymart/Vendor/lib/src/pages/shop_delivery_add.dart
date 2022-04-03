import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/shop_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class ShopDeliveryAdd extends GetView<ShopController> {
  const ShopDeliveryAdd({Key? key}) : super(key: key);

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
          title: controller.shopDeliveryEdit.value
              ? "Shop delivery edit"
              : "Shop delivery Add",
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              SelectInput(
                title: "Delivery type",
                child: DropdownButton<int>(
                  underline: Container(),
                  value: controller.shopDeliveryInputs['delivery_type'],
                  isExpanded: true,
                  icon: Icon(
                    const IconData(0xea4e, fontFamily: 'MIcon'),
                    size: 28.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                  items: controller.shopDeliveries.map((value) {
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
                    controller.shopDeliveryInputs['delivery_type'] = value!;
                  },
                ),
                width: 1.sw - 30,
              ),
              const SizedBox(
                height: 30,
              ),
              SelectInput(
                title: "Type",
                child: DropdownButton<int>(
                  underline: Container(),
                  value: controller.shopDeliveryInputs['type'],
                  isExpanded: true,
                  icon: Icon(
                    const IconData(0xea4e, fontFamily: 'MIcon'),
                    size: 28.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                  items: controller.type.map((value) {
                    return DropdownMenuItem<int>(
                      value: value['id'],
                      child: Text(
                        "${value['name']}",
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
                    controller.shopDeliveryInputs['type'] = value!;
                  },
                ),
                width: 1.sw - 30,
              ),
              const SizedBox(
                height: 30,
              ),
              SelectInput(
                  title: "From day",
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      controller.shopDeliveryInputs['from_day'] = text;
                    },
                    controller: TextEditingController(
                        text: controller.shopDeliveryInputs['from_day'])
                      ..selection = TextSelection.fromPosition(
                        TextPosition(
                            offset: controller.shopDeliveryInputs['from_day'] !=
                                    null
                                ? controller
                                    .shopDeliveryInputs['from_day'].length
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
              SelectInput(
                  title: "To day",
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      controller.shopDeliveryInputs['to_day'] = text;
                    },
                    controller: TextEditingController(
                        text: controller.shopDeliveryInputs['to_day'])
                      ..selection = TextSelection.fromPosition(
                        TextPosition(
                            offset: controller.shopDeliveryInputs['to_day'] !=
                                    null
                                ? controller.shopDeliveryInputs['to_day'].length
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
              SelectInput(
                  title: "Amount",
                  child: TextField(
                    onChanged: (text) {
                      controller.shopDeliveryInputs['price'] = text;
                    },
                    keyboardType: TextInputType.number,
                    controller: TextEditingController(
                        text: controller.shopDeliveryInputs['price'])
                      ..selection = TextSelection.fromPosition(
                        TextPosition(
                            offset: controller.shopDeliveryInputs['price'] !=
                                    null
                                ? controller.shopDeliveryInputs['price'].length
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
                          !(controller.shopDeliveryInputs['active'] == 1)
                              ? const IconData(0xeb7d, fontFamily: 'MIcon')
                              : const IconData(0xeb80, fontFamily: 'MIcon'),
                          color: !(controller.shopDeliveryInputs['active'] == 1)
                              ? const Color.fromRGBO(0, 0, 0, 1)
                              : const Color.fromRGBO(0, 173, 16, 1),
                          size: 24.sp,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          (controller.shopDeliveryInputs['active'] == 1)
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
                      if (controller.shopDeliveryInputs['active'] == 0) {
                        controller.shopDeliveryInputs['active'] = 1;
                      } else {
                        controller.shopDeliveryInputs['active'] = 0;
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
            if (controller.shopDeliveryInputs['from_day'] != null &&
                controller.shopDeliveryInputs['to_day'] != null &&
                controller.shopDeliveryInputs['price'] != null) {
              controller.saveShopDelivery();
            }
          },
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            width: 1.sw - 30,
            height: 60,
            decoration: BoxDecoration(
                color: (controller.shopDeliveryInputs['from_day'] != null &&
                        controller.shopDeliveryInputs['to_day'] != null &&
                        controller.shopDeliveryInputs['price'] != null)
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
