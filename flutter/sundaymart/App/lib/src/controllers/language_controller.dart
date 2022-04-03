import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:githubit/config/global_config.dart';
import 'package:githubit/src/controllers/auth_controller.dart';
import 'package:githubit/src/controllers/shop_controller.dart';
import 'package:githubit/src/models/language.dart';
import 'package:githubit/src/requests/language_request.dart';
import 'package:githubit/src/requests/languages_request.dart';
import 'package:githubit/src/utils/utils.dart';

class LanguageController extends GetxController {
  final AuthController authController = Get.put(AuthController());

  var language = "en".obs;
  var languages = <Language>[].obs;
  var languagesStore = <Language>[].obs;
  var activeLanguageId = 0.obs;
  var languageMap = <String, Map<String, String>>{}.obs;

  String get currentLanguage => language.value;
  int get currentLanguageId => activeLanguageId.value;

  @override
  void onInit() {
    super.onInit();

    getLanguages();
    getLanguage();
  }

  Locale? get getLocale {
    if (currentLanguageStore.value == '') {
      language.value = DEFAULT_LANG;
      updateLanguage(DEFAULT_LANG);
    } else if (currentLanguageStore.value != '') {
      return Locale(currentLanguageStore.value);
    }
    return Get.deviceLocale;
  }

  RxString get currentLanguageStore {
    final store = GetStorage();
    language.value = store.read('language') ?? '';
    return language;
  }

  Future<void> updateLanguage(String value) async {
    final store = GetStorage();
    language.value = value;
    await store.write('language', value);
    if (getLocale != null) {
      Get.updateLocale(getLocale!);
    }
    update();
  }

  Future<void> getLanguages() async {
    if (await Utils.checkInternetConnectivity()) {
      Map<String, dynamic> data = await languagesRequest();
      if (data['success']) {
        List<Language> languagesList = [];
        for (int i = 0; i < data['data'].length; i++) {
          Map<String, dynamic> item = data['data'][i];

          if (activeLanguageId.value == 0 && i == 0) {
            activeLanguageId.value = item['id'];
            language.value = item['short_name'];

            var locale = Locale(item['short_name'], "US");
            Get.updateLocale(locale);

            reload();
          }

          languagesList.add(Language(
              id: int.parse(item['id'].toString()),
              name: item['name'],
              shortName: item['short_name'],
              image: item['image_url']));
        }

        languages.value = languagesList;
        languagesStore.value = languagesList;
        languages.refresh();
      }
    }
  }

  void onSearch(text) {
    List<Language> resultList = [];

    if (text.length > 0) {
      languages.forEach((element) {
        if (element.name!.toLowerCase().contains(text)) resultList.add(element);
      });

      languages.value = resultList;
    } else
      languages.value = languagesStore;

    languages.refresh();
  }

  void setLanguage(String locale, int id) {
    language.value = locale;
    activeLanguageId.value = id;
    final store = GetStorage();
    store.write('language', locale);
    updateLanguage(locale);

    Get.toNamed("/splash");
  }

  Future<void> getLanguage() async {
    final store = GetStorage();
    String shortName = store.read('language') ?? '';
    int index =
        languages.indexWhere((element) => element.shortName == shortName);
    if (index > -1) {
      language.value = shortName;
      activeLanguageId.value = languages[index].id!;
    }
  }

  Future<Map<String, Map<String, String>>> getMessages() async {
    Map<String, Map<String, String>> data = {};
    if (await Utils.checkInternetConnectivity()) {
      Map<String, dynamic> datas = await languageRequest();
      for (String key in datas['data'].keys) {
        Map<String, String> jsonData = {};

        for (String key2 in datas['data'][key].keys) {
          jsonData[key2] = datas['data'][key][key2];
        }

        data["${key}_US"] = jsonData;
      }
    }

    languageMap.value = data;
    languageMap.refresh();

    return data;
  }

  void reload() {
    ShopController shopController = Get.put(ShopController());
    shopController.loading.value = true;
    shopController.shopList.value = [];
    shopController.categoryList.value = [];
    shopController.getShopCategories();
    shopController.getShops();
  }
}
