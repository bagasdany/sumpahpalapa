import 'dart:ui';

import 'package:deliveryboy/config/global_config.dart';
import 'package:deliveryboy/src/components/password_input.dart';
import 'package:deliveryboy/src/components/sign_button.dart';
import 'package:deliveryboy/src/components/text_input.dart';
import 'package:deliveryboy/src/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInPage extends GetView<AuthController> {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? const Color.fromRGBO(19, 20, 21, 1)
          : const Color.fromRGBO(243, 243, 240, 1),
      body: SingleChildScrollView(
        child: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 0.05.sh),
              child: Image(
                image: AssetImage(Get.isDarkMode
                    ? "lib/assets/images/dark_mode/image9.png"
                    : "lib/assets/images/light_mode/image9.png"),
                height: 0.42.sh,
                width: 1.sw,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
                width: 1.sw,
                height: 22,
                margin: EdgeInsets.only(top: 0.075.sh, right: 16, left: 30),
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      appName,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                          letterSpacing: -1,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(255, 255, 255, 1)
                              : const Color.fromRGBO(0, 0, 0, 1)),
                    ),
                  ],
                )),
            Positioned(
                bottom: 0,
                child: Container(
                    width: 1.sw,
                    padding: EdgeInsets.only(
                        top: 0.022.sh,
                        left: 0.0725.sw,
                        right: 0.0725.sw,
                        bottom: 0.08.sh),
                    decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? const Color.fromRGBO(37, 48, 63, 1)
                            : Colors.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Sign In".tr,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 35.sp,
                                    letterSpacing: -2,
                                    color: Get.isDarkMode
                                        ? const Color.fromRGBO(255, 255, 255, 1)
                                        : const Color.fromRGBO(0, 0, 0, 1)),
                              ),
                              margin: EdgeInsets.only(bottom: 0.023.sh),
                            ),
                            TextInput(
                                title: "Phone number".tr,
                                defaultValue: controller.phone.value,
                                type: TextInputType.number,
                                onChange: controller.onChangePhone,
                                placeholder: "+998 90 900 00 00"),
                            Divider(
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : const Color.fromRGBO(0, 0, 0, 1),
                              height: 1,
                            ),
                            PasswordInput(
                              title: "Password".tr,
                              onChange: controller.onChangePassword,
                            ),
                            SizedBox(
                              height: 0.066.sh,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SignButton(
                                  title: "Sign In".tr,
                                  loading: controller.loading.value,
                                  onClick: controller.signInWithPhone,
                                ),
                              ],
                            )
                          ],
                        )))),
          ]),
        ),
      ),
    );
  }
}
