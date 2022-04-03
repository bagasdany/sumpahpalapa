import 'package:deliveryboy/src/components/appbar.dart';
import 'package:deliveryboy/src/components/settings_item.dart';
import 'package:deliveryboy/src/components/sp_checkbox.dart';
import 'package:deliveryboy/src/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Settings extends GetView<SettingsController> {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var statusBarHeight = MediaQuery.of(context).padding.top;
      var appBarHeight = AppBar().preferredSize.height;
      bool isDarkMode = controller.isDarkTheme.value;

      return Scaffold(
        backgroundColor: isDarkMode
            ? const Color.fromRGBO(19, 20, 21, 1)
            : const Color.fromRGBO(243, 243, 240, 1),
        appBar: PreferredSize(
            preferredSize: Size(1.sw, statusBarHeight + appBarHeight),
            child: AppBarCustom(
              title: "Setting".tr,
              hasBack: true,
            )),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              SettingsItem(
                  icon: const IconData(0xebf8, fontFamily: 'MIcon'),
                  text: "UI Theme".tr,
                  rightWidget: SpCheckBox(
                    onChanged: (value) {
                      controller.setDarkTheme(value);
                    },
                    activeText: "Dark".tr,
                    inactiveText: "Light".tr,
                    value: controller.isDarkTheme.value,
                  )),
              InkWell(
                child: SettingsItem(
                  icon: const IconData(0xedcf, fontFamily: 'MIcon'),
                  text: "Languages".tr,
                  rightWidget: Icon(
                    const IconData(0xea6e, fontFamily: 'MIcon'),
                    color: isDarkMode
                        ? const Color.fromRGBO(255, 255, 255, 1)
                        : const Color.fromRGBO(0, 0, 0, 1),
                    size: 20.sp,
                  ),
                ),
                onTap: () => Get.toNamed("/language"),
              ),
            ],
          ),
        ),
      );
    });
  }
}
