import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/components/shop_background_image.dart';
import 'package:vendor/src/components/shop_logo_upload.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/pages/shop_box.dart';
import 'package:vendor/src/pages/shop_delivery.dart';
import 'package:vendor/src/pages/shop_payment.dart';
import 'package:vendor/src/pages/shop_transport.dart';
import 'package:vendor/src/requests/image_upload_request.dart';

class ShopAdd extends GetView<OrderController> {
  const ShopAdd({Key? key}) : super(key: key);

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
            title: controller.edit.value ? "Shop edit" : "Shop Add",
            actions: [
              if (controller.shopTabIndex.value >= 1 &&
                  controller.shopTabIndex.value <= 3)
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
                          width: 5,
                        ),
                        Text(
                          controller.shopTabIndex.value == 1
                              ? "Add shop delivery"
                              : controller.shopTabIndex.value == 2
                                  ? "Add shop transport"
                                  : "Add shop box",
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
                    if (controller.shopTabIndex.value == 1) {
                      controller.shopController.getShopDeliveryTypes();
                      controller.shopController.shopDeliveryEdit.value = false;
                      Get.toNamed("/shopDeliveryAdd");
                    } else if (controller.shopTabIndex.value == 2) {
                      controller.shopController.getShoptransports();
                      controller.shopController.shopTransportEdit.value = false;
                      Get.toNamed("/shopTransportAdd");
                    } else if (controller.shopTabIndex.value == 3) {
                      controller.shopController.getShopBoxes();
                      controller.shopController.shopBoxEdit.value = false;
                      Get.toNamed("/shopBoxAdd");
                    }
                  },
                )
            ]),
        body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
          if (controller.edit.value)
            Container(
                width: 1.sw,
                height: 50,
                decoration: BoxDecoration(color: HexColor("#ffffff")),
                child: DefaultTabController(
                  initialIndex: controller.shopTabIndex.value,
                  length: 5,
                  child: TabBar(
                      isScrollable: true,
                      indicatorColor: HexColor("#16AA16"),
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: HexColor("#8A8A8A"),
                      labelColor: HexColor("#16AA16"),
                      onTap: (index) {
                        controller.shopTabIndex.value = index;
                      },
                      labelStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                      tabs: const [
                        Tab(
                          text: "Shop",
                        ),
                        Tab(
                          text: "Shop deliveries",
                        ),
                        Tab(
                          text: "Shop transports",
                        ),
                        Tab(
                          text: "Shop box",
                        ),
                        Tab(
                          text: "Shop payments",
                        ),
                      ]),
                )),
          Container(
            child: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: controller
                          .shopController.languageController.languages
                          .map((element) {
                        return InkWell(
                          onTap: () {
                            controller.shopController.activeLanguage.value =
                                element.shortName!;
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1,
                                    color: controller.shopController
                                                .activeLanguage.value !=
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
                      height: 20,
                    ),
                    Text(
                      "Logo",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: HexColor("#000000"),
                          fontSize: 16.sp),
                    ),
                    ShopLogoUpload(
                      image: controller.shopController.shopLogoName.value,
                      onUploadImage: () async {
                        try {
                          final pickedFile =
                              await controller.shopController.picker.pickImage(
                            source: ImageSource.gallery,
                            maxWidth: 1000,
                            maxHeight: 1000,
                            imageQuality: 90,
                          );

                          if (pickedFile != null) {
                            Map<String, dynamic> data =
                                await imageUploadRequest(File(pickedFile.path));
                            controller.shopController.shopLogoName.value =
                                data['name'];
                          }
                        } catch (e) {
                          //
                        }
                      },
                    ),
                    Text(
                      "Backgorund image",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: HexColor("#000000"),
                          fontSize: 16.sp),
                    ),
                    ShopBackgroundImage(
                      image: controller.shopController.shopBackImageName.value,
                      onUploadImage: () async {
                        try {
                          final pickedFile =
                              await controller.shopController.picker.pickImage(
                            source: ImageSource.gallery,
                            maxWidth: 1000,
                            maxHeight: 1000,
                            imageQuality: 90,
                          );

                          if (pickedFile != null) {
                            Map<String, dynamic> data =
                                await imageUploadRequest(File(pickedFile.path));
                            controller.shopController.shopBackImageName.value =
                                data['name'];
                          }
                        } catch (e) {
                          //
                        }
                      },
                    ),
                    SelectInput(
                        title: "Shop name",
                        child: TextField(
                          onChanged: (text) {
                            controller.shopController.shopName[controller
                                .shopController.activeLanguage.value] = text;
                          },
                          controller: TextEditingController(
                              text: controller.shopController.shopName[
                                  controller
                                      .shopController.activeLanguage.value])
                            ..selection = TextSelection.fromPosition(
                              TextPosition(
                                  offset: controller.shopController.shopName[
                                              controller.shopController
                                                  .activeLanguage.value] !=
                                          null
                                      ? controller
                                          .shopController
                                          .shopName[controller.shopController
                                              .activeLanguage.value]
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
                    SelectInput(
                      title: "Shop category",
                      child: DropdownButton<int>(
                        underline: Container(),
                        value: controller.shopController.shopCategoryId.value,
                        isExpanded: true,
                        icon: Icon(
                          const IconData(0xea4e, fontFamily: 'MIcon'),
                          size: 28.sp,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                        items: controller.shopController.shopCategories
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
                          controller.shopController.shopCategoryId.value =
                              value!;
                        },
                      ),
                      width: 1.sw - 30,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Shop description",
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
                          controller.shopController.shopDescription[controller
                              .shopController.activeLanguage.value] = text;
                        },
                        controller: TextEditingController(
                            text: controller.shopController.shopDescription[
                                controller.shopController.activeLanguage.value])
                          ..selection = TextSelection.fromPosition(
                            TextPosition(
                                offset:
                                    controller.shopController.shopDescription[
                                                controller.shopController
                                                    .activeLanguage.value] !=
                                            null
                                        ? controller
                                            .shopController
                                            .shopDescription[controller
                                                .shopController
                                                .activeLanguage
                                                .value]!
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
                    Text(
                      "Shop info",
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
                          controller.shopController.shopInfo[controller
                              .shopController.activeLanguage.value] = text;
                        },
                        controller: TextEditingController(
                            text: controller.shopController.shopInfo[
                                controller.shopController.activeLanguage.value])
                          ..selection = TextSelection.fromPosition(
                            TextPosition(
                                offset: controller.shopController.shopInfo[
                                            controller.shopController
                                                .activeLanguage.value] !=
                                        null
                                    ? controller
                                        .shopController
                                        .shopInfo[controller.shopController
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
                        title: "Address",
                        child: TextField(
                          onChanged: (text) {
                            controller.shopController.shopAddress[controller
                                .shopController.activeLanguage.value] = text;
                          },
                          controller: TextEditingController(
                              text: controller.shopController.shopAddress[
                                  controller
                                      .shopController.activeLanguage.value])
                            ..selection = TextSelection.fromPosition(
                              TextPosition(
                                  offset: controller.shopController.shopAddress[
                                              controller.shopController
                                                  .activeLanguage.value] !=
                                          null
                                      ? controller
                                          .shopController
                                          .shopAddress[controller.shopController
                                              .activeLanguage.value]
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
                    SelectInput(
                        title: "Phone number",
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            controller.shopController.shopPhone.value = text;
                          },
                          controller: TextEditingController(
                              text: controller.shopController.shopPhone.value)
                            ..selection = TextSelection.fromPosition(
                              TextPosition(
                                  offset: controller
                                      .shopController.shopPhone.value.length),
                            ),
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: HexColor("#000000"),
                              fontFamily: "MIcon",
                              fontSize: 16.sp,
                              letterSpacing: -0.4),
                          decoration: InputDecoration(
                              prefix: SizedBox(
                                width: 100,
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  value: controller
                                      .shopController.phonePrefixId.value,
                                  isExpanded: true,
                                  icon: Icon(
                                    const IconData(0xea4e, fontFamily: 'MIcon'),
                                    size: 18.sp,
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                  items: controller.shopController.phonePrefixs
                                      .map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value['prefix'],
                                      child: Text(
                                        "${value['prefix']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: HexColor("#000000"),
                                            fontFamily: "MIcon",
                                            fontSize: 14.sp,
                                            letterSpacing: -0.4),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    controller.shopController.phonePrefixId
                                        .value = value!;
                                  },
                                ),
                              ),
                              border: InputBorder.none),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    SelectInput(
                        title: "Mobile number",
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            controller.shopController.shopMobile.value = text;
                          },
                          controller: TextEditingController(
                              text: controller.shopController.shopMobile.value)
                            ..selection = TextSelection.fromPosition(
                              TextPosition(
                                  offset: controller
                                      .shopController.shopMobile.value.length),
                            ),
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: HexColor("#000000"),
                              fontFamily: "MIcon",
                              fontSize: 16.sp,
                              letterSpacing: -0.4),
                          decoration: InputDecoration(
                              prefix: SizedBox(
                                width: 100,
                                child: DropdownButton<String>(
                                  underline: Container(),
                                  value: controller
                                      .shopController.phonePrefixId.value,
                                  isExpanded: true,
                                  icon: Icon(
                                    const IconData(0xea4e, fontFamily: 'MIcon'),
                                    size: 18.sp,
                                    color: const Color.fromRGBO(0, 0, 0, 1),
                                  ),
                                  items: controller.shopController.phonePrefixs
                                      .map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value['prefix'],
                                      child: Text(
                                        "${value['prefix']}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: HexColor("#000000"),
                                            fontFamily: "MIcon",
                                            fontSize: 14.sp,
                                            letterSpacing: -0.4),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    controller.shopController.phonePrefixId
                                        .value = value!;
                                  },
                                ),
                              ),
                              border: InputBorder.none),
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    SelectInput(
                        title: "Open hours",
                        child: TextField(
                          onChanged: (text) {
                            controller.shopController.openHours.value = text;
                          },
                          controller: TextEditingController(
                              text: controller.shopController.openHours.value)
                            ..selection = TextSelection.fromPosition(
                              TextPosition(
                                  offset: controller
                                      .shopController.openHours.value.length),
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
                    SelectInput(
                        title: "Close hour",
                        child: TextField(
                          onChanged: (text) {
                            controller.shopController.closeHours.value = text;
                          },
                          controller: TextEditingController(
                              text: controller.shopController.closeHours.value)
                            ..selection = TextSelection.fromPosition(
                              TextPosition(
                                  offset: controller
                                      .shopController.closeHours.value.length),
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
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    // SelectInput(
                    //     title: "Commission",
                    //     child: TextField(
                    //       keyboardType: TextInputType.number,
                    //       onChanged: (text) {
                    //         controller.shopController.shopComission.value =
                    //             text;
                    //       },
                    //       controller: TextEditingController(
                    //           text:
                    //               controller.shopController.shopComission.value)
                    //         ..selection = TextSelection.fromPosition(
                    //           TextPosition(
                    //               offset: controller.shopController
                    //                   .shopComission.value.length),
                    //         ),
                    //       textCapitalization: TextCapitalization.sentences,
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.w400,
                    //           color: HexColor("#000000"),
                    //           fontFamily: "MIcon",
                    //           fontSize: 16.sp,
                    //           letterSpacing: -0.4),
                    //       decoration:
                    //           const InputDecoration(border: InputBorder.none),
                    //     )),
                    const SizedBox(
                      height: 30,
                    ),
                    SelectInput(
                        title: "Delivery range",
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            controller.shopController.shopDeliveryRange.value =
                                text;
                          },
                          controller: TextEditingController(
                              text: controller
                                  .shopController.shopDeliveryRange.value)
                            ..selection = TextSelection.fromPosition(
                              TextPosition(
                                  offset: controller.shopController
                                      .shopDeliveryRange.value.length),
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
                                !(controller.shopController.shopActive.value ==
                                        1)
                                    ? const IconData(0xeb7d,
                                        fontFamily: 'MIcon')
                                    : const IconData(0xeb80,
                                        fontFamily: 'MIcon'),
                                color: !(controller
                                            .shopController.shopActive.value ==
                                        1)
                                    ? const Color.fromRGBO(0, 0, 0, 1)
                                    : const Color.fromRGBO(0, 173, 16, 1),
                                size: 24.sp,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                (controller.shopController.shopActive.value ==
                                        1)
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
                            if (controller.shopController.shopActive.value ==
                                0) {
                              controller.shopController.shopActive.value = 1;
                            } else {
                              controller.shopController.shopActive.value = 0;
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
                          "Delivery type",
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
                                !(controller.shopController.shopDeliveryType
                                            .value ==
                                        1)
                                    ? const IconData(0xeb7d,
                                        fontFamily: 'MIcon')
                                    : const IconData(0xeb80,
                                        fontFamily: 'MIcon'),
                                color: !(controller.shopController
                                            .shopDeliveryType.value ==
                                        1)
                                    ? const Color.fromRGBO(0, 0, 0, 1)
                                    : const Color.fromRGBO(0, 173, 16, 1),
                                size: 24.sp,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Delivery",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: HexColor("#000000")),
                              ),
                            ],
                          ),
                          onTap: () {
                            controller.shopController.shopDeliveryType.value =
                                1;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                !(controller.shopController.shopDeliveryType
                                            .value ==
                                        2)
                                    ? const IconData(0xeb7d,
                                        fontFamily: 'MIcon')
                                    : const IconData(0xeb80,
                                        fontFamily: 'MIcon'),
                                color: !(controller.shopController
                                            .shopDeliveryType.value ==
                                        2)
                                    ? const Color.fromRGBO(0, 0, 0, 1)
                                    : const Color.fromRGBO(0, 173, 16, 1),
                                size: 24.sp,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Pickup",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: HexColor("#000000")),
                              ),
                            ],
                          ),
                          onTap: () {
                            controller.shopController.shopDeliveryType.value =
                                2;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                !(controller.shopController.shopDeliveryType
                                            .value ==
                                        3)
                                    ? const IconData(0xeb7d,
                                        fontFamily: 'MIcon')
                                    : const IconData(0xeb80,
                                        fontFamily: 'MIcon'),
                                color: !(controller.shopController
                                            .shopDeliveryType.value ==
                                        3)
                                    ? const Color.fromRGBO(0, 0, 0, 1)
                                    : const Color.fromRGBO(0, 173, 16, 1),
                                size: 24.sp,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Delivery & Pickup",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: HexColor("#000000")),
                              ),
                            ],
                          ),
                          onTap: () {
                            controller.shopController.shopDeliveryType.value =
                                3;
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
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                !(controller.shopController.shopFeatureType
                                            .value ==
                                        1)
                                    ? const IconData(0xeb7d,
                                        fontFamily: 'MIcon')
                                    : const IconData(0xeb80,
                                        fontFamily: 'MIcon'),
                                color: !(controller.shopController
                                            .shopFeatureType.value ==
                                        1)
                                    ? const Color.fromRGBO(0, 0, 0, 1)
                                    : const Color.fromRGBO(0, 173, 16, 1),
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
                            controller.shopController.shopFeatureType.value = 1;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                !(controller.shopController.shopFeatureType
                                            .value ==
                                        2)
                                    ? const IconData(0xeb7d,
                                        fontFamily: 'MIcon')
                                    : const IconData(0xeb80,
                                        fontFamily: 'MIcon'),
                                color: !(controller.shopController
                                            .shopFeatureType.value ==
                                        2)
                                    ? const Color.fromRGBO(0, 0, 0, 1)
                                    : const Color.fromRGBO(0, 173, 16, 1),
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
                            controller.shopController.shopFeatureType.value = 2;
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                !(controller.shopController.shopFeatureType
                                            .value ==
                                        3)
                                    ? const IconData(0xeb7d,
                                        fontFamily: 'MIcon')
                                    : const IconData(0xeb80,
                                        fontFamily: 'MIcon'),
                                color: !(controller.shopController
                                            .shopFeatureType.value ==
                                        3)
                                    ? const Color.fromRGBO(0, 0, 0, 1)
                                    : const Color.fromRGBO(0, 173, 16, 1),
                                size: 24.sp,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Top",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: HexColor("#000000")),
                              ),
                            ],
                          ),
                          onTap: () {
                            controller.shopController.shopFeatureType.value = 3;
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
                          "isClosed",
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
                                !(controller.shopController.shopIsClosed
                                            .value ==
                                        1)
                                    ? const IconData(0xeb7d,
                                        fontFamily: 'MIcon')
                                    : const IconData(0xeb80,
                                        fontFamily: 'MIcon'),
                                color: !(controller.shopController.shopIsClosed
                                            .value ==
                                        1)
                                    ? const Color.fromRGBO(0, 0, 0, 1)
                                    : const Color.fromRGBO(0, 173, 16, 1),
                                size: 24.sp,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                (controller.shopController.shopIsClosed.value ==
                                        1)
                                    ? "Open"
                                    : "Closed",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: HexColor("#000000")),
                              ),
                            ],
                          ),
                          onTap: () {
                            if (controller.shopController.shopIsClosed.value ==
                                0) {
                              controller.shopController.shopIsClosed.value = 1;
                            } else {
                              controller.shopController.shopIsClosed.value = 0;
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                        width: 1.sw,
                        height: 300,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          onTap: (LatLng value) {
                            controller.shopController.mapCenter['latitude'] =
                                value.latitude;
                            controller.shopController.mapCenter['longitude'] =
                                value.longitude;

                            MarkerId _markerId = const MarkerId('marker_id_0');
                            Marker _marker = Marker(
                              markerId: _markerId,
                              position: LatLng(value.latitude, value.longitude),
                              draggable: false,
                            );

                            Map<MarkerId, Marker> markerData = {};
                            markerData[_markerId] = _marker;

                            controller.shopController.markers.value =
                                markerData;
                          },
                          markers: Set<Marker>.of(
                              controller.shopController.markers.values),
                          zoomControlsEnabled: false,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                controller.shopController.mapCenter['latitude'],
                                controller
                                    .shopController.mapCenter['longitude']),
                            zoom: 14,
                          ),
                          onMapCreated: (GoogleMapController mapcontroller) {
                            if (!controller
                                .shopController.mapController!.isCompleted) {
                              controller.shopController.mapController!
                                  .complete(mapcontroller);
                            }
                          },
                        )),
                    const SizedBox(
                      height: 120,
                    ),
                  ],
                ),
              ),
              const ShopDeliveries(),
              const ShopTransport(),
              const ShopBox(),
              const ShopPayment()
            ][controller.shopTabIndex.value],
          )
        ])),
        extendBody: true,
        bottomNavigationBar: controller.shopTabIndex.value == 0
            ? InkWell(
                onTap: () {
                  controller.shopController.onSaveShop();
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  width: 1.sw - 30,
                  height: 60,
                  decoration: BoxDecoration(
                      color: HexColor("#16AA16"),
                      borderRadius: BorderRadius.circular(30)),
                  alignment: Alignment.center,
                  child: controller.shopController.loading.value
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
            : Container(),
      );
    });
  }
}
