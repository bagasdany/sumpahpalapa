import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopInfoBottomModal extends GetView<OrderController> {
  const ShopInfoBottomModal({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
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
            Text(
              "Shop info",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 22.sp,
                  letterSpacing: -0.4,
                  color: HexColor("#000000")),
            ),
            const SizedBox(
              height: 50,
            ),
            SelectInput(
              title: "Shops",
              child: DropdownButton<int>(
                underline: Container(),
                value: controller.shopId.value,
                isExpanded: true,
                icon: Icon(
                  const IconData(0xea4e, fontFamily: 'MIcon'),
                  size: 28.sp,
                  color: const Color.fromRGBO(0, 0, 0, 1),
                ),
                items: controller.shops.map((value) {
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
                  controller.shopId.value = value!;
                  controller.getActiveProduct(value);
                },
              ),
              width: 1.sw - 30,
            ),
          ],
        ),
      );
    });
  }
}
