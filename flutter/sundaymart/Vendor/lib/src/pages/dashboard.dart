import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/dashboard_item.dart';
import 'package:vendor/src/components/shadow.dart';
import 'package:vendor/src/components/total_panel.dart';
import 'package:vendor/src/controllers/admin_controller.dart';
import 'package:vendor/src/controllers/dashboard_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Dashboard extends GetView<DashboardController> {
  final Function() openDrawer;
  final Function(int) changeTab;
  const Dashboard({Key? key, required this.openDrawer, required this.changeTab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: HexColor("#ECEFF3"),
        appBar: customAppBar(
            icon: const IconData(0xef3e, fontFamily: 'MIcon'),
            onClickIcon: openDrawer,
            title: "Dashboard",
            actions: [
              // Icon(
              //   const IconData(0xef91, fontFamily: 'MIcon'),
              //   color: const Color.fromRGBO(46, 52, 86, 0.3),
              //   size: 24.sp,
              // )
            ]),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 0.7.sw - 40,
                    height: 0.3.sw,
                    child: CustomPaint(
                      painter: TotalPanel(),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 54,
                              margin: const EdgeInsets.only(right: 10),
                              height: 54,
                              decoration: BoxDecoration(
                                  color: HexColor("#ffffff").withOpacity(0.28),
                                  borderRadius: BorderRadius.circular(27)),
                              child: Icon(
                                const IconData(0xef64, fontFamily: 'MIcon'),
                                color: HexColor("#ffffff"),
                                size: 32.sp,
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Balance",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      color: HexColor("#ffffff"),
                                      fontSize: 13.sp,
                                      letterSpacing: -0.5),
                                ),
                                Text(
                                  "${controller.totalSum.value}",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#ffffff"),
                                      fontSize: 20.sp,
                                      height: 1.2,
                                      letterSpacing: -0.5),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.3.sw,
                    width: 0.3.sw,
                    child: CustomPaint(
                        painter: CustomBoxShadow(),
                        child: Container(
                          height: 0.3.sw,
                          padding: const EdgeInsets.only(left: 15, bottom: 20),
                          width: 0.3.sw,
                          alignment: Alignment.bottomLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: HexColor("#1A1D2E")),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                const IconData(0xf18e, fontFamily: 'MIcon'),
                                color: HexColor("#FFC12D"),
                                size: 18.sp,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: "${controller.star.value}",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w700,
                                          color: HexColor("#ffffff"),
                                          fontSize: 16.sp,
                                          height: 1.2,
                                          letterSpacing: -0.5),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: '\nRating',
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            color: HexColor("#ffffff"),
                                            fontSize: 16.sp,
                                            height: 1.2,
                                            letterSpacing: -0.5))
                                  ]))
                            ],
                          ),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: DashboardItem(
                      icon: const IconData(0xf25b, fontFamily: 'MIcon'),
                      title: "Clients",
                      color: HexColor("#F26110"),
                      amount: controller.clientTotal.value,
                    ),
                    onTap: () {
                      AdminController adminController =
                          Get.put(AdminController());
                      adminController.loadData.value = true;
                      adminController.getClients();
                      Get.toNamed("/clients");
                    },
                  ),
                  InkWell(
                      child: DashboardItem(
                        icon: const IconData(0xf1a6, fontFamily: 'MIcon'),
                        title: "Shops",
                        color: HexColor("#C26BF9"),
                        amount: controller.shopTotal.value,
                      ),
                      onTap: () {
                        Get.toNamed("/shops");
                      })
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: DashboardItem(
                      icon: const IconData(0xea41, fontFamily: 'MIcon'),
                      title: "Products",
                      color: HexColor("#52A0F5"),
                      amount: controller.productTotal.value,
                    ),
                    onTap: () {
                      changeTab(2);
                    },
                  ),
                  InkWell(
                    child: DashboardItem(
                      icon: const IconData(0xf11d, fontFamily: 'MIcon'),
                      title: "Orders",
                      color: HexColor("#60CC3B"),
                      amount: controller.orderTotal.value,
                    ),
                    onTap: () {
                      changeTab(0);
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: DashboardItem(
                      icon: const IconData(0xea95, fontFamily: 'MIcon'),
                      title: "Sold out products",
                      color: HexColor("#F34750"),
                      amount: controller.productSold.value,
                    ),
                    onTap: () {
                      changeTab(2);
                    },
                  ),
                  InkWell(
                    child: DashboardItem(
                      icon: const IconData(0xf273, fontFamily: 'MIcon'),
                      title: "Active clients",
                      color: HexColor("#FFB800"),
                      amount: controller.clientActive.value,
                    ),
                    onTap: () {
                      AdminController adminController =
                          Get.put(AdminController());
                      adminController.loadData.value = true;
                      adminController.getClients();
                      Get.toNamed("/clients");
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 120,
              )
            ],
          ),
        ),
      );
    });
  }
}
