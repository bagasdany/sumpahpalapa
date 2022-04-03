import 'package:deliveryboy/src/components/empty.dart';
import 'package:deliveryboy/src/components/order_item.dart';
import 'package:deliveryboy/src/components/shadows/order_item_shadow.dart';
import 'package:deliveryboy/src/components/switch_button.dart';
import 'package:deliveryboy/src/controllers/order_controller.dart';
import 'package:deliveryboy/src/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  OrdersState createState() => OrdersState();
}

class OrdersState extends State<Orders> with TickerProviderStateMixin {
  TabController? tabController;
  int tabIndex = 0;
  int tabIndexStorage = 0;
  SettingsController settingsController = Get.put(SettingsController());
  OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var appBarHeight = AppBar().preferredSize.height + 10;

    return Obx(() {
      return Scaffold(
        backgroundColor: Get.isDarkMode
            ? const Color.fromRGBO(19, 20, 21, 1)
            : const Color.fromRGBO(243, 243, 240, 1),
        appBar: PreferredSize(
            preferredSize: Size(1.sw, statusBarHeight + appBarHeight),
            child: Container(
                width: 1.sw,
                height: statusBarHeight + appBarHeight,
                decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          offset: const Offset(0, 2),
                          blurRadius: 2,
                          spreadRadius: 0,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(23, 27, 32, 0.13)
                              : const Color.fromRGBO(169, 169, 150, 0.13))
                    ],
                    color: Get.isDarkMode
                        ? const Color.fromRGBO(37, 48, 63, 1)
                        : const Color.fromRGBO(255, 255, 255, 1)),
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: statusBarHeight),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SwitchButton(
                      value: settingsController.isOnline.value,
                      onChanged: (val) => settingsController.makeOnline(val),
                      inactiveText: "Offline",
                      activeText: "Online",
                    ),
                    InkWell(
                      child: Container(
                        width: appBarHeight - 30,
                        height: appBarHeight - 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(19, 20, 21, 1)
                                : const Color.fromRGBO(243, 243, 243, 1)),
                        child: Icon(
                          const IconData(0xf064, fontFamily: 'MIcon'),
                          size: 20.sp,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(255, 255, 255, 1)
                              : const Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          tabIndexStorage =
                              tabIndexStorage != tabIndex ? tabIndex : 0;
                        });
                      },
                    )
                  ],
                ))),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (settingsController.isOnline.value)
                Container(
                  width: 1.sw,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? const Color.fromRGBO(26, 34, 44, 1)
                          : const Color.fromRGBO(249, 249, 246, 1)),
                  child: TabBar(
                      controller: tabController,
                      indicatorColor: const Color.fromRGBO(69, 165, 36, 1),
                      indicatorWeight: 2,
                      isScrollable: true,
                      labelColor: Get.isDarkMode
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(0, 0, 0, 1),
                      unselectedLabelColor: Get.isDarkMode
                          ? const Color.fromRGBO(130, 139, 150, 1)
                          : const Color.fromRGBO(136, 136, 126, 1),
                      labelStyle: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        letterSpacing: -0.4,
                      ),
                      onTap: (index) {
                        setState(() {
                          tabIndex = index;
                        });
                      },
                      tabs: [
                        Tab(
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: const Text(
                              "On a way",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Tab(
                          child: Stack(
                            children: [
                              Positioned(
                                child: Container(
                                  height: 40,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "New",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 5,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 2,
                                            color: const Color.fromRGBO(
                                                255, 184, 0, 1))),
                                  ))
                            ],
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: const Text(
                              "Accepted",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: const Text(
                              "Delivered",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            child: const Text(
                              "Canceled",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ]),
                ),
              if (settingsController.isOnline.value)
                SizedBox(
                    width: 1.sw,
                    height: 1.sh - 60 - statusBarHeight - appBarHeight,
                    child: [
                      tabIndex == 0
                          ? FutureBuilder<List>(
                              future: orderController.getOrders(3),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.connectionState ==
                                        ConnectionState.done) {
                                  List data = snapshot.data!;

                                  return data.isEmpty
                                      ? Empty(message: "No orders".tr)
                                      : ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 15),
                                          itemCount: data.length,
                                          itemBuilder: (_, index) {
                                            return OrderItem(
                                              data: data[index],
                                              onChangeStatus: () {
                                                setState(() {
                                                  tabIndexStorage =
                                                      tabIndexStorage !=
                                                              tabIndex
                                                          ? tabIndex
                                                          : 0;
                                                });
                                              },
                                            );
                                          });
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }

                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 15),
                                    itemCount: 4,
                                    itemBuilder: (_, index) {
                                      return const OrderItemShadow();
                                    });
                              },
                            )
                          : Container(),
                      tabIndex == 1
                          ? FutureBuilder<List>(
                              future: orderController.getOrders(1),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.connectionState ==
                                        ConnectionState.done) {
                                  List data = snapshot.data!;

                                  return data.isEmpty
                                      ? Empty(message: "No orders".tr)
                                      : ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 15),
                                          itemCount: data.length,
                                          itemBuilder: (_, index) {
                                            return OrderItem(
                                              data: data[index],
                                              onChangeStatus: () {
                                                setState(() {
                                                  tabIndexStorage =
                                                      tabIndexStorage !=
                                                              tabIndex
                                                          ? tabIndex
                                                          : 0;
                                                });
                                              },
                                            );
                                          });
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }

                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 15),
                                    itemCount: 4,
                                    itemBuilder: (_, index) {
                                      return const OrderItemShadow();
                                    });
                              },
                            )
                          : Container(),
                      tabIndex == 2
                          ? FutureBuilder<List>(
                              future: orderController.getOrders(2),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.connectionState ==
                                        ConnectionState.done) {
                                  List data = snapshot.data!;

                                  return data.isEmpty
                                      ? Empty(message: "No orders".tr)
                                      : ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 15),
                                          itemCount: data.length,
                                          itemBuilder: (_, index) {
                                            return OrderItem(
                                              data: data[index],
                                              onChangeStatus: () {
                                                setState(() {
                                                  tabIndexStorage =
                                                      tabIndexStorage !=
                                                              tabIndex
                                                          ? tabIndex
                                                          : 0;
                                                });
                                              },
                                            );
                                          });
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }

                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 15),
                                    itemCount: 4,
                                    itemBuilder: (_, index) {
                                      return const OrderItemShadow();
                                    });
                              },
                            )
                          : Container(),
                      tabIndex == 3
                          ? FutureBuilder<List>(
                              future: orderController.getOrders(4),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.connectionState ==
                                        ConnectionState.done) {
                                  List data = snapshot.data!;

                                  return data.isEmpty
                                      ? Empty(message: "No orders".tr)
                                      : ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 15),
                                          itemCount: data.length,
                                          itemBuilder: (_, index) {
                                            return OrderItem(
                                              data: data[index],
                                              onChangeStatus: () {
                                                setState(() {
                                                  tabIndexStorage =
                                                      tabIndexStorage !=
                                                              tabIndex
                                                          ? tabIndex
                                                          : 0;
                                                });
                                              },
                                            );
                                          });
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }

                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 15),
                                    itemCount: 4,
                                    itemBuilder: (_, index) {
                                      return const OrderItemShadow();
                                    });
                              },
                            )
                          : Container(),
                      tabIndex == 4
                          ? FutureBuilder<List>(
                              future: orderController.getOrders(5),
                              builder: (context, snapshot) {
                                if (snapshot.hasData &&
                                    snapshot.connectionState ==
                                        ConnectionState.done) {
                                  List data = snapshot.data!;

                                  return data.isEmpty
                                      ? Empty(message: "No orders".tr)
                                      : ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 15),
                                          itemCount: data.length,
                                          itemBuilder: (_, index) {
                                            return OrderItem(
                                              data: data[index],
                                              onChangeStatus: () {
                                                setState(() {
                                                  tabIndexStorage =
                                                      tabIndexStorage !=
                                                              tabIndex
                                                          ? tabIndex
                                                          : 0;
                                                });
                                              },
                                            );
                                          });
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }

                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 15),
                                    itemCount: 4,
                                    itemBuilder: (_, index) {
                                      return const OrderItemShadow();
                                    });
                              },
                            )
                          : Container()
                    ][tabIndex]),
              if (!settingsController.isOnline.value)
                const Empty(message: "You are offline")
            ],
          ),
        ),
      );
    });
  }
}
