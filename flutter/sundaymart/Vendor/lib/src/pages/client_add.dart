import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/admin_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientAdd extends GetView<AdminController> {
  const ClientAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          backgroundColor: HexColor("#F9F9FA"),
          appBar: customAppBar(
              icon: const IconData(0xea60, fontFamily: 'MIcon'),
              onClickIcon: () {
                Get.back();
              },
              title: "Client Add"),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 40,
                ),
                SelectInput(
                    title: "Name",
                    child: TextField(
                      onChanged: (text) {
                        controller.clientName.value = text;
                      },
                      controller: TextEditingController(
                          text: controller.clientName.value)
                        ..selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: controller.clientName.value.length),
                        ),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: HexColor("#000000"),
                          fontFamily: "MIcon",
                          fontSize: 16.sp,
                          letterSpacing: -0.4),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    )),
                const SizedBox(
                  height: 30,
                ),
                SelectInput(
                    title: "Surname",
                    child: TextField(
                      onChanged: (text) {
                        controller.clientSurname.value = text;
                      },
                      controller: TextEditingController(
                          text: controller.clientSurname.value)
                        ..selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: controller.clientSurname.value.length),
                        ),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: HexColor("#000000"),
                          fontFamily: "MIcon",
                          fontSize: 16.sp,
                          letterSpacing: -0.4),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    )),
                const SizedBox(
                  height: 30,
                ),
                SelectInput(
                    title: "Email",
                    child: TextField(
                      onChanged: (text) {
                        controller.clientEmail.value = text;
                      },
                      controller: TextEditingController(
                          text: controller.clientEmail.value)
                        ..selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: controller.clientEmail.value.length),
                        ),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: HexColor("#000000"),
                          fontFamily: "MIcon",
                          fontSize: 16.sp,
                          letterSpacing: -0.4),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    )),
                const SizedBox(
                  height: 30,
                ),
                SelectInput(
                    title: "Phone",
                    child: TextField(
                      onChanged: (text) {
                        controller.clientPhone.value = text;
                      },
                      controller: TextEditingController(
                          text: controller.clientPhone.value)
                        ..selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: controller.clientPhone.value.length),
                        ),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: HexColor("#000000"),
                          fontFamily: "MIcon",
                          fontSize: 16.sp,
                          letterSpacing: -0.4),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    )),
                const SizedBox(
                  height: 30,
                ),
                SelectInput(
                    title: "Password",
                    child: TextField(
                      onChanged: (text) {
                        controller.clientPassword.value = text;
                      },
                      controller: TextEditingController(
                          text: controller.clientPassword.value)
                        ..selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: controller.clientPassword.value.length),
                        ),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: HexColor("#000000"),
                          fontFamily: "MIcon",
                          fontSize: 16.sp,
                          letterSpacing: -0.4),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    )),
                const SizedBox(
                  height: 30,
                ),
                SelectInput(
                    title: "Password confirm",
                    child: TextField(
                      onChanged: (text) {
                        controller.clientPasswordConfirm.value = text;
                      },
                      controller: TextEditingController(
                          text: controller.clientPasswordConfirm.value)
                        ..selection = TextSelection.fromPosition(
                          TextPosition(
                              offset: controller
                                  .clientPasswordConfirm.value.length),
                        ),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: HexColor("#000000"),
                          fontFamily: "MIcon",
                          fontSize: 16.sp,
                          letterSpacing: -0.4),
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    )),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          extendBody: true,
          bottomNavigationBar: InkWell(
            onTap: () {
              if (controller.clientName.value.isNotEmpty &&
                  controller.clientSurname.value.isNotEmpty &&
                  controller.clientPhone.value.isNotEmpty &&
                  controller.clientPassword.value.isNotEmpty) {
                controller.saveClient();
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              width: 1.sw - 30,
              height: 60,
              decoration: BoxDecoration(
                  color: (controller.clientName.value.isNotEmpty &&
                          controller.clientSurname.value.isNotEmpty &&
                          controller.clientPhone.value.isNotEmpty &&
                          controller.clientPassword.value.isNotEmpty)
                      ? HexColor("#16AA16")
                      : HexColor("#F1F1F1"),
                  borderRadius: BorderRadius.circular(30)),
              alignment: Alignment.center,
              child: controller.loading.value
                  ? SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        color: HexColor("ffffff"),
                      ),
                    )
                  : Text(
                      "Save",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          letterSpacing: -0.4,
                          color: HexColor("#ffffff")),
                    ),
            ),
          ));
    });
  }
}
