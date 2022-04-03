import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:githubit/src/components/appbar.dart';
import 'package:githubit/src/components/settings_item.dart';
import 'package:githubit/src/controllers/settings_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMedia extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? Color.fromRGBO(19, 20, 21, 1)
          : Color.fromRGBO(243, 243, 240, 1),
      appBar: PreferredSize(
          preferredSize: Size(1.sw, statusBarHeight + appBarHeight),
          child: AppBarCustom(
            title: "Social media".tr,
            hasBack: true,
          )),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            InkWell(
                child: SettingsItem(
                  icon: const IconData(0xecbc, fontFamily: 'MIcon'),
                  text: "Facebook".tr,
                  rightWidget: Container(
                    child: Icon(
                      const IconData(0xea6e, fontFamily: 'MIcon'),
                      color: Get.isDarkMode
                          ? Color.fromRGBO(255, 255, 255, 1)
                          : Color.fromRGBO(0, 0, 0, 1),
                      size: 20.sp,
                    ),
                  ),
                ),
                onTap: () async {
                  String url = "https://facebook.com";
                  if (await canLaunch(url)) {
                    await launch(
                      url,
                      forceSafariVC: false,
                      forceWebView: false,
                    );
                  } else {
                    throw 'Could not launch $url';
                  }
                }),
            InkWell(
                child: SettingsItem(
                  icon: const IconData(0xee65, fontFamily: 'MIcon'),
                  text: "Instagram".tr,
                  rightWidget: Container(
                    child: Icon(
                      const IconData(0xea6e, fontFamily: 'MIcon'),
                      color: Get.isDarkMode
                          ? Color.fromRGBO(255, 255, 255, 1)
                          : Color.fromRGBO(0, 0, 0, 1),
                      size: 20.sp,
                    ),
                  ),
                ),
                onTap: () async {
                  String url = "https://instagram.com";
                  if (await canLaunch(url)) {
                    await launch(
                      url,
                      forceSafariVC: false,
                      forceWebView: false,
                    );
                  } else {
                    throw 'Could not launch $url';
                  }
                }),
            InkWell(
                child: SettingsItem(
                  icon: const IconData(0xf23a, fontFamily: 'MIcon'),
                  text: "Twitter".tr,
                  rightWidget: Container(
                    child: Icon(
                      const IconData(0xea6e, fontFamily: 'MIcon'),
                      color: Get.isDarkMode
                          ? Color.fromRGBO(255, 255, 255, 1)
                          : Color.fromRGBO(0, 0, 0, 1),
                      size: 20.sp,
                    ),
                  ),
                ),
                onTap: () async {
                  String url = "https://twitter.com";
                  if (await canLaunch(url)) {
                    await launch(
                      url,
                      forceSafariVC: false,
                      forceWebView: false,
                    );
                  } else {
                    throw 'Could not launch $url';
                  }
                })
          ],
        ),
      ),
    );
  }
}
