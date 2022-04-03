import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/brand_category_item.dart';
import 'package:vendor/src/components/dialog_error.dart';
import 'package:vendor/src/components/shadow/brand_Category_item_shadow.dart';
import 'package:vendor/src/controllers/brand_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/requests/brand_category_delete_request.dart';

class BrandsCategory extends GetView<BrandController> {
  const BrandsCategory({Key? key}) : super(key: key);

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
            title: "Brands categories",
            actions: [
              InkWell(
                onTap: () {
                  controller.edit.value = false;
                  Get.toNamed("/brandsCategoryAdd");
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
            ]),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              SizedBox(
                  width: 1.sw,
                  height: 1.sh - 100,
                  child: FutureBuilder<List>(
                    future: controller.getBrandCategories(),
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return ListView.builder(
                              itemCount: 10,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              itemBuilder: (_, index) {
                                return const BrandCategoryItemShadow();
                              });
                        default:
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          else {
                            List? brandCategories = snapshot.data;
                            return ListView.builder(
                                itemCount: brandCategories!.length,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                itemBuilder: (_, index) {
                                  return BrandCategoryItem(
                                      name: brandCategories[index]['name'],
                                      onPressEdit: () {
                                        controller.getBrandCategoryDetail(
                                            brandCategories[index]['id']);
                                        controller.edit.value = true;
                                        Get.toNamed("/brandsCategoryAdd");
                                      },
                                      onPressDelete: () {
                                        showDialog(
                                            context: context,
                                            barrierColor: HexColor("#000000")
                                                .withOpacity(0.2),
                                            builder: (_) {
                                              return DialogError(
                                                title: "Delete brand category",
                                                description:
                                                    "Do you want to delete brand category #${brandCategories[index]['id']}",
                                                onPressOk: () async {
                                                  Get.back();
                                                  await brandCategoryDeleteRequest(
                                                      brandCategories[index]
                                                          ['id']);
                                                  controller.brandCategories
                                                      .value = [];
                                                  controller
                                                      .getBrandCategories();
                                                },
                                              );
                                            });
                                      },
                                      isActive: brandCategories[index]
                                              ['active'] ==
                                          1);
                                });
                          }
                      }
                    },
                  ))
            ],
          ),
        ),
      );
    });
  }
}
