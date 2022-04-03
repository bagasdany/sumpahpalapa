import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/components/order_item.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/components/shadow/order_item_shadow.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class Orders extends StatefulWidget {
  final Function() openDrawer;
  const Orders({Key? key, required this.openDrawer}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> with SingleTickerProviderStateMixin {
  TabController? tabController;
  OrderController orderController = Get.put(OrderController());
  int tabIndex = 0;
  int status = 1;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    orderController.loadData.value = true;
    orderController.orders.value = [];
    orderController.getOrders(status);
    orderController.orderTabIndex.value = 0;
  }

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
                            orderController.search.value = "";
                            orderController.orders.clear();
                            orderController.loadData.value = true;
                            orderController.getOrders(status);
                            Get.back();
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SelectInput(
                      title: "Shops",
                      child: DropdownButton<int>(
                        underline: Container(),
                        value: orderController.shopId.value,
                        isExpanded: true,
                        icon: Icon(
                          const IconData(0xea4e, fontFamily: 'MIcon'),
                          size: 28.sp,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                        items: orderController.shops.map((value) {
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
                          orderController.shopId.value = value!;
                        },
                      ),
                      width: 1.sw - 30,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    orderController.search.value =
                        "?shop_id=${orderController.shopId.value}";
                    orderController.orders.clear();
                    orderController.loadData.value = true;
                    orderController.getOrders(status);
                    orderController.shopId.value =
                        orderController.shops[0]["id"];
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
                    child: orderController.loading.value
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
            onClickIcon: widget.openDrawer,
            title: "Orders",
            actions: [
              InkWell(
                onTap: () {
                  orderController.edit.value = false;
                  Get.toNamed("/orderAdd");
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
                        "Add order",
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
                width: 20,
              ),
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
        body: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                width: 1.sw,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                color: HexColor("#ffffff"),
                child: TabBar(
                    controller: tabController,
                    labelPadding: EdgeInsets.zero,
                    labelColor: HexColor("#000000"),
                    unselectedLabelColor: HexColor("#7C7C7C"),
                    indicatorColor: HexColor("#16AA16"),
                    indicatorWeight: 2,
                    indicatorSize: TabBarIndicatorSize.label,
                    onTap: (index) {
                      setState(() {
                        tabIndex = index;
                        if (index == 0) {
                          status = 1;
                          orderController.orderTabIndex.value = 1;
                        } else if (index == 1) {
                          status = 2;
                          orderController.orderTabIndex.value = 2;
                        } else if (index == 2) {
                          status = 4;
                          orderController.orderTabIndex.value = 4;
                        } else {
                          status = 5;
                          orderController.orderTabIndex.value = 5;
                        }
                        orderController.loadData.value = true;
                        orderController.orders.value = [];
                        orderController.getOrders(status);
                      });
                    },
                    unselectedLabelStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        letterSpacing: -0.5),
                    labelStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        letterSpacing: -0.5),
                    tabs: [
                      Tab(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "New",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  letterSpacing: -0.5),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: HexColor("#16AA16"),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "${orderController.newOrdersCount}",
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: HexColor("#ffffff"),
                                    letterSpacing: -0.5),
                              ),
                            )
                          ],
                        ),
                      ),
                      const Tab(text: "Open"),
                      const Tab(text: "Completed"),
                      const Tab(text: "Cancelled")
                    ]),
              ),
              SizedBox(
                  width: 1.sw,
                  height: 1.sh - 230,
                  child: NotificationListener(
                    child: ListView.builder(
                        controller: orderController.orderScrollController,
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        itemCount: orderController.loadData.value &&
                                orderController.orders.length % 10 == 0
                            ? orderController.orders.length + 10
                            : orderController.orders.length,
                        itemBuilder: (_, index) {
                          if (index > orderController.orders.length - 1) {
                            return const OrderItemShadow();
                          }

                          return InkWell(
                            child: OrderItem(
                              orderDate: orderController.orders[index]
                                  ['order_date'],
                              shop: orderController.orders[index]['shop'],
                              totalSum: double.parse(
                                  "${orderController.orders[index]['amount']}"),
                              orderId: orderController.orders[index]['id'],
                            ),
                            onTap: () {
                              orderController.setActiveOrder(
                                  orderController.orders[index]);
                              Get.toNamed("/orderDetail");
                            },
                          );
                        }),
                    onNotification: (t) {
                      if (t is ScrollEndNotification) {
                        if (t.metrics.atEdge &&
                            orderController
                                    .orderScrollController.position.pixels >
                                0) {
                          orderController.loadData.value = true;
                          orderController.getOrders(status);
                        }
                      }

                      return true;
                    },
                  ))
            ],
          ),
        ),
      );
    });
  }
}
