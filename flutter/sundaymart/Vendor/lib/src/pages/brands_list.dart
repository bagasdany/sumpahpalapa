import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/brand_item.dart';
import 'package:vendor/src/components/dialog_error.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/components/shadow/brand_item_shadow.dart';
import 'package:vendor/src/controllers/brand_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/requests/brand_delete_request.dart';

class BrandsList extends GetView<BrandController> {
  const BrandsList({Key? key}) : super(key: key);

  void bottomDialog(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return Obx(() {
          return Container(
            height: 0.7.sh,
            width: 1.sw,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            decoration: BoxDecoration(
                color: HexColor("#ffffff"),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Filter",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 22.sp,
                          letterSpacing: -0.4,
                          color: HexColor("#000000")),
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
                  ],
                ),
                InkWell(
                  onTap: () {
                    controller.search.value =
                        "?shop_id=${controller.orderController.shopId.value}&brand_category_id=${controller.brandCategoryId}";

                    controller.brand.value = [];
                    controller.getBrands();
                    Get.back();
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
                    child: controller.loading.value
                        ? SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: HexColor("ffffff"),
                            ),
                          )
                        : Text(
                            "Show result",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                                letterSpacing: -0.4,
                                color: HexColor("#ffffff")),
                          ),
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: HexColor("#ECEFF3"),
        appBar: customAppBar(
            icon: const IconData(0xea60, fontFamily: 'MIcon'),
            onClickIcon: () {
              Get.back();
            },
            title: "Brands",
            actions: [
              InkWell(
                onTap: () {
                  controller.edit.value = false;
                  Get.toNamed("/brandsAdd");
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
                        "Add",
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
              const SizedBox(
                width: 10,
              ),
              InkWell(
                child: Icon(
                  const IconData(0xf161, fontFamily: 'MIcon'),
                  color: HexColor("#000000"),
                  size: 24.sp,
                ),
                onTap: () {
                  bottomDialog(context);
                },
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                child: Icon(
                  const IconData(0xed29, fontFamily: 'MIcon'),
                  color: HexColor("#000000"),
                  size: 24.sp,
                ),
                onTap: () {
                  controller.search.value = "";
                  controller.brand.value = [];
                  controller.getBrands();
                },
              ),
            ]),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              SizedBox(
                  width: 1.sw,
                  height: 1.sh - 100,
                  child: FutureBuilder<List>(
                    future: controller.getBrands(),
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return ListView.builder(
                              itemCount: 10,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              itemBuilder: (_, index) {
                                return const BrandItemShadow();
                              });
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List? brands = snapshot.data;

                            if (brands!.isEmpty) {
                              return Container(
                                width: 1.sw - 30,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(top: 0.1.sh),
                                child: Text(
                                  "No brands",
                                  style: TextStyle(
                                      color: HexColor("#000000"),
                                      fontFamily: 'Inter',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.5),
                                ),
                              );
                            }

                            return ListView.builder(
                                itemCount: brands.length,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                itemBuilder: (_, index) {
                                  return BrandItem(
                                      name: brands[index]['name'],
                                      imageUrl: brands[index]['image_url'],
                                      shopName: brands[index]['shop'],
                                      brandCategoryName: brands[index]
                                          ['brand_category_name'],
                                      onPressEdit: () {
                                        controller.getBrandDetail(
                                            brands[index]['id']);
                                        controller.edit.value = true;
                                        Get.toNamed("/brandsAdd");
                                      },
                                      onPressDelete: () {
                                        showDialog(
                                            context: context,
                                            barrierColor: HexColor("#000000")
                                                .withOpacity(0.2),
                                            builder: (_) {
                                              return DialogError(
                                                title: "Delete brand",
                                                description:
                                                    "Do you want to delete brand #${brands[index]['id']}",
                                                onPressOk: () async {
                                                  Get.back();
                                                  await brandDeleteRequest(
                                                      brands[index]['id']);
                                                  controller.brand.value = [];
                                                  controller.getBrands();
                                                },
                                              );
                                            });
                                      },
                                      isActive: brands[index]['active'] == 1);
                                });
                          }
                      }
                    },
                  )),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );
    });
  }
}
