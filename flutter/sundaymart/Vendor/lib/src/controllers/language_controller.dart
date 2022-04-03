import 'package:vendor/config/global_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vendor/src/helpers/utils.dart';
import 'package:vendor/src/models/language.dart';
import 'package:vendor/src/requests/language_request.dart';
import 'package:vendor/src/requests/translation_request.dart';

class LanguageController extends GetxController {
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
  }

  Locale? get getLocale {
    if (currentLanguageStore.value == '') {
      language.value = defaultLang;
      updateLanguage(defaultLang);
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
      Map<String, dynamic> data = await languageRequest();

      if (data['success'] != null && data['success']) {
        List<Language> languagesList = [];
        for (int i = 0; i < data['data'].length; i++) {
          Map<String, dynamic> item = data['data'][i];

          if (activeLanguageId.value == 0 && i == 0) {
            activeLanguageId.value = item['id'];
            language.value = item['short_name'];
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
      for (var element in languages) {
        if (element.name!.toLowerCase().contains(text)) resultList.add(element);
      }

      languages.value = resultList;
    } else {
      languages.value = languagesStore;
    }

    languages.refresh();
  }

  void setLanguage(String locale, int id) {
    language.value = locale;
    activeLanguageId.value = id;
    updateLanguage(locale);

    Get.toNamed("/signin");
  }

  Future<Map<String, Map<String, String>>> getMessages() async {
    Map<String, Map<String, String>> data = {};
    if (await Utils.checkInternetConnectivity()) {
      Map<String, dynamic> datas = await translationRequest();
      if (datas['data'] != null) {
        for (String key in datas['data'].keys) {
          Map<String, String> jsonData = {};

          for (String key2 in datas['data'][key].keys) {
            jsonData[key2] = datas['data'][key][key2];
          }

          data["${key}_US"] = jsonData;
        }
      }
    }

    languageMap.value = data;
    languageMap.refresh();

    return data;
  }

  void reload() {}
}
