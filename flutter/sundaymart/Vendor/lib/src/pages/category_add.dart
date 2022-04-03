import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/dialog_error.dart';
import 'package:vendor/src/components/image_upload.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/category_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:vendor/src/requests/category_tax_delete_request.dart';
import 'package:vendor/src/requests/image_upload_request.dart';

class CategoryAdd extends GetView<CategoryController> {
  const CategoryAdd({Key? key}) : super(key: key);

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
              actions: [
                if (controller.edit.value && controller.tabIndex.value == 1)
                  InkWell(
                    onTap: () {
                      controller.getCategoryTaxes();
                      controller.categoryTaxEdit.value = false;
                      Get.toNamed("/categoryTaxAdd");
                    },
                    child: Container(
                      height: 35,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(22, 170, 22, 1),
                          borderRadius: BorderRadius.circular(18)),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            const IconData(0xea13, fontFamily: 'MIcon'),
                            color: HexColor("#ffffff"),
                            size: 14.sp,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add tax",
                            style: TextStyle(
                                color: HexColor("#ffffff"),
                                fontFamily: 'Inter',
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.5),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
              title: controller.edit.value ? "Category edit" : "Category Add"),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    width: 1.sw,
                    height: 50,
                    decoration: BoxDecoration(color: HexColor("#ffffff")),
                    child: DefaultTabController(
                      initialIndex: controller.tabIndex.value,
                      length: 2,
                      child: TabBar(
                          indicatorColor: HexColor("#16AA16"),
                          indicatorSize: TabBarIndicatorSize.label,
                          unselectedLabelColor: HexColor("#8A8A8A"),
                          labelColor: HexColor("#16AA16"),
                          onTap: (index) {
                            controller.tabIndex.value = index;
                          },
                          labelStyle: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                          tabs: const [
                            Tab(
                              text: "Category",
                            ),
                            Tab(
                              text: "Category taxes",
                            ),
                          ]),
                    )),
                Container(
                  constraints: BoxConstraints(
                    minHeight: 1.sh - 150,
                  ),
                  width: 1.sw,
                  child: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: 1.sw,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: controller.languageController.languages
                                .map((element) {
                              return InkWell(
                                onTap: () {
                                  controller.activeLanguage.value =
                                      element.shortName!;
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color:
                                              controller.activeLanguage.value !=
                                                      element.shortName!
                                                  ? HexColor("#000000")
                                                      .withOpacity(0.1)
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
                          ImageUpload(
                            onUploadImage: () async {
                              try {
                                final pickedFile =
                                    await controller.picker.pickImage(
                                  source: ImageSource.gallery,
                                  maxWidth: 1000,
                                  maxHeight: 1000,
                                  imageQuality: 90,
                                );

                                if (pickedFile != null) {
                                  Map<String, dynamic> data =
                                      await imageUploadRequest(
                                          File(pickedFile.path));
                                  controller.categoryImageName.value =
                                      data['name'];
                                }
                              } catch (e) {
                                //
                              }
                            },
                            image: controller.categoryImageName.value,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SelectInput(
                            title: "Parent category",
                            child: DropdownButton<int>(
                              underline: Container(),
                              value: controller.parentCategoryId.value,
                              isExpanded: true,
                              icon: Icon(
                                const IconData(0xea4e, fontFamily: 'MIcon'),
                                size: 28.sp,
                                color: const Color.fromRGBO(0, 0, 0, 1),
                              ),
                              items: controller.activeParentCategories
                                  .map((value) {
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
                                controller.parentCategoryId.value = value!;
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
                              items:
                                  controller.orderController.shops.map((value) {
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
                                controller.orderController.shopId.value =
                                    value!;
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
                                  controller.categoryName[
                                      controller.activeLanguage.value] = text;
                                },
                                controller: TextEditingController(
                                    text: controller.categoryName[
                                        controller.activeLanguage.value])
                                  ..selection = TextSelection.fromPosition(
                                    TextPosition(
                                        offset: controller.categoryName[
                                                    controller.activeLanguage
                                                        .value] !=
                                                null
                                            ? controller
                                                .categoryName[controller
                                                    .activeLanguage.value]!
                                                .length
                                            : 0),
                                  ),
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: HexColor("#000000"),
                                    fontFamily: "MIcon",
                                    fontSize: 16.sp,
                                    letterSpacing: -0.4),
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
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
                                          ? const IconData(0xeb7d,
                                              fontFamily: 'MIcon')
                                          : const IconData(0xeb80,
                                              fontFamily: 'MIcon'),
                                      color: !controller.active.value
                                          ? const Color.fromRGBO(0, 0, 0, 1)
                                          : const Color.fromRGBO(0, 173, 16, 1),
                                      size: 24.sp,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      controller.active.value
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
                                  controller.active.value =
                                      !controller.active.value;
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 30),
                      width: 1.sw,
                      child: controller.edit.value
                          ? Column(
                              children: controller.categoryTaxes.map((element) {
                                return Container(
                                  width: 1.sw - 30,
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                      color: HexColor("#FFFFFF"),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          SizedBox(
                                            width: 1.sw - 200,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  "${element['name']}",
                                                  style: TextStyle(
                                                      color:
                                                          HexColor("#000000"),
                                                      fontFamily: 'Inter',
                                                      fontSize: 16.sp,
                                                      letterSpacing: -0.4,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                RichText(
                                                    text: TextSpan(
                                                        text: "Percent - ",
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                "#AEAEAF"),
                                                            fontFamily: 'Inter',
                                                            fontSize: 16.sp,
                                                            letterSpacing: -0.4,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        children: <TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            "${element['percent']}",
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                "#AEAEAF"),
                                                            fontFamily: 'Inter',
                                                            fontSize: 16.sp,
                                                            letterSpacing: -0.4,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ])),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 20),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                color: HexColor("#16AA16")
                                                    .withOpacity(0.1)),
                                            child: Text(
                                              element['active'] == 1
                                                  ? "Active"
                                                  : "Inactive",
                                              style: TextStyle(
                                                  color: HexColor("#16AA16"),
                                                  fontFamily: 'Inter',
                                                  fontSize: 14.sp,
                                                  letterSpacing: -0.4,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                      Divider(
                                        color: HexColor("#000000")
                                            .withOpacity(0.1),
                                      ),
                                      SizedBox(
                                        width: 1.sw - 60,
                                        child: Text(
                                          "${element['description']}",
                                          style: TextStyle(
                                              color: HexColor("#6C6C6C"),
                                              fontFamily: 'Inter',
                                              fontSize: 12.sp,
                                              letterSpacing: -0.4,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      // Divider(
                                      //   color: HexColor("#000000")
                                      //       .withOpacity(0.1),
                                      // ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.end,
                                      //   children: <Widget>[
                                      //     InkWell(
                                      //       child: Container(
                                      //         height: 36,
                                      //         width: 36,
                                      //         alignment: Alignment.center,
                                      //         decoration: BoxDecoration(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(18),
                                      //             color: const Color.fromRGBO(
                                      //                 0, 0, 0, 0.05)),
                                      //         child: Icon(
                                      //           const IconData(0xefe0,
                                      //               fontFamily: 'MIcon'),
                                      //           color: HexColor("#000000"),
                                      //           size: 20.sp,
                                      //         ),
                                      //       ),
                                      //       onTap: () {},
                                      //     ),
                                      //     InkWell(
                                      //       child: Container(
                                      //         height: 36,
                                      //         margin: const EdgeInsets.only(
                                      //             left: 10),
                                      //         width: 36,
                                      //         decoration: BoxDecoration(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(18),
                                      //             color: const Color.fromRGBO(
                                      //                 0, 0, 0, 0.05)),
                                      //         child: Icon(
                                      //           const IconData(0xec24,
                                      //               fontFamily: 'MIcon'),
                                      //           color: HexColor("#000000"),
                                      //           size: 20.sp,
                                      //         ),
                                      //       ),
                                      //       onTap: () {
                                      //         showDialog(
                                      //             context: context,
                                      //             barrierColor:
                                      //                 HexColor("#000000")
                                      //                     .withOpacity(0.2),
                                      //             builder: (_) {
                                      //               return DialogError(
                                      //                 title: "Delete category",
                                      //                 description:
                                      //                     "Do you want to delete category tax #${element['id']}",
                                      //                 onPressOk: () async {
                                      //                   await categoryTaxDeleteRequest(
                                      //                       element['id']);

                                      //                   controller
                                      //                       .getCategoryDetail(
                                      //                           controller
                                      //                               .categoryId
                                      //                               .value);

                                      //                   Get.back();
                                      //                 },
                                      //               );
                                      //             });
                                      //       },
                                      //     )
                                      //   ],
                                      // )
                                    ],
                                  ),
                                );
                              }).toList(),
                            )
                          : Container(),
                    )
                  ][controller.tabIndex.value],
                )
              ],
            ),
          ),
          extendBody: true,
          bottomNavigationBar: controller.tabIndex.value == 0
              ? InkWell(
                  onTap: () {
                    if (controller.categoryImageName.value.length > 4 &&
                        controller.categoryName[
                                controller.activeLanguage.value] !=
                            null &&
                        controller
                                .categoryName[controller.activeLanguage.value]!
                                .length >
                            1) {
                      controller.saveCategory();
                    }
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    width: 1.sw - 30,
                    height: 60,
                    decoration: BoxDecoration(
                        color: (controller.categoryImageName.value.length > 4 &&
                                controller.categoryName[
                                        controller.activeLanguage.value] !=
                                    null &&
                                controller
                                        .categoryName[
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
                )
              : Container());
    });
  }
}
