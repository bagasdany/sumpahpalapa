import 'package:deliveryboy/src/controllers/auth_controller.dart';
import 'package:deliveryboy/src/requests/offline_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  var isDarkTheme = false.obs;
  var isOnline = false.obs;
  final AuthController authController = Get.put(AuthController());

  @override
  void onInit() {
    super.onInit();

    final box = GetStorage();
    bool isDarkThemeStorage = box.read("isDarkTheme") ?? false;
    bool online = box.read("isOnline") ?? false;

    isDarkTheme.value = isDarkThemeStorage;
    isOnline.value = online;
    Get.changeTheme(isDarkThemeStorage ? ThemeData.dark() : ThemeData.light());
  }

  void setDarkTheme(bool isDark) {
    final box = GetStorage();
    box.write("isDarkTheme", isDark);
    if (isDark) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
    isDarkTheme.value = isDark;
  }

  Future<void> makeOnline(online) async {
    isOnline.value = online;

    final box = GetStorage();
    box.write("isOnline", online);

    await offlineRequest(
        authController.user.value!.id!, isOnline.value ? 0 : 1);
  }
}
