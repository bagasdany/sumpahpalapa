import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:deliveryboy/config/global_config.dart';
import 'package:deliveryboy/src/components/home_tab_button.dart';
import 'package:deliveryboy/src/controllers/auth_controller.dart';
import 'package:deliveryboy/src/controllers/chat_controller.dart';
import 'package:deliveryboy/src/controllers/order_controller.dart';
import 'package:deliveryboy/src/pages/orders.dart';
import 'package:deliveryboy/src/pages/statistics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  TabController? _tabController;
  int tabIndex = 0;
  AuthController authController = Get.put(AuthController());
  OrderController orderController = Get.put(OrderController());
  ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  Widget buildPage() {
    if (tabIndex == 0) {
      return const Orders();
    } else {
      return const Statistics();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? const Color.fromRGBO(19, 20, 21, 1)
          : const Color.fromRGBO(243, 243, 240, 1),
      body: buildPage(),
      extendBody: true,
      bottomNavigationBar: Container(
        height: 80,
        width: 1.sw,
        decoration: BoxDecoration(
            color: Get.isDarkMode
                ? const Color.fromRGBO(37, 48, 63, 0.7)
                : const Color.fromRGBO(255, 255, 255, 0.7)),
        alignment: Alignment.topCenter,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              height: 80,
              width: 1.sw,
              padding: const EdgeInsets.only(
                  top: 18, bottom: 20, left: 28, right: 33),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 0.66.sw,
                    height: 60,
                    child: TabBar(
                        indicatorColor: Colors.transparent,
                        controller: _tabController,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelPadding: const EdgeInsets.all(0),
                        onTap: (index) {},
                        tabs: [
                          Tab(
                            child: HomeTabButton(
                              title: "Orders".tr,
                              icon: tabIndex == 0
                                  ? const IconData(0xecec, fontFamily: 'MIcon')
                                  : const IconData(0xeced, fontFamily: 'MIcon'),
                              isActive: tabIndex == 0,
                              onTap: () {
                                setState(() {
                                  tabIndex = 0;
                                });
                              },
                            ),
                          ),
                          Tab(
                            child: HomeTabButton(
                              title: "Statistics".tr,
                              icon: tabIndex == 1
                                  ? const IconData(0xea99, fontFamily: 'MIcon')
                                  : const IconData(0xea9e, fontFamily: 'MIcon'),
                              isActive: tabIndex == 1,
                              onTap: () {
                                setState(() {
                                  tabIndex = 1;
                                });
                              },
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 3,
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(130, 139, 150, 0.1)
                                : const Color.fromRGBO(136, 136, 126, 0.1)),
                        borderRadius: BorderRadius.circular(20)),
                    child: InkWell(
                        onTap: () => Get.toNamed("/profile"),
                        child: authController.user.value != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.fill,
                                  imageUrl:
                                      "$globalImageUrl${authController.user.value!.imageUrl}",
                                  placeholder: (context, url) => Container(
                                    width: 40,
                                    height: 40,
                                    alignment: Alignment.center,
                                    child: Icon(
                                      const IconData(0xee4b,
                                          fontFamily: 'MIcon'),
                                      color: const Color.fromRGBO(
                                          233, 233, 230, 1),
                                      size: 20.sp,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ))
                            : Icon(
                                const IconData(0xf25c, fontFamily: 'MIcon'),
                                color: Get.isDarkMode
                                    ? const Color.fromRGBO(255, 255, 255, 1)
                                    : const Color.fromRGBO(0, 0, 0, 1),
                                size: 20,
                              )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: tabIndex == 0
          ? SizedBox(
              height: 50,
              width: 50,
              child: Stack(
                children: <Widget>[
                  InkWell(
                    child: Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(37, 48, 63, 1)
                              : const Color.fromRGBO(0, 0, 0, 1)),
                      child: Icon(
                        const IconData(0xef45, fontFamily: 'MIcon'),
                        color: const Color.fromRGBO(243, 243, 240, 1),
                        size: 24.sp,
                      ),
                    ),
                    onTap: () async {
                      await chatController.getShopUser();
                      chatController.dialog(chatController.user.value!.id!, 3);
                      Get.toNamed("/chat");
                    },
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 184, 0, 1),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                width: 2,
                                color: const Color.fromRGBO(255, 255, 255, 2))),
                      ))
                ],
              ),
            )
          : null,
    );
  }
}
