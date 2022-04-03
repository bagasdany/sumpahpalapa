import 'package:cached_network_image/cached_network_image.dart';
import 'package:deliveryboy/config/global_config.dart';
import 'package:deliveryboy/src/components/earnings_summary.dart';
import 'package:deliveryboy/src/components/profile_menu_item.dart';
import 'package:deliveryboy/src/controllers/auth_controller.dart';
import 'package:deliveryboy/src/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<AuthController> {
  ProfilePage({Key? key}) : super(key: key);
  final SettingsController settingsController = Get.put(SettingsController());

  void showSheet(context, item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (_, controller) {
            return SingleChildScrollView(
              child: const EarningSummary(),
              controller: controller,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isDarkMode = settingsController.isDarkTheme.value;

      return Scaffold(
        backgroundColor: isDarkMode
            ? const Color.fromRGBO(19, 20, 21, 1)
            : const Color.fromRGBO(243, 243, 240, 1),
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            InkWell(
              onTap: () => Get.back(),
              child: Container(
                child: Icon(
                  const IconData(0xeb99, fontFamily: 'MIcon'),
                  color: isDarkMode
                      ? const Color.fromRGBO(255, 255, 255, 1)
                      : const Color.fromRGBO(0, 0, 0, 1),
                  size: 24,
                ),
                padding: const EdgeInsets.only(right: 20),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 0.24.sw + 10,
                      height: 0.24.sw + 10,
                      margin: const EdgeInsets.only(right: 30),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 10,
                              color: isDarkMode
                                  ? const Color.fromRGBO(37, 48, 63, 1)
                                  : const Color.fromRGBO(255, 255, 255, 0.35)),
                          borderRadius: BorderRadius.circular(
                            0.24.sw,
                          )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          0.24.sw,
                        ),
                        child: SizedBox(
                          width: 0.24.sw,
                          height: 0.24.sw,
                          child: controller.user.value != null
                              ? CachedNetworkImage(
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.fill,
                                  imageUrl:
                                      "$globalImageUrl${controller.user.value!.imageUrl}",
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
                                )
                              : Icon(
                                  const IconData(0xf25c, fontFamily: 'MIcon'),
                                  color: isDarkMode
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(0, 0, 0, 1),
                                  size: 40.sp,
                                ),
                        ),
                      ),
                    ),
                    if (controller.user.value != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 0.76.sw - 90,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              "${controller.user.value!.name} ${controller.user.value!.surname}",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 26.sp,
                                letterSpacing: -1,
                                color: isDarkMode
                                    ? const Color.fromRGBO(255, 255, 255, 1)
                                    : const Color.fromRGBO(0, 0, 0, 1),
                              ),
                            ),
                          ),
                          Text(
                            "Delivery boy",
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              letterSpacing: -1,
                              color: isDarkMode
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : const Color.fromRGBO(145, 145, 143, 1),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 110,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color.fromRGBO(26, 34, 44, 1)
                        : const Color.fromRGBO(255, 255, 255, 0.4),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 70,
                      width: 1.sw - 30,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                offset: const Offset(0, 2),
                                blurRadius: 2,
                                spreadRadius: 0,
                                color: Get.isDarkMode
                                    ? const Color.fromRGBO(23, 27, 32, 0.13)
                                    : const Color.fromRGBO(169, 169, 150, 0.13))
                          ],
                          color: isDarkMode
                              ? const Color.fromRGBO(37, 48, 63, 1)
                              : const Color.fromRGBO(255, 255, 255, 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(69, 165, 36, 1),
                                borderRadius: BorderRadius.circular(25)),
                            child: Icon(
                              const IconData(0xf2ab, fontFamily: 'MIcon'),
                              size: 20.sp,
                              color: isDarkMode
                                  ? const Color.fromRGBO(0, 0, 0, 1)
                                  : const Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                          SizedBox(
                            width: 0.5.sw - 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Monthly earnings",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.4,
                                      color: isDarkMode
                                          ? const Color.fromRGBO(
                                              255, 255, 255, 1)
                                          : const Color.fromRGBO(0, 0, 0, 1)),
                                ),
                                Text(
                                  "${controller.user.value!.totalBalance}",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.4,
                                      color: isDarkMode
                                          ? const Color.fromRGBO(
                                              255, 255, 255, 1)
                                          : const Color.fromRGBO(0, 0, 0, 1)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 0.5.sw - 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Daily earnings",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.4,
                                      color: isDarkMode
                                          ? const Color.fromRGBO(
                                              255, 255, 255, 1)
                                          : const Color.fromRGBO(0, 0, 0, 1)),
                                ),
                                Text(
                                  "${controller.user.value!.dailyBalance ?? 0}",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.4,
                                      color: isDarkMode
                                          ? const Color.fromRGBO(
                                              255, 255, 255, 1)
                                          : const Color.fromRGBO(0, 0, 0, 1)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "See all earned money",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.4,
                                  color: isDarkMode
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(0, 0, 0, 1)),
                            ),
                            Icon(
                              const IconData(0xea6e, fontFamily: 'MIcon'),
                              color: isDarkMode
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : const Color.fromRGBO(0, 0, 0, 1),
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        showSheet(context, {});
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ProfileMenuItem(
                title: "Change profile".tr,
                onClick: () => Get.toNamed("/profile_settings"),
                icon: const IconData(0xf25b, fontFamily: 'MIcon'),
              ),
              ProfileMenuItem(
                title: "Setting".tr,
                onClick: () => Get.toNamed("/settings"),
                icon: const IconData(0xf0e7, fontFamily: 'MIcon'),
              ),
              ProfileMenuItem(
                title: "Exit".tr,
                onClick: () => controller.logout(),
                icon: const IconData(0xeedb, fontFamily: 'MIcon'),
                noUnderline: true,
              ),
            ],
          ),
        ),
      );
    });
  }
}
