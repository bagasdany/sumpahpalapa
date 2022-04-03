import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/dialog_error.dart';
import 'package:vendor/src/components/image_upload.dart';
import 'package:vendor/src/components/product_character_item.dart';
import 'package:vendor/src/components/product_extra_item.dart';
import 'package:vendor/src/components/product_extras_group_item.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/product_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/requests/extra_group_delete_request.dart';
import 'package:vendor/src/requests/image_upload_request.dart';
import 'package:vendor/src/requests/product_character_delete_request.dart';

class ProductAdd extends GetView<ProductController> {
  const ProductAdd({Key? key}) : super(key: key);

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
                if (controller.tabIndex.value != 0)
                  InkWell(
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
                            controller.tabIndex.value == 1
                                ? "Add character"
                                : controller.tabIndex.value == 2
                                    ? "Add extra group"
                                    : "Add extra",
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
                    onTap: () {
                      if (controller.tabIndex.value == 1) {
                        controller.characterEdit.value = false;
                        Get.toNamed("/productCharacterAdd");
                      } else if (controller.tabIndex.value == 2) {
                        controller.extrasGroupEdit.value = false;
                        Get.toNamed("/productExtraGroupAdd");
                      } else if (controller.tabIndex.value == 3) {
                        controller.extrasEdit.value = false;
                        Get.toNamed("/productExtraAdd");
                      }
                    },
                  )
              ],
              title: controller.edit.value ? "Product edit" : "Product Add"),
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (controller.edit.value)
                  Container(
                      width: 1.sw,
                      height: 50,
                      decoration: BoxDecoration(color: HexColor("#ffffff")),
                      child: DefaultTabController(
                        initialIndex: controller.tabIndex.value,
                        length: 4,
                        child: TabBar(
                            indicatorColor: HexColor("#16AA16"),
                            indicatorSize: TabBarIndicatorSize.label,
                            unselectedLabelColor: HexColor("#8A8A8A"),
                            isScrollable: true,
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
                                text: "Product",
                              ),
                              Tab(
                                text: "Characteristics",
                              ),
                              Tab(
                                text: "Extras group",
                              ),
                              Tab(
                                text: "Extras",
                              ),
                            ]),
                      )),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  child: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                          height: 40,
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
                                controller.productImageName.value =
                                    data['name'];
                              }
                            } catch (e) {
                              //
                            }
                          },
                          image: controller.productImageName.value,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SelectInput(
                            title: "Name",
                            child: TextField(
                              onChanged: (text) {
                                controller.productName[
                                    controller.activeLanguage.value] = text;
                              },
                              controller: TextEditingController(
                                  text: controller.productName[
                                      controller.activeLanguage.value])
                                ..selection = TextSelection.fromPosition(
                                  TextPosition(
                                      offset: controller.productName[controller
                                                  .activeLanguage.value] !=
                                              null
                                          ? controller
                                              .productName[controller
                                                  .activeLanguage.value]!
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
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.4,
                              color: const Color.fromRGBO(0, 0, 0, 0.3)),
                        ),
                        Container(
                          width: 1.sw - 30,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(143, 146, 161, 0.05),
                              borderRadius: BorderRadius.circular(15)),
                          child: TextField(
                            maxLines: 6,
                            onChanged: (text) {
                              controller.productDescription[
                                  controller.activeLanguage.value] = text;
                            },
                            controller: TextEditingController(
                                text: controller.productDescription[
                                    controller.activeLanguage.value])
                              ..selection = TextSelection.fromPosition(
                                TextPosition(
                                    offset: controller.productDescription[
                                                controller
                                                    .activeLanguage.value] !=
                                            null
                                        ? controller
                                            .productDescription[controller
                                                .activeLanguage.value]!
                                            .length
                                        : 0),
                              ),
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                letterSpacing: -0.4,
                                color: HexColor("#000000")),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(15),
                                border: InputBorder.none,
                                hintText: "Type here",
                                hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    letterSpacing: -0.4,
                                    color: HexColor("#AFAFAF"))),
                          ),
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
                              controller.orderController.shopId.value = value!;
                              controller.getActiveBrands(value);
                              controller.getActiveCategories(value);
                            },
                          ),
                          width: 1.sw - 30,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SelectInput(
                          title: "Brand",
                          child: DropdownButton<int>(
                            underline: Container(),
                            value: controller.brandId.value,
                            isExpanded: true,
                            icon: Icon(
                              const IconData(0xea4e, fontFamily: 'MIcon'),
                              size: 28.sp,
                              color: const Color.fromRGBO(0, 0, 0, 1),
                            ),
                            items: controller.activeBrands.map((value) {
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
                              controller.brandId.value = value!;
                            },
                          ),
                          width: 1.sw - 30,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SelectInput(
                          title: "Category",
                          child: DropdownButton<int>(
                            underline: Container(),
                            value: controller.categoryId.value,
                            isExpanded: true,
                            icon: Icon(
                              const IconData(0xea4e, fontFamily: 'MIcon'),
                              size: 28.sp,
                              color: const Color.fromRGBO(0, 0, 0, 1),
                            ),
                            items: controller.activeCategories.map((value) {
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
                              controller.categoryId.value = value!;
                            },
                          ),
                          width: 1.sw - 30,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SelectInput(
                            title: "Package count",
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                controller.packageCount.value = text;
                              },
                              controller: TextEditingController(
                                  text: controller.packageCount.value)
                                ..selection = TextSelection.fromPosition(
                                  TextPosition(
                                      offset:
                                          controller.packageCount.value.length),
                                ),
                              textCapitalization: TextCapitalization.sentences,
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
                        SelectInput(
                            title: "Price",
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                controller.price.value = text;
                              },
                              controller: TextEditingController(
                                  text: controller.price.value)
                                ..selection = TextSelection.fromPosition(
                                  TextPosition(
                                      offset: controller.price.value.length),
                                ),
                              textCapitalization: TextCapitalization.sentences,
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
                        SelectInput(
                            title: "Quantity",
                            child: TextField(
                              onChanged: (text) {
                                controller.quantity.value = text;
                              },
                              keyboardType: TextInputType.number,
                              controller: TextEditingController(
                                  text: controller.quantity.value)
                                ..selection = TextSelection.fromPosition(
                                  TextPosition(
                                      offset: controller.quantity.value.length),
                                ),
                              textCapitalization: TextCapitalization.sentences,
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
                        SelectInput(
                          title: "Unit",
                          child: DropdownButton<int>(
                            underline: Container(),
                            value: controller.unitId.value,
                            isExpanded: true,
                            icon: Icon(
                              const IconData(0xea4e, fontFamily: 'MIcon'),
                              size: 28.sp,
                              color: const Color.fromRGBO(0, 0, 0, 1),
                            ),
                            items: controller.units.map((value) {
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
                              controller.unitId.value = value!;
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
                              "Feature type",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  color: HexColor("#000000")),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        !(controller.featureType.value == 1)
                                            ? const IconData(0xeb7d,
                                                fontFamily: 'MIcon')
                                            : const IconData(0xeb80,
                                                fontFamily: 'MIcon'),
                                        color: !controller.active.value
                                            ? const Color.fromRGBO(0, 0, 0, 1)
                                            : const Color.fromRGBO(
                                                0, 173, 16, 1),
                                        size: 24.sp,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Default",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                            color: HexColor("#000000")),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    controller.featureType.value = 1;
                                  },
                                ),
                                InkWell(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        !(controller.featureType.value == 2)
                                            ? const IconData(0xeb7d,
                                                fontFamily: 'MIcon')
                                            : const IconData(0xeb80,
                                                fontFamily: 'MIcon'),
                                        color: !controller.active.value
                                            ? const Color.fromRGBO(0, 0, 0, 1)
                                            : const Color.fromRGBO(
                                                0, 173, 16, 1),
                                        size: 24.sp,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "New",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                            color: HexColor("#000000")),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    controller.featureType.value = 2;
                                  },
                                ),
                                InkWell(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        !(controller.featureType.value == 3)
                                            ? const IconData(0xeb7d,
                                                fontFamily: 'MIcon')
                                            : const IconData(0xeb80,
                                                fontFamily: 'MIcon'),
                                        color: !controller.active.value
                                            ? const Color.fromRGBO(0, 0, 0, 1)
                                            : const Color.fromRGBO(
                                                0, 173, 16, 1),
                                        size: 24.sp,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Recommended",
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.sp,
                                            color: HexColor("#000000")),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    controller.featureType.value = 3;
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                      ],
                    ),
                    (controller.characters.isNotEmpty)
                        ? Column(
                            children: controller.characters.map((element) {
                              return ProductCharacterItem(
                                onDelete: () {
                                  showDialog(
                                      context: context,
                                      barrierColor:
                                          HexColor("#000000").withOpacity(0.2),
                                      builder: (_) {
                                        return DialogError(
                                          title: "Delete product character",
                                          description:
                                              "Do you want to delete product character #${element['id']}",
                                          onPressOk: () async {
                                            Get.back();
                                            await productCharacterDeleteRequest(
                                                element['id']);
                                            controller.characters.value = [];
                                            controller
                                                .getProductCharacteristics(
                                                    controller.productId.value);
                                          },
                                        );
                                      });
                                },
                                onEdit: () {
                                  controller.getCharacterById(element['id']);
                                  controller.characterEdit.value = true;
                                  Get.toNamed("/productCharacterAdd");
                                },
                                ikey: element['key'],
                                value: element['value'],
                                isActive: element['active'] == 1,
                              );
                            }).toList(),
                          )
                        : Container(
                            width: 1.sw,
                            height: 1.sw,
                            alignment: Alignment.center,
                            child: Text(
                              "No characteristics",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(0, 0, 0, 0.8),
                                  fontSize: 16.sp,
                                  letterSpacing: -0.5),
                            ),
                          ),
                    (controller.extrasGroup.isNotEmpty)
                        ? Column(
                            children: controller.extrasGroup.map((element) {
                              return ProductExtrasGroupItem(
                                name: element['name'],
                                type: element['type'],
                                isActive: element['active'] == 1,
                                onDelete: () {
                                  showDialog(
                                      context: context,
                                      barrierColor:
                                          HexColor("#000000").withOpacity(0.2),
                                      builder: (_) {
                                        return DialogError(
                                          title: "Delete product extra group",
                                          description:
                                              "Do you want to delete product extra group #${element['id']}",
                                          onPressOk: () async {
                                            Get.back();
                                            await extraGroupDeleteRequest(
                                                element['id']);
                                            controller.extrasGroup.value = [];
                                            controller.getProductExtrasGroup(
                                                controller.productId.value);
                                          },
                                        );
                                      });
                                },
                                onEdit: () {
                                  controller.getExtraGroupById(element['id']);
                                  controller.extrasGroupEdit.value = true;
                                  Get.toNamed("/productExtraGroupAdd");
                                },
                              );
                            }).toList(),
                          )
                        : Container(
                            width: 1.sw,
                            height: 1.sw,
                            alignment: Alignment.center,
                            child: Text(
                              "No extras group",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(0, 0, 0, 0.8),
                                  fontSize: 16.sp,
                                  letterSpacing: -0.5),
                            ),
                          ),
                    (controller.extras.isNotEmpty)
                        ? Column(
                            children: controller.extras.map((element) {
                              return ProductExtrasItem(
                                name: element['name'],
                                group: element['group'],
                                description: element['description'],
                                isActive: element['active'] == 1,
                                onDelete: () {},
                                onEdit: () {},
                              );
                            }).toList(),
                          )
                        : Container(
                            width: 1.sw,
                            height: 1.sw,
                            alignment: Alignment.center,
                            child: Text(
                              "No extras",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(0, 0, 0, 0.8),
                                  fontSize: 16.sp,
                                  letterSpacing: -0.5),
                            ),
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
                    if (controller.productImageName.value.length > 4 &&
                        controller
                                .productName[controller.activeLanguage.value] !=
                            null &&
                        controller.productName[controller.activeLanguage.value]!
                                .length >
                            1) controller.productSave();
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    width: 1.sw - 30,
                    height: 60,
                    decoration: BoxDecoration(
                        color: (controller.productImageName.value.length > 4 &&
                                controller.productName[
                                        controller.activeLanguage.value] !=
                                    null &&
                                controller
                                        .productName[
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
