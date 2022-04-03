import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/delivery_boy_data_item.dart';
import 'package:vendor/src/components/delivery_boy_order_item.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/components/shadow/delivery_boy_box_shadow.dart';
import 'package:vendor/src/components/shadow/delivery_boy_order_item_shadow.dart';
import 'package:vendor/src/controllers/admin_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryBoyOrderList extends GetView<AdminController> {
  const DeliveryBoyOrderList({Key? key}) : super(key: key);

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
                            controller.orderController.search.value = "";
                            controller.orderController.orderStatusId.value = 1;
                            controller.orderController.orders.clear();
                            controller.orderController.loadData.value = true;
                            controller.orderController.getOrders(0);
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
                        },
                      ),
                      width: 1.sw - 30,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SelectInput(
                      title: "Order status",
                      child: DropdownButton<int>(
                        underline: Container(),
                        value: controller.orderController.orderStatusId.value,
                        isExpanded: true,
                        icon: Icon(
                          const IconData(0xea4e, fontFamily: 'MIcon'),
                          size: 28.sp,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                        items: controller.orderController.orderStatuses
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
                          controller.orderController.orderStatusId.value =
                              value!;
                        },
                      ),
                      width: 1.sw - 30,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    controller.orderController.search.value =
                        "?shop_id=${controller.orderController.shopId.value}";
                    controller.orderController.orders.clear();
                    controller.orderController.loadData.value = true;
                    controller.orderController.getOrders(
                        controller.orderController.orderStatusId.value);
                    controller.orderController.shopId.value =
                        controller.orderController.shops[0]["id"];
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
                    child: controller.orderController.loading.value
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
            title: "Delivery boy order lists",
            actions: [
              if (controller.tabIndex.value == 0)
                InkWell(
                  onTap: () {
                    bottomDialog(context);
                  },
                  child: Icon(
                    const IconData(0xf161, fontFamily: 'MIcon'),
                    color: HexColor("#000000"),
                    size: 24.sp,
                  ),
                )
            ]),
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
                            text: "Orders",
                          ),
                          Tab(
                            text: "Delivery boy statuses",
                          ),
                        ]),
                  )),
              Container(
                child: [
                  SizedBox(
                      width: 1.sw,
                      height: 1.sh - 130,
                      child: FutureBuilder<List>(
                        future: controller.orderController.getOrders(0),
                        builder: (BuildContext context,
                            AsyncSnapshot<List> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return ListView.builder(
                                  itemCount: 10,
                                  padding: const EdgeInsets.only(
                                      left: 15,
                                      top: 20,
                                      right: 15,
                                      bottom: 120),
                                  itemBuilder: (_, index) {
                                    return const DeliveryBoyOrderItemShadow();
                                  });
                            default:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                List? orders = snapshot.data;
                                return ListView.builder(
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 15,
                                        bottom: 120),
                                    itemCount: orders!.length,
                                    itemBuilder: (_, index) {
                                      return DeliveryBoyOrderItem(
                                        orderDate: orders[index]['order_date'],
                                        status: orders[index]
                                            ['order_status_id'],
                                        statusName: orders[index]
                                            ['order_status'],
                                        onEdit: () {
                                          controller.orderController
                                              .getInfoById(orders[index]['id']);
                                          controller.orderController.orderId
                                              .value = orders[index]['id'];
                                          controller.orderController.orderId
                                              .refresh();
                                          controller.orderController.activeOrder
                                              .value = orders[index];
                                          controller.orderController.edit
                                              .value = true;
                                          Get.toNamed("/orderAdd");
                                        },
                                        deliveryBoy: orders[index]
                                            ['delivery_boy'],
                                        totalSum: double.parse(
                                            "${orders[index]['amount']}"),
                                        orderId: orders[index]['id'],
                                      );
                                    });
                              }
                          }
                        },
                      )),
                  SizedBox(
                      width: 1.sw,
                      height: 1.sh - 130,
                      child: FutureBuilder<List>(
                        future: controller.getDeliveryBoys(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return ListView.builder(
                                  itemCount: 10,
                                  padding: const EdgeInsets.only(
                                      left: 15,
                                      top: 20,
                                      right: 15,
                                      bottom: 120),
                                  itemBuilder: (_, index) {
                                    return const DeliveryBoyOrderItemShadow();
                                  });
                            default:
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                List? orders = snapshot.data;
                                return ListView.builder(
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        top: 15,
                                        bottom: 120),
                                    itemCount: orders!.length,
                                    itemBuilder: (_, index) {
                                      return DeliveryBoyDataItem(
                                        onEdit: () {
                                          Get.toNamed("/deliveryBoyEdit");
                                        },
                                        deliveryBoy:
                                            "${orders[index]['name']} ${orders[index]['surname']}",
                                        delivered: orders[index]['orders_count']
                                                        .length >
                                                    0 &&
                                                orders[index]['orders_count']
                                                        ['delivered'] !=
                                                    null
                                            ? int.parse(orders[index]
                                                        ['orders_count']
                                                    ['delivered']
                                                .toString())
                                            : 0,
                                        canceled: orders[index]['orders_count']
                                                        .length >
                                                    0 &&
                                                orders[index]['orders_count']
                                                        ['canceled'] !=
                                                    null
                                            ? int.parse(orders[index]
                                                    ['orders_count']['canceled']
                                                .toString())
                                            : 0,
                                        ready: orders[index]['orders_count']
                                                        .length >
                                                    0 &&
                                                orders[index]['orders_count']
                                                        ['ready_to_delivery'] !=
                                                    null
                                            ? int.parse(orders[index]
                                                        ['orders_count']
                                                    ['ready_to_delivery']
                                                .toString())
                                            : 0,
                                        inaway: orders[index]['orders_count']
                                                        .length >
                                                    0 &&
                                                orders[index]['orders_count']
                                                        ['in_a_way'] !=
                                                    null
                                            ? int.parse(orders[index]
                                                    ['orders_count']['in_a_way']
                                                .toString())
                                            : 0,
                                        accepted: orders[index]['orders_count']
                                                        .length >
                                                    0 &&
                                                orders[index]['orders_count']
                                                        ['accepted'] !=
                                                    null
                                            ? int.parse(orders[index]
                                                    ['orders_count']['accepted']
                                                .toString())
                                            : 0,
                                      );
                                    });
                              }
                          }
                        },
                      )),
                ][controller.tabIndex.value],
              )
            ],
          ),
        ),
      );
    });
  }
}
