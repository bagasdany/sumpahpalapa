import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:githubit/config/global_config.dart';
import 'package:githubit/src/components/password_input.dart';
import 'package:githubit/src/controllers/sign_up_controller.dart';

class ResetPassword extends GetView<SignUpController> {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Get.isDarkMode
            ? Color.fromRGBO(19, 20, 21, 1)
            : Color.fromRGBO(243, 243, 240, 1),
        body: SingleChildScrollView(
          child: Container(
            width: 1.sw,
            height: 1.sh,
            child: Stack(children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 0.05.sh),
                child: Image(
                  image: AssetImage(Get.isDarkMode
                      ? "lib/assets/images/dark_mode/image9.png"
                      : "lib/assets/images/light_mode/image9.png"),
                  height: 0.52.sh,
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
                        "$APP_NAME",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                            letterSpacing: -1,
                            color: Get.isDarkMode
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(0, 0, 0, 1)),
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
                            ? Color.fromRGBO(37, 48, 63, 1)
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Enter new password".tr,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 32.sp,
                                letterSpacing: -2,
                                color: Get.isDarkMode
                                    ? Color.fromRGBO(255, 255, 255, 1)
                                    : Color.fromRGBO(0, 0, 0, 1)),
                          ),
                          margin: EdgeInsets.only(bottom: 0.023.sh),
                        ),
                        PasswordInput(
                          title: "New password".tr,
                          onChange: controller.onChangePassword,
                        ),
                        Divider(
                          color: Get.isDarkMode
                              ? Color.fromRGBO(255, 255, 255, 1)
                              : Color.fromRGBO(0, 0, 0, 1),
                          height: 1,
                        ),
                        PasswordInput(
                          title: "New password confirm".tr,
                          onChange: controller.onChangePasswordConfirm,
                        ),
                        SizedBox(
                          height: 0.045.sh,
                        ),
                        Container(
                            width: 0.845.sw,
                            height: 56,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: Color.fromRGBO(69, 165, 36, 1)),
                            margin: EdgeInsets.only(top: 0.05.sh),
                            alignment: Alignment.center,
                            child: TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry>(EdgeInsets.all(0))),
                              onPressed: () => controller.saveUserPassword(),
                              child: controller.loading.value
                                  ? SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "Change".tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                          color:
                                              Color.fromRGBO(255, 255, 255, 1)),
                                    ),
                            )),
                      ],
                    )),
              )
            ]),
          ),
        ),
      );
    });
  }
}
