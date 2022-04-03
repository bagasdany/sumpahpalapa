import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/client_info_bottom_modal.dart';
import 'package:vendor/src/components/delivery_info_bottom_modal.dart';
import 'package:vendor/src/components/order_add_item.dart';
import 'package:vendor/src/components/order_detail_info_bottom_modal.dart';
import 'package:vendor/src/components/order_info_bottom_modal.dart';
import 'package:vendor/src/components/shop_info_bottom_modal.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class OrderAdd extends GetView<OrderController> {
  const OrderAdd({Key? key}) : super(key: key);

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
              title: controller.edit.value
                  ? "Order — #${controller.activeOrder['id']}"
                  : "Order Add"),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              children: <Widget>[
                OrderAddItem(
                  title: "Client info",
                  onPress: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        return DraggableScrollableSheet(
                          expand: false,
                          builder: (_, scrollController) {
                            return const ClientInfoBottomModal();
                          },
                        );
                      },
                    );
                  },
                ),
                OrderAddItem(
                  title: "Shop info",
                  onPress: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        return DraggableScrollableSheet(
                          expand: false,
                          builder: (_, scrollController) {
                            return const ShopInfoBottomModal();
                          },
                        );
                      },
                    );
                  },
                ),
                OrderAddItem(
                  title: "Order info",
                  onPress: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        return DraggableScrollableSheet(
                          expand: true,
                          builder: (_, scrollController) {
                            return OrderInfoBottomModal(
                              scrollController: scrollController,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                OrderAddItem(
                  title: "Delivery info",
                  onPress: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        return DraggableScrollableSheet(
                          expand: false,
                          builder: (_, controller) {
                            return DeliveryInfoBottomModal(
                                scrollController: controller);
                          },
                        );
                      },
                    );
                  },
                ),
                OrderAddItem(
                  title: "Order detail info",
                  onPress: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        return DraggableScrollableSheet(
                          expand: true,
                          builder: (_, controller) {
                            return OrderDetailInfoBottomModal(
                              scrollController: controller,
                            );
                          },
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
          extendBody: true,
          bottomNavigationBar: InkWell(
            onTap: () {
              controller.orderSave();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              width: 1.sw - 30,
              height: 60,
              decoration: BoxDecoration(
                  color: controller.productList.isNotEmpty
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
