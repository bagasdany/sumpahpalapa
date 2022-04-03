import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/shadow/shop_item_shadow.dart';
import 'package:vendor/src/components/shop_item.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class Shops extends GetView<OrderController> {
  const Shops({Key? key}) : super(key: key);

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
          title: "Shops",
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              SizedBox(
                  width: 1.sw,
                  height: 1.sh - 100,
                  child: FutureBuilder<List>(
                    future: controller.getAllShops(),
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return ListView.builder(
                              itemCount: 10,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              itemBuilder: (_, index) {
                                return const ShopItemShadow();
                              });
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List? shops = snapshot.data;
                            return ListView.builder(
                                itemCount: shops!.length,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                itemBuilder: (_, index) {
                                  return ShopItem(
                                    backimage: shops[index]['back_image'],
                                    logo: shops[index]['logo'],
                                    onEdit: () {
                                      controller.shopController
                                          .getShopById(shops[index]['id']);
                                      controller.shopController
                                          .getShopDeliveriesList(
                                              shops[index]['id']);
                                      controller.shopController
                                          .getShopTransportList(
                                              shops[index]['id']);
                                      controller.shopController
                                          .getShopPayments(shops[index]['id']);
                                      controller.shopController
                                          .getShopBoxList(shops[index]['id']);
                                      controller.edit.value = true;
                                      controller.shopTabIndex.value = 0;
                                      Get.toNamed("/shopsAdd");
                                    },
                                    onDelete: () {},
                                    shopName: shops[index]['name'],
                                    isActive: shops[index]['active'] == 1,
                                    deliveryRange: shops[index]
                                        ['delivery_range'],
                                  );
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
