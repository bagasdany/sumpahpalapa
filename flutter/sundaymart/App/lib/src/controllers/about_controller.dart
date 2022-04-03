import 'package:get/get.dart';
import 'package:githubit/src/controllers/language_controller.dart';
import 'package:githubit/src/controllers/shop_controller.dart';
import 'package:githubit/src/models/shop.dart';
import 'package:githubit/src/requests/about_request.dart';
import 'package:githubit/src/requests/privacy_request.dart';
import 'package:githubit/src/requests/terms_request.dart';

class AboutControler extends GetxController {
  final ShopController shopController = Get.put(ShopController());
  final LanguageController languageController = Get.put(LanguageController());

  Shop? shop;

  Future<String> getAboutContent() async {
    shop = shopController.defaultShop.value;
    Map<String, dynamic> data = await aboutRequest(
        shop!.id!, languageController.activeLanguageId.value);

    if (data['success']) {
      if (data['data'] != null && data['data']['languages'] != null) {
        int index = data['data']['languages'].indexWhere(
            (item) => item['id'] == languageController.activeLanguageId.value);
        if (index > -1) {
          Map<String, dynamic> content = data['data']['languages'][index];
          return content['content'];
        }
      }
    }

    return "";
  }

  Future<String> getPrivacyContent() async {
    shop = shopController.defaultShop.value;
    Map<String, dynamic> data = await privacyRequest(shop!.id!);

    if (data != null && data['success']) {
      if (data['data'] != null && data['data']['languages'] != null) {
        int index = data['data']['languages'].indexWhere(
            (item) => item['id'] == languageController.activeLanguageId.value);
        if (index > -1) {
          Map<String, dynamic> content = data['data']['languages'][index];
          return content['content'];
        }
      }
    }

    return "";
  }

  Future<String> getTermsContent() async {
    shop = shopController.defaultShop.value;
    Map<String, dynamic> data = await termsRequest(shop!.id!);

    if (data['success']) {
      if (data['data'] != null && data['data']['languages'] != null) {
        int index = data['data']['languages'].indexWhere(
            (item) => item['id'] == languageController.activeLanguageId.value);
        if (index > -1) {
          Map<String, dynamic> content = data['data']['languages'][index];
          return content['content'];
        }
      }
    }

    return "";
  }
}
