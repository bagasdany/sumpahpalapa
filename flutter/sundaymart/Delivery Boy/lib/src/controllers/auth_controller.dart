import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deliveryboy/src/components/error_dialog.dart';
import 'package:deliveryboy/src/components/success_alert.dart';
import 'package:deliveryboy/src/models/user.dart';
import 'package:deliveryboy/src/requests/sign_in_request.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:deliveryboy/src/requests/update_user_request.dart';
import 'package:deliveryboy/src/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? connectivitySubscription;
  var isConnected = true.obs;
  var user = Rxn<User>();
  var token = "".obs;
  var profilePercentage = 0.obs;
  var showConfirmPassword = false.obs;
  var showNewPassword = false.obs;
  var showNewPasswordConfirm = false.obs;
  var currentPassword = "".obs;
  var newPassword = "".obs;
  var newPasswordConfirm = "".obs;
  var loading = false.obs;
  var error = "";
  var password = "".obs;

  final ImagePicker picker = ImagePicker();
  var profileImage = Rxn<XFile>();
  var name = "".obs;
  var surname = "".obs;
  var phone = "+".obs;
  var email = "".obs;
  var gender = 0.obs;
  var image = "".obs;
  var load = true.obs;
  var route = "".obs;

  @override
  void onInit() {
    super.onInit();

    connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      await getConnectivity();
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

    route.value = "";
  }

  @override
  void onReady() {
    super.onReady();

    getConnectivity();
    getPushToken();
    user.value = getUser();
  }

  @override
  void dispose() {
    connectivitySubscription?.cancel();
    super.dispose();
  }

  Future<void> getConnectivity() async {
    try {
      bool isConnectedResult = await Utils.checkInternetConnectivity();
      isConnected.value = isConnectedResult;
      Future.delayed(const Duration(milliseconds: 3000), () {
        getUserInfoAndRedirect();
      });
    } on PlatformException {
      //print(e.message);
    }
    return Future.value(null);
  }

  Future<void> getUserInfoAndRedirect() async {
    if (!isConnected.value) {
      Get.offAndToNamed("/noConnection");
    } else {
      final box = GetStorage();
      final user = box.read('user');
      final language = box.read('language');

      if (language != null) {
        if (user != null) {
          Get.offAndToNamed("/home");
        } else {
          Get.offAndToNamed("/signin");
        }
      } else {
        Get.offAndToNamed("/languageInit");
      }
    }
  }

  User? getUser() {
    final box = GetStorage();
    final userData = box.read('user');
    if (userData == null) {
      if (user.value != null && user.value!.id != null) {
        name.value = user.value!.name!;
        surname.value = user.value!.surname!;
        phone.value = user.value!.phone!;
        email.value = user.value!.email!;
        gender.value = user.value!.gender!;
        currentPassword.value = user.value!.password!;
        image.value = user.value!.imageUrl!;
      }

      return user.value;
    } else {
      user.value = User.fromJson(userData);
      if (user.value != null && user.value!.id != null) {
        name.value = user.value!.name!;
        surname.value = user.value!.surname!;
        phone.value = user.value!.phone!;
        email.value = user.value!.email!;
        gender.value = user.value!.gender!;
        currentPassword.value = user.value!.password ?? "";
        image.value = user.value!.imageUrl ?? "";
      }
    }

    return userData != null ? User.fromJson(userData) : null;
  }

  void logout() {
    final box = GetStorage();
    box.remove('user');
    Get.offAllNamed("/signin");
  }

  Future<void> getPushToken() async {
    token.value = await FirebaseMessaging.instance.getToken() ?? "";
    token.refresh();
  }

  Future<void> updateUser() async {
    if (load.value) {
      load.value = false;

      Map<String, dynamic> data = await updateUserRequest(
          user.value!.id!,
          name.value,
          surname.value,
          phone.value,
          email.value,
          newPassword.value.isNotEmpty
              ? newPassword.value
              : currentPassword.value,
          image.value,
          gender.value,
          user.value!.idShop!);

      if (data['success']) {
        User userOld = user.value!;
        User updatedUser = User(
            id: userOld.id,
            name: name.value,
            surname: surname.value,
            password: newPassword.value.isNotEmpty
                ? newPassword.value
                : currentPassword.value,
            gender: gender.value,
            phone: phone.value,
            imageUrl: image.value,
            email: email.value);

        user.value = updatedUser;

        load.value = true;

        Get.bottomSheet(SuccessAlert(
          message: "Successfully updated".tr,
          onClose: () {
            Get.back();
          },
        ));

        final box = GetStorage();
        box.write('user', updatedUser.toJson());
      }
    }
  }

  Future<void> signInWithPhone() async {
    loading.value = true;

    Map<String, dynamic> data =
        await signInRequest(phone.value, password.value, "", token.value);

    if (data['success'] != null) {
      if (data['success']) {
        String name = data['data']['name'];
        Get.bottomSheet(SuccessAlert(
          message: "${"Welcome".tr} $name",
          onClose: () {
            Get.back();
          },
        ));
        setUser(data['data']);
        Future.delayed(1.seconds, () async {
          getUserInfoAndRedirect();
        });
      } else {
        Get.bottomSheet(ErrorAlert(
          message: "Phone or password wrong".tr,
          onClose: () {
            Get.back();
          },
        ));
      }
    } else if (data['error'] != null) {
      Get.bottomSheet(ErrorAlert(
        message: "Error occured in login".tr,
        onClose: () {
          Get.back();
        },
      ));
    }

    loading.value = false;
  }

  void onChangePhone(String text) {
    if (text.length > 1) phone.value = text;

    if (phone.value.isEmpty) phone.value = "+";
    if (phone.value[0] != "+") phone.value = "+${phone.value}";
  }

  void onChangePassword(String text) {
    password.value = text;
  }

  void setUser(Map<String, dynamic> data) {
    String name = data['name'] ?? "";
    String surname = data['surname'] ?? "";
    String phone = data['phone'] ?? "";
    String imageUrl = data['image_url'] ?? "";
    int id = data['id'];
    String email = data['email'] ?? "";
    String token = data['token'] ?? "";
    int idShop = data['id_shop'];

    double dailyBalance = data['daily_balance'].isNotEmpty
        ? double.parse(data['daily_balance'].values.toList()[0].toString())
        : 0;
    double totalBalance = double.parse(data['balance']['balance'].toString());

    User userData = User(
        name: name,
        surname: surname,
        phone: phone,
        imageUrl: imageUrl,
        id: id,
        email: email,
        idShop: idShop,
        totalBalance: totalBalance,
        dailyBalance: dailyBalance,
        token: token);

    user.value = userData;

    final box = GetStorage();
    box.write('user', user.toJson());
  }
}
