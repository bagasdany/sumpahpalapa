import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/controllers/product_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class ProductExtraAdd extends GetView<ProductController> {
  const ProductExtraAdd({Key? key}) : super(key: key);

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
            title: controller.extrasEdit.value
                ? "Product extras edit"
                : "Product extras Add",
          ),
          body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
              ])));
    });
  }
}
