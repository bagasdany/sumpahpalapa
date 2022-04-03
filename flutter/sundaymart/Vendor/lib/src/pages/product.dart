import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/components/dialog_error.dart';
import 'package:vendor/src/components/product_item.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/components/shadow/product_item_shadow.dart';
import 'package:vendor/src/controllers/product_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:vendor/src/requests/product_delete_request.dart';

class Products extends GetView<ProductController> {
  final Function() openDrawer;

  const Products({Key? key, required this.openDrawer}) : super(key: key);

  void bottomDialog(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return Obx(() {
          return Container(
            width: 1.sw,
            height: 0.8.sh,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        InkWell(
                          child: Text(
                            "Clear all",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                                letterSpacing: -0.4,
                                color: HexColor("#D21234")),
                          ),
                          onTap: () {
                            controller.searchText.value = "";
                            controller.products.clear();
                            controller.loadData.value = true;
                            controller.getProducts();
                            Get.back();
                          },
                        )
                      ],
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
                          controller.getActiveBrands(value);
                          controller.getActiveCategories(value);
                        },
                      ),
                      width: 1.sw - 30,
                    ),
                    const SizedBox(
                      height: 40,
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
                      height: 40,
                    ),
                    SelectInput(
                      title: "Brands",
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
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    controller.searchText.value =
                        "?shop_id=${controller.orderController.shopId.value}&brand_id=${controller.brandId.value}";

                    controller.products.value = [];
                    controller.loadData.value = true;
                    controller.getProducts();
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
              icon: const IconData(0xef3e, fontFamily: 'MIcon'),
              onClickIcon: openDrawer,
              title: "Products",
              actions: [
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
                          "Add product",
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
                    controller.tabIndex.value = 0;
                    controller.edit.value = false;
                    Get.toNamed("/productAdd");
                  },
                )
              ]),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 55,
                  width: 1.sw,
                  padding: const EdgeInsets.only(left: 20, right: 15),
                  decoration: BoxDecoration(color: HexColor("#FFFFFF")),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 0.8.sw,
                        height: 40,
                        child: TextField(
                          onChanged: (text) {
                            controller.loadData.value = true;
                            controller.searchText.value = "&search=$text";
                            controller.products.value = [];
                            controller.getProducts();
                          },
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(bottom: 0, top: 5),
                              border: InputBorder.none,
                              hintText: "Search stores",
                              hintStyle: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(0, 0, 0, 0.3),
                                  fontSize: 14.sp,
                                  letterSpacing: -0.5),
                              prefixIcon: Icon(
                                const IconData(0xf0d1, fontFamily: 'MIcon'),
                                size: 24.sp,
                                color: const Color.fromRGBO(0, 0, 0, 0.3),
                              )),
                        ),
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
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 1.sw,
                  height: 1.sh - 155,
                  child: NotificationListener(
                      onNotification: (t) {
                        if (t is ScrollEndNotification) {
                          if (t.metrics.atEdge &&
                              controller.scrollController.position.pixels > 0) {
                            controller.loadData.value = true;
                            controller.getProducts();
                          }
                        }
                        return false;
                      },
                      child: ListView.builder(
                          itemCount: controller.loadData.value &&
                                  controller.products.length % 10 == 0
                              ? controller.products.length + 10
                              : controller.products.length,
                          controller: controller.scrollController,
                          padding: const EdgeInsets.only(
                              left: 15, top: 20, right: 15, bottom: 120),
                          itemBuilder: (_, index) {
                            if (index > controller.products.length - 1) {
                              return const ProductItemShadow();
                            }

                            return ProductItem(
                              id: controller.products[index]["id"],
                              name: controller.products[index]["name"],
                              image: controller.products[index]["image_url"],
                              price: double.parse(
                                  "${controller.products[index]["price"]}"),
                              onDelete: (id) {
                                showDialog(
                                    context: context,
                                    barrierColor:
                                        HexColor("#000000").withOpacity(0.2),
                                    builder: (_) {
                                      return DialogError(
                                        title: "Delete product",
                                        description:
                                            "Do you want to delete product #${controller.products[index]['id']}",
                                        onPressOk: () async {
                                          Get.back();
                                          await productDeleteRequest(
                                              controller.products[index]['id']);
                                          controller.products.value = [];
                                          controller.loadData.value = true;
                                          controller.getProducts();
                                        },
                                      );
                                    });
                              },
                              onEdit: (id) {
                                controller.tabIndex.value = 0;
                                controller.edit.value = true;
                                controller.getProductDetail(id);
                                Get.toNamed("/productAdd");
                              },
                            );
                          })),
                ),
              ],
            ),
          ));
    });
  }
}
