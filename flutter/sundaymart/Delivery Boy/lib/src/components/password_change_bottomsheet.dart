import 'package:deliveryboy/src/components/error_dialog.dart';
import 'package:deliveryboy/src/components/profile_textfield.dart';
import 'package:deliveryboy/src/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PasswordChangeBottomsheet extends GetView<AuthController> {
  const PasswordChangeBottomsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
        decoration: BoxDecoration(
            color: Get.isDarkMode
                ? const Color.fromRGBO(37, 48, 63, 1)
                : const Color.fromRGBO(255, 255, 255, 1),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: const Offset(0, -8),
                  blurRadius: 70,
                  spreadRadius: 0,
                  color: Get.isDarkMode
                      ? const Color.fromRGBO(0, 0, 0, 0.25)
                      : const Color.fromRGBO(169, 169, 169, 0.25))
            ],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 0.1.sw,
              height: 5,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(204, 204, 204, 1),
                  borderRadius: BorderRadius.circular(5)),
            ),
            const SizedBox(
              height: 30,
            ),
            ProfileTextField(
              text: "Current password".tr,
              value: controller.currentPassword.value,
              isObscureText: controller.showConfirmPassword.value,
              widget: InkWell(
                child: Icon(
                  controller.showConfirmPassword.value
                      ? const IconData(0xecb3, fontFamily: 'MIcon')
                      : const IconData(0xecb5, fontFamily: 'MIcon'),
                  color: Get.isDarkMode
                      ? const Color.fromRGBO(130, 139, 150, 1)
                      : const Color.fromRGBO(179, 179, 179, 1),
                  size: 24.sp,
                ),
                onTap: () {
                  controller.showConfirmPassword.value =
                      !controller.showConfirmPassword.value;
                },
              ),
              onChange: (text) {
                controller.currentPassword.value = text;
              },
            ),
            ProfileTextField(
              text: "New password".tr,
              value: controller.newPassword.value,
              isObscureText: controller.showNewPassword.value,
              widget: InkWell(
                child: Icon(
                  controller.showNewPassword.value
                      ? const IconData(0xecb3, fontFamily: 'MIcon')
                      : const IconData(0xecb5, fontFamily: 'MIcon'),
                  color: Get.isDarkMode
                      ? const Color.fromRGBO(130, 139, 150, 1)
                      : const Color.fromRGBO(179, 179, 179, 1),
                  size: 24.sp,
                ),
                onTap: () {
                  controller.showNewPassword.value =
                      !controller.showNewPassword.value;
                },
              ),
              onChange: (text) {
                controller.newPassword.value = text;
              },
            ),
            ProfileTextField(
              text: "Confirm password".tr,
              value: controller.newPasswordConfirm.value,
              isObscureText: controller.showNewPasswordConfirm.value,
              widget: InkWell(
                child: Icon(
                  controller.showNewPasswordConfirm.value
                      ? const IconData(0xecb3, fontFamily: 'MIcon')
                      : const IconData(0xecb5, fontFamily: 'MIcon'),
                  color: Get.isDarkMode
                      ? const Color.fromRGBO(130, 139, 150, 1)
                      : const Color.fromRGBO(179, 179, 179, 1),
                  size: 24.sp,
                ),
                onTap: () {
                  controller.showNewPasswordConfirm.value =
                      !controller.showNewPasswordConfirm.value;
                },
              ),
              onChange: (text) {
                controller.newPasswordConfirm.value = text;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                if (controller.newPassword.value.length < 6) {
                  Get.bottomSheet(ErrorAlert(
                    message:
                        "Password length should be at least 6 characters".tr,
                    onClose: () {
                      Get.back();
                    },
                  ));
                } else if (controller.newPassword.value ==
                    controller.newPasswordConfirm.value) {
                  if (controller.currentPassword.value ==
                      controller.user.value!.password) {
                    controller.user.value!.password =
                        controller.newPassword.value;
                    controller.user.refresh();
                    Get.back();
                  } else {
                    Get.bottomSheet(ErrorAlert(
                      message: "Current password is wrong".tr,
                      onClose: () {
                        Get.back();
                      },
                    ));
                  }
                } else {
                  Get.bottomSheet(ErrorAlert(
                    message:
                        "New password and New password confirm mismatch".tr,
                    onClose: () {
                      Get.back();
                    },
                  ));
                }
              },
              child: Container(
                width: 1.sw - 30,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromRGBO(69, 165, 36, 1)),
                alignment: Alignment.center,
                child: Text(
                  "Update password".tr,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      letterSpacing: -0.4,
                      color: const Color.fromRGBO(255, 255, 255, 1)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      );
    });
  }
}
