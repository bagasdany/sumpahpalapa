import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/components/pos_product_item.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/components/shadow/pos_product_item_shadow.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/controllers/product_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class PosSystem extends GetView<OrderController> {
  final Function() openDrawer;
  const PosSystem({Key? key, required this.openDrawer}) : super(key: key);

  void bottomDialog(BuildContext context) {
    ProductController productController = Get.put(ProductController());

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
                            "Products",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 22.sp,
                                letterSpacing: -0.4,
                                color: HexColor("#000000")),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SelectInput(
                        title: "Shops",
                        child: DropdownButton<int>(
                          underline: Container(),
                          value: controller.shopId.value,
                          isExpanded: true,
                          icon: Icon(
                            const IconData(0xea4e, fontFamily: 'MIcon'),
                            size: 28.sp,
                            color: const Color.fromRGBO(0, 0, 0, 1),
                          ),
                          items: controller.shops.map((value) {
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
                            controller.shopId.value = value!;
                            controller.getShippingBox(value);
                            controller.getShippingPlan(value);
                            controller.getShippingTransport(value);
                            productController.getActiveBrands(value);
                            productController.getActiveCategories(value);
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
                          value: productController.categoryId.value,
                          isExpanded: true,
                          icon: Icon(
                            const IconData(0xea4e, fontFamily: 'MIcon'),
                            size: 28.sp,
                            color: const Color.fromRGBO(0, 0, 0, 1),
                          ),
                          items:
                              productController.activeCategories.map((value) {
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
                            productController.categoryId.value = value!;
                            productController.categoryId.refresh();
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
                          value: productController.brandId.value,
                          isExpanded: true,
                          icon: Icon(
                            const IconData(0xea4e, fontFamily: 'MIcon'),
                            size: 28.sp,
                            color: const Color.fromRGBO(0, 0, 0, 1),
                          ),
                          items: productController.activeBrands.map((value) {
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
                            productController.brandId.value = value!;
                            productController.brandId.refresh();
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
                      productController.productDashboard.value = [];
                      productController.productDashboard.refresh();
                      productController.loadData.value = true;
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 20),
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
        });
  }

  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.put(ProductController());

    return Scaffold(
      backgroundColor: HexColor("#ECEFF3"),
      appBar: customAppBar(
          icon: const IconData(0xef3e, fontFamily: 'MIcon'),
          title: "Pos system",
          onClickIcon: () {
            openDrawer();
          },
          actions: [
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
          ]),
      body: Obx(() {
        return SingleChildScrollView(
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
                      width: 1.sw - 35,
                      height: 40,
                      child: TextField(
                        onChanged: (text) {
                          productController.productDashboard.value = [];
                          productController.productDashboard.refresh();
                          productController.searchWord.value = text;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search products",
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
                  ],
                ),
              ),
              SizedBox(
                  width: 1.sw,
                  height: 1.sh - 155,
                  child: FutureBuilder<List>(
                    future: productController.getDashboardProducts(),
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return ListView.builder(
                              itemCount: 10,
                              padding: const EdgeInsets.only(
                                  left: 15, top: 20, right: 15, bottom: 120),
                              itemBuilder: (_, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    PosProductItemShadow(),
                                    PosProductItemShadow()
                                  ],
                                );
                              });
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List? products = snapshot.data;
                            return NotificationListener(
                              child: ListView.builder(
                                  itemCount: products!.length % 2 == 0
                                      ? products.length ~/ 2
                                      : (products.length ~/ 2) + 1,
                                  padding: const EdgeInsets.only(
                                      left: 15,
                                      top: 20,
                                      right: 15,
                                      bottom: 120),
                                  itemBuilder: (_, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (index * 2 < products.length)
                                          PosProductItem(
                                            product: products[index * 2],
                                            onAdd: () {
                                              controller.addProductToCart(
                                                  products[index * 2]);
                                              controller.update();
                                            },
                                          ),
                                        if (index * 2 + 1 < products.length)
                                          PosProductItem(
                                            product: products[index * 2 + 1],
                                            onAdd: () {
                                              controller.addProductToCart(
                                                  products[index * 2 + 1]);
                                              controller.update();
                                            },
                                          )
                                      ],
                                    );
                                  }),
                              onNotification: (t) {
                                if (t is ScrollEndNotification) {}
                                return true;
                              },
                            );
                          }
                      }
                    },
                  ))
            ],
          ),
        );
      }),
      floatingActionButton: GetBuilder<OrderController>(
          builder: (orderController) => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (int i = 0; i < controller.carts.length; i++)
                    InkWell(
                      child: SizedBox(
                          height: 48,
                          width: 40,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          offset: const Offset(0, 12),
                                          color: HexColor("#16AA16")
                                              .withOpacity(0.33),
                                          blurRadius: 30,
                                          spreadRadius: 0)
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    color: controller.activeCartIndex.value == i
                                        ? HexColor("#16AA16")
                                        : HexColor("#ffffff")),
                                child: Icon(
                                  const IconData(0xf115, fontFamily: 'MIcon'),
                                  color: controller.activeCartIndex.value == i
                                      ? HexColor("#ffffff")
                                      : HexColor("#B3B3B3"),
                                  size: 20.sp,
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    child: Text(
                                      controller.carts[i]['products'].length
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          color: HexColor("#D21234")),
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              offset: const Offset(0, 12),
                                              color: HexColor("#ffffff")
                                                  .withOpacity(0.33),
                                              blurRadius: 30,
                                              spreadRadius: 0)
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        color: HexColor("#ffffff")),
                                  ))
                            ],
                          )),
                      onTap: () {
                        controller.activeCartIndex.value = i;
                        Get.toNamed("/cartDetail");
                        controller.update();
                      },
                    ),
                  InkWell(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                offset: const Offset(0, 12),
                                color: HexColor("#16AA16").withOpacity(0.33),
                                blurRadius: 30,
                                spreadRadius: 0)
                          ],
                          borderRadius: BorderRadius.circular(20),
                          color: HexColor("#16AA16")),
                      child: Icon(
                        const IconData(0xea13, fontFamily: 'MIcon'),
                        color: HexColor("#ffffff"),
                        size: 20.sp,
                      ),
                    ),
                    onTap: () {
                      controller.addNewCart();
                    },
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
