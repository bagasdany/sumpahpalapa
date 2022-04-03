import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:deliveryboy/config/global_config.dart';
import 'package:deliveryboy/src/components/appbar.dart';
import 'package:deliveryboy/src/components/password_change_bottomsheet.dart';
import 'package:deliveryboy/src/components/profile_textfield.dart';
import 'package:deliveryboy/src/controllers/auth_controller.dart';
import 'package:deliveryboy/src/requests/image_upload_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettings extends GetView<AuthController> {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var statusBarHeight = MediaQuery.of(context).padding.top;
      var appBarHeight = AppBar().preferredSize.height;

      return Scaffold(
        backgroundColor: Get.isDarkMode
            ? const Color.fromRGBO(19, 20, 21, 1)
            : const Color.fromRGBO(243, 243, 240, 1),
        appBar: PreferredSize(
            preferredSize: Size(1.sw, statusBarHeight + appBarHeight),
            child: AppBarCustom(
              title: "Profile settings".tr,
              hasBack: true,
            )),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0.23.sw),
                    child: controller.image.value.length > 4
                        ? Image(
                            width: 0.23.sw,
                            height: 0.23.sw,
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                                "$globalImageUrl${controller.image.value}"))
                        : controller.profileImage.value != null
                            ? SizedBox(
                                width: 0.23.sw,
                                height: 0.23.sw,
                                child: Image.file(
                                    File(controller.profileImage.value!.path)),
                              )
                            : Container(
                                width: 0.23.sw,
                                height: 0.23.sw,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 3,
                                        color: const Color.fromRGBO(
                                            136, 136, 126, 0.1)),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Icon(
                                  const IconData(0xf25c, fontFamily: 'MIcon'),
                                  color: Get.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  size: 40,
                                ),
                              ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        final pickedFile = await controller.picker.pickImage(
                          source: ImageSource.gallery,
                          maxWidth: 1000,
                          maxHeight: 1000,
                          imageQuality: 90,
                        );

                        if (pickedFile != null) {
                          Map<String, dynamic> data =
                              await imageUploadRequest(File(pickedFile.path));

                          if (data['success'] == 1) {
                            String name = data['name'];
                            controller.image.value = name;
                            controller.image.refresh();
                          }

                          controller.profileImage.value = pickedFile;
                          controller.profileImage.refresh();
                        }
                      } catch (e) {
                        //print(e)
                      }
                    },
                    child: Text(
                      "Upload new image".tr,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          letterSpacing: -0.5,
                          color: const Color.fromRGBO(53, 105, 184, 1)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ProfileTextField(
                text: "Name".tr,
                value: controller.name.value,
                onChange: (text) {
                  controller.name.value = text;
                },
              ),
              ProfileTextField(
                text: "Surname".tr,
                value: controller.surname.value,
                onChange: (text) {
                  controller.surname.value = text;
                },
              ),
              ProfileTextField(
                text: "Phone number".tr,
                value: controller.phone.value,
                type: TextInputType.number,
                onChange: (text) {
                  controller.phone.value = text;
                },
              ),
              ProfileTextField(
                text: "Email".tr,
                value: controller.email.value,
                onChange: (text) {
                  controller.email.value = text;
                },
              ),
              ProfileTextField(
                text: "Password".tr,
                value: controller.currentPassword.value,
                enabled: false,
                isObscureText: true,
                widget: InkWell(
                  child: Icon(
                    const IconData(0xefe0, fontFamily: 'MIcon'),
                    color: Get.isDarkMode
                        ? const Color.fromRGBO(255, 255, 255, 1)
                        : const Color.fromRGBO(0, 0, 0, 1),
                    size: 24.sp,
                  ),
                  onTap: () {
                    controller.currentPassword.value =
                        controller.user.value!.password!;

                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        return DraggableScrollableSheet(
                          expand: false,
                          builder: (_, controller) {
                            return SingleChildScrollView(
                              controller: controller,
                              child: const PasswordChangeBottomsheet(),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Text(
                "Gender".tr,
                style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    letterSpacing: -0.4,
                    color: Get.isDarkMode
                        ? const Color.fromRGBO(130, 139, 150, 1)
                        : const Color.fromRGBO(0, 0, 0, 0.3)),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  InkWell(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1,
                                  color: const Color.fromRGBO(53, 105, 184, 1)),
                              color: controller.gender.value == 0
                                  ? const Color.fromRGBO(53, 105, 184, 1)
                                  : Colors.transparent),
                          child: Icon(
                            const IconData(0xef2d, fontFamily: 'MIcon'),
                            color: controller.gender.value == 0
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(53, 105, 184, 1),
                            size: 18.sp,
                          ),
                        ),
                        Text(
                          "Male".tr,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              letterSpacing: -0.4,
                              color: controller.gender.value == 0
                                  ? Get.isDarkMode
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(0, 0, 0, 1)
                                  : Get.isDarkMode
                                      ? const Color.fromRGBO(130, 139, 150, 1)
                                      : const Color.fromRGBO(136, 136, 126, 1)),
                        ),
                      ],
                    ),
                    onTap: () {
                      controller.gender.value = 0;
                    },
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  InkWell(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1,
                                  color: const Color.fromRGBO(222, 31, 54, 1)),
                              color: controller.gender.value == 1
                                  ? const Color.fromRGBO(222, 31, 54, 1)
                                  : Colors.transparent),
                          child: Icon(
                            const IconData(0xf2cd, fontFamily: 'MIcon'),
                            color: controller.gender.value == 1
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(222, 31, 54, 1),
                            size: 18.sp,
                          ),
                        ),
                        Text(
                          "Female".tr,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              letterSpacing: -0.4,
                              color: controller.gender.value == 1
                                  ? Get.isDarkMode
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(0, 0, 0, 1)
                                  : Get.isDarkMode
                                      ? const Color.fromRGBO(130, 139, 150, 1)
                                      : const Color.fromRGBO(136, 136, 126, 1)),
                        ),
                      ],
                    ),
                    onTap: () {
                      controller.gender.value = 1;
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
        extendBody: true,
        bottomNavigationBar: SizedBox(
          height: 100,
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () => controller.updateUser(),
                child: Container(
                  width: 1.sw - 30,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromRGBO(69, 165, 36, 1)),
                  alignment: Alignment.center,
                  child: controller.load.value
                      ? Text(
                          "Save".tr,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              letterSpacing: -0.4,
                              color: const Color.fromRGBO(255, 255, 255, 1)),
                        )
                      : const SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
