import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/brand_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandsCategoryAdd extends GetView<BrandController> {
  const BrandsCategoryAdd({Key? key}) : super(key: key);

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
              title: !controller.edit.value
                  ? "Brand category add"
                  : "Brand category edit"),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:
                      controller.languageController.languages.map((element) {
                    return InkWell(
                      onTap: () {
                        controller.activeLanguage.value = element.shortName!;
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: controller.activeLanguage.value !=
                                        element.shortName!
                                    ? HexColor("#000000").withOpacity(0.1)
                                    : HexColor("#16AA16"))),
                        child: Text(
                          "${element.name}",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              letterSpacing: -0.4,
                              color: HexColor("#000000")),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 30,
                ),
                SelectInput(
                    title: "Name",
                    child: TextField(
                      onChanged: (text) {
                        controller.brandCategoryName[
                            controller.activeLanguage.value] = text;
                      },
                      controller: TextEditingController(
                          text: controller.brandCategoryName[
                              controller.activeLanguage.value])
                        ..selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: controller.brandCategoryName[
                                          controller.activeLanguage.value] !=
                                      null
                                  ? controller
                                      .brandCategoryName[
                                          controller.activeLanguage.value]!
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
                            !controller.active.value
                                ? const IconData(0xeb7d, fontFamily: 'MIcon')
                                : const IconData(0xeb80, fontFamily: 'MIcon'),
                            color: !controller.active.value
                                ? const Color.fromRGBO(0, 0, 0, 1)
                                : const Color.fromRGBO(0, 173, 16, 1),
                            size: 24.sp,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            controller.active.value ? "Active" : "Inactive",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                color: HexColor("#000000")),
                          ),
                        ],
                      ),
                      onTap: () {
                        controller.active.value = !controller.active.value;
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
              if (controller
                          .brandCategoryName[controller.activeLanguage.value] !=
                      null &&
                  controller.brandCategoryName[controller.activeLanguage.value]!
                          .length >
                      1) {
                controller.brandCategorySave();
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              width: 1.sw - 30,
              height: 60,
              decoration: BoxDecoration(
                  color: (controller.brandCategoryName[
                                  controller.activeLanguage.value] !=
                              null &&
                          controller
                                  .brandCategoryName[
                                      controller.activeLanguage.value]!
                                  .length >
                              1)
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
          ));
    });
  }
}
