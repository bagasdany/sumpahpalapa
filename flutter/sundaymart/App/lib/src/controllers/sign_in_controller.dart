import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:githubit/src/components/error_dialog.dart';
import 'package:githubit/src/components/success_alert.dart';
import 'package:githubit/src/controllers/auth_controller.dart';
import 'package:githubit/src/models/user.dart';
import 'package:githubit/src/requests/sign_in_request.dart';

class SignInController extends GetxController {
  var loading = false.obs;
  var loadingSocial = false.obs;
  var error = "";
  var password = "".obs;
  var phone = "+".obs;
  var code = "".obs;
  var verificationId = "".obs;
  AuthController authController = Get.put(AuthController());

  Future<void> signInWithSocial(String socialId) async {
    loadingSocial.value = true;

    Map<String, dynamic> data = await signInRequest(
        phone.value, password.value, socialId, authController.token.value);
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
          authController.getUserInfoAndRedirect();
        });
      } else {
        Get.bottomSheet(ErrorAlert(
          message: "No client found in system".tr,
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

    loadingSocial.value = false;
  }

  Future<void> signInAsGuest() async {
    User user = User();

    authController.user.value = user;
    authController.user.refresh();

    final box = GetStorage();
    box.write('user', user.toJson());

    Future.delayed(1.seconds, () async {
      authController.getUserInfoAndRedirect();
    });
  }

  Future<void> signInWithPhone() async {
    loading.value = true;

    Map<String, dynamic> data = await signInRequest(
        phone.value, password.value, "", authController.token.value);

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
          authController.getUserInfoAndRedirect();
        });
      } else {
        Get.bottomSheet(ErrorAlert(
          message: "Email or password wrong".tr,
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

    if (phone.value.length == 0) phone.value = "+";
    if (phone.value[0] != "+") phone.value = "+${phone.value}";
  }

  void onChangePassword(String text) {
    password.value = text;
  }

  void setUser(Map<String, dynamic> data) {
    String name = data['name'];
    String surname = data['surname'];
    String phone = data['phone'] != null ? data['phone'] : "";
    String imageUrl = data['image_url'] != null && data['image_url'].length > 4
        ? data['image_url']
        : "";
    int id = data['id'];
    String email = data['email'] != null ? data['email'] : "";
    String token = data['token'] != null ? data['token'] : "";

    User user = User(
        name: name,
        surname: surname,
        phone: phone,
        imageUrl: imageUrl,
        id: id,
        email: email,
        token: token);

    authController.user.value = user;
    authController.user.refresh();

    final box = GetStorage();
    box.write('user', user.toJson());
  }
}
