import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/image_upload.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/brand_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/requests/image_upload_request.dart';

class BrandsAdd extends GetView<BrandController> {
  const BrandsAdd({Key? key}) : super(key: key);

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
              title: controller.edit.value ? "Brand edit" : "Brand Add"),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                ImageUpload(
                  onUploadImage: () async {
                    try {
                      final pickedFile = await controller.picker.pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 1000,
                        maxHeight: 1000,
                        imageQuality: 90,
                      );

                      if (pickedFile != null) {
                        Map<String, dynamic> data =
                            await imageUploadRequest(File(pickedFile.path));
                        controller.brandImage.value = data['name'];
                      }
                    } catch (e) {
                      //
                    }
                  },
                  image: controller.brandImage.value,
                ),
                const SizedBox(
                  height: 40,
                ),
                SelectInput(
                  title: "Brand category",
                  child: DropdownButton<int>(
                    underline: Container(),
                    value: controller.brandCategoryId.value,
                    isExpanded: true,
                    icon: Icon(
                      const IconData(0xea4e, fontFamily: 'MIcon'),
                      size: 28.sp,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                    items: controller.activeBrandCategories.map((value) {
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
                      controller.brandCategoryId.value = value!;
                    },
                  ),
                  width: 1.sw - 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                SelectInput(
                  title: "Shops",
                  child: DropdownButton<int>(
                    underline: Container(),
                    value: controller.orderController.shopId.value,
                    isExpanded: true,
                    icon: Icon(
                      const IconData(0xea4e, fontFamily: 'MIcon'),
                      size: 28.sp,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                    items: controller.orderController.shops.map((value) {
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
                      controller.orderController.shopId.value = value!;
                    },
                  ),
                  width: 1.sw - 30,
                ),
                const SizedBox(
                  height: 30,
                ),
                SelectInput(
                    title: "Name",
                    child: TextField(
                      onChanged: (text) {
                        controller.brandName.value = text;
                      },
                      controller: TextEditingController(
                          text: controller.brandName.value)
                        ..selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: controller.brandName.value.length),
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
                ),
                const SizedBox(
                  height: 120,
                )
              ],
            ),
          ),
          extendBody: true,
          bottomNavigationBar: InkWell(
            onTap: () {
              if (controller.brandImage.value.length > 4 &&
                  controller.brandName.value.length > 1) controller.brandSave();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              width: 1.sw - 30,
              height: 60,
              decoration: BoxDecoration(
                  color: (controller.brandImage.value.length > 4 &&
                          controller.brandName.value.length > 1)
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
