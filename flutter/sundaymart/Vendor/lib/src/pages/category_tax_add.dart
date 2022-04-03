import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class CategoryTaxAdd extends GetView<CategoryController> {
  const CategoryTaxAdd({Key? key}) : super(key: key);

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
              title: controller.categoryTaxEdit.value
                  ? "Category Tax Edit"
                  : "Category Tax Add"),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                SelectInput(
                  title: "Tax",
                  child: DropdownButton<int>(
                    underline: Container(),
                    value: controller.taxId.value,
                    isExpanded: true,
                    icon: Icon(
                      const IconData(0xea4e, fontFamily: 'MIcon'),
                      size: 28.sp,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                    items: controller.taxes.map((value) {
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
                      controller.taxId.value = value!;
                    },
                  ),
                  width: 1.sw - 30,
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
                            !controller.categoryTaxActive.value
                                ? const IconData(0xeb7d, fontFamily: 'MIcon')
                                : const IconData(0xeb80, fontFamily: 'MIcon'),
                            color: !controller.categoryTaxActive.value
                                ? const Color.fromRGBO(0, 0, 0, 1)
                                : const Color.fromRGBO(0, 173, 16, 1),
                            size: 24.sp,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            controller.categoryTaxActive.value
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
                        controller.categoryTaxActive.value =
                            !controller.categoryTaxActive.value;
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          extendBody: true,
          bottomNavigationBar: InkWell(
            onTap: () {
              controller.saveCategoryTaxes();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              width: 1.sw - 30,
              height: 60,
              decoration: BoxDecoration(
                  color: HexColor("#16AA16"),
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
          ));
    });
  }
}
