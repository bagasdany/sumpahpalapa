import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/src/components/success_alert.dart';
import 'package:vendor/src/controllers/brand_controller.dart';
import 'package:vendor/src/controllers/category_controller.dart';
import 'package:vendor/src/controllers/language_controller.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/requests/brand_active_request.dart';
import 'package:vendor/src/requests/category_active_request.dart';
import 'package:vendor/src/requests/extra_group_get_request.dart';
import 'package:vendor/src/requests/extra_group_save_request.dart';
import 'package:vendor/src/requests/extra_group_type_active_request.dart';
import 'package:vendor/src/requests/product_character_get_request.dart';
import 'package:vendor/src/requests/product_character_save_request.dart';
import 'package:vendor/src/requests/product_characters_request.dart';
import 'package:vendor/src/requests/product_detail_get_request.dart';
import 'package:vendor/src/requests/product_extra_group_request.dart';
import 'package:vendor/src/requests/product_extras_request.dart';
import 'package:vendor/src/requests/product_save_request.dart';
import 'package:vendor/src/requests/products_request.dart';
import 'package:vendor/src/requests/unit_active_request.dart';

class ProductController extends GetxController {
  OrderController orderController = Get.put(OrderController());
  LanguageController languageController = Get.put(LanguageController());
  BrandController brandController = Get.put(BrandController());
  CategoryController categoryController = Get.put(CategoryController());

  ScrollController scrollController = ScrollController();

  var products = [].obs;
  var searchText = "".obs;
  var searchWord = "".obs;
  var productDashboard = [].obs;
  var edit = false.obs;
  var productImageName = "".obs;
  var brandId = 0.obs;
  var categoryId = 0.obs;
  var activeLanguage = "".obs;
  var productName = <String, String>{}.obs;
  var active = true.obs;
  var loading = false.obs;
  var loadData = false.obs;
  var activeBrands = [].obs;
  var activeCategories = [].obs;
  var productDescription = <String, String>{}.obs;
  var packageCount = "1".obs;
  var price = "0".obs;
  var quantity = "1".obs;
  var units = [].obs;
  var unitId = 0.obs;
  var featureType = 1.obs;
  var productId = 0.obs;
  var tabIndex = 0.obs;
  var characters = [].obs;
  var characterId = 0.obs;
  var characterEdit = false.obs;
  var characterKeys = {}.obs;
  var characterValues = {}.obs;
  var characterActive = 1.obs;
  var extrasGroup = [].obs;
  var extrasGroupId = 0.obs;
  var extrasGroupEdit = false.obs;
  var extras = [].obs;
  var extrasId = 0.obs;
  var extrasEdit = false.obs;

  var extraGroupName = {}.obs;
  var extraGroupType = 0.obs;
  var extraGroupActive = 1.obs;
  var extraGroupTypes = [].obs;

  final ImagePicker picker = ImagePicker();

  Future<List> getProducts() async {
    if (loadData.value) {
      Map<String, dynamic> data =
          await productsRequest(10, products.length, searchText.value);

      if (data['success'] != 0) {
        for (int i = 0; i < data['data'].length; i++) {
          int index = products
              .indexWhere((element) => element['id'] == data['data'][i]['id']);
          if (index == -1) {
            products.add(data['data'][i]);
          }
        }
      }
      loadData.value = false;
      activeLanguage.value = languageController.language.value;
      getActiveBrands(orderController.shopId.value);
      getActiveCategories(orderController.shopId.value);
      getActiveUnits();
    }

    return products;
  }

  Future<List> getDashboardProducts() async {
    if (loadData.value) {
      searchText.value = "";
      if (orderController.shopId.value > 0) {
        searchText.value += "&shop_id=${orderController.shopId.value}";
      }

      if (brandId.value > 0) {
        searchText.value += "&brand_id=${brandId.value}";
      }

      if (categoryId.value > 0) {
        searchText.value += "&category_id=${categoryId.value}";
      }

      if (searchWord.value.isNotEmpty) {
        searchText.value += "&search=${searchWord.value}";
      }

      print(productDashboard.length);
      print(searchText.value);

      Map<String, dynamic> data =
          await productsRequest(10, productDashboard.length, searchText.value);
      if (data['success'] != 0) {
        for (int i = 0; i < data['data'].length; i++) {
          int index = productDashboard
              .indexWhere((element) => element['id'] == data['data'][i]['id']);
          if (index == -1) {
            productDashboard.add(data['data'][i]);
          }
        }
      }

      getActiveBrands(orderController.shopId.value);
      getActiveCategories(orderController.shopId.value);

      loadData.value = false;
    }

    return productDashboard;
  }

  Future<void> productSave() async {
    loading.value = true;

    Map<String, dynamic> body = {
      "names": productName,
      "descriptions": productDescription,
      "shop_id": orderController.shopId.value,
      "brand_id": brandId.value,
      "category_id": categoryId.value,
      "package_count": packageCount.value,
      "price": price.value,
      "quantity": quantity.value,
      "unit": unitId.value,
      "feature_type": featureType.value,
      "images": [
        {"name": productImageName.value}
      ],
      "active": active.value,
      "id": productId.value
    };

    Map<String, dynamic> data = await productSaveRequest(body);

    if (data['success']) {
      products.value = [];
      productName.value = {};
      productDescription.value = {};
      productImageName.value = "";
      active.value = false;
      featureType.value = 1;
      productId.value = 0;
      packageCount.value = "1";
      price.value = "0";
      quantity.value = "1";
      unitId.value = units[0]["id"];
      brandId.value = activeBrands[0]['id'];
      categoryId.value = activeCategories[0]["id"];
      orderController.shopId.value = orderController.shops[0]['id'];
      Get.back();
      Get.bottomSheet(SuccessAlert(
        message: "Successfully completed",
        onClose: () {
          Get.back();
        },
      ));

      loadData.value = true;
      getProducts();
    }

    loading.value = false;
  }

  Future<void> getProductDetail(id) async {
    characters.value = [];
    extrasGroup.value = [];
    extras.value = [];

    Map<String, dynamic> data = await productDetailGetRequest(id);
    if (data['success']) {
      await getActiveBrands(data['data']['id_shop']);
      await getActiveCategories(data['data']['id_shop']);

      Map<String, String> productNameData = {};
      Map<String, String> productDescriptionData = {};

      for (int i = 0; i < data['data']['languages'].length; i++) {
        productNameData[data['data']['languages'][i]['language']
            ['short_name']] = data['data']['languages'][i]['name'] ?? "";
        productDescriptionData[data['data']['languages'][i]['language']
            ['short_name']] = data['data']['languages'][i]['description'] ?? "";
      }

      productImageName.value = data['data']['images'].length > 0
          ? data['data']['images'][0]["image_url"]
          : "";
      categoryId.value = data['data']['id_category'];
      brandId.value = data['data']['id_brand'];
      orderController.shopId.value = data['data']['id_shop'];
      productName.value = productNameData;
      productDescription.value = productDescriptionData;
      active.value = data['data']['active'] == 1;
      productId.value = data['data']['id'];
      unitId.value = data['data']['id_unit'];
      quantity.value = data['data']['quantity'].toString();
      packageCount.value = data['data']['pack_quantity'].toString();
      price.value = data['data']['origin_price'].toString();
      featureType.value = data['data']['show_type'];

      getProductCharacteristics(id);
      getProductExtrasGroup(id);
      getProductExtras(id);
      getActiveExtraGroupType();
    }
  }

  Future<void> getActiveBrands(shopId) async {
    Map<String, dynamic> data = await brandsActiveRequest(shopId);
    if (data['success'] != null) {
      activeBrands.value = data['data'];
      brandId.value = data['data'][0]['id'];
    }
  }

  Future<void> getActiveExtraGroupType() async {
    Map<String, dynamic> data = await extraGroupTypeGetRequest();
    if (data['success'] != null) {
      extraGroupTypes.value = data['data'];
      extraGroupType.value = data['data'][0]['id'];
    }
  }

  Future<void> getActiveCategories(shopId) async {
    Map<String, dynamic> data = await categoriesActiveRequest(shopId);
    if (data['success'] != null) {
      activeCategories.value = data['data'];
      categoryId.value = data['data'][0]['id'];
    }
  }

  Future<void> getActiveUnits() async {
    Map<String, dynamic> data = await unitActiveRequest();
    if (data['success'] != null) {
      units.value = data['data'];
      unitId.value = data['data'][0]['id'];
    }
  }

  Future<void> getProductCharacteristics(productId) async {
    Map<String, dynamic> data =
        await productCharacterRequest(10, characters.length, productId);
    if (data['success'] != null) {
      characters.value = data['data'];
    }
  }

  Future<void> getProductExtrasGroup(productId) async {
    Map<String, dynamic> data =
        await productExtrasGroupRequest(10, extrasGroup.length, productId);
    if (data['data'] != null) {
      extrasGroup.value = data['data'];
    }
  }

  Future<void> getProductExtras(productId) async {
    Map<String, dynamic> data =
        await productExtrasRequest(10, extras.length, productId);
    if (data['data'] != null) {
      extras.value = data['data'];
    }
  }

  Future<void> saveCharacters() async {
    loading.value = true;
    Map<String, dynamic> data = await productCharacterSaveRequest(
        productId.value,
        characterKeys,
        characterValues,
        characterActive.value,
        characterId.value);

    if (data['success']) {
      loading.value = false;
      characterKeys.value = {};
      characterValues.value = {};
      Get.back();
      Get.bottomSheet(SuccessAlert(
        message: "Successfully completed",
        onClose: () {
          Get.back();
        },
      ));

      characters.value = [];
      getProductCharacteristics(productId.value);
    }
  }

  Future<void> getCharacterById(id) async {
    Map<String, dynamic> data = await productCharacterGetRequest(id);

    if (data['success']) {
      Map<String, String> keys = {};
      Map<String, String> values = {};

      for (int i = 0; i < data['data']['languages'].length; i++) {
        keys[data['data']['languages'][i]['language']['short_name']] =
            data['data']['languages'][i]['key'];
        values[data['data']['languages'][i]['language']['short_name']] =
            data['data']['languages'][i]['value'];
      }

      characterKeys.value = keys;
      characterId.value = data['data']['id'];
      characterValues.value = values;
      characterActive.value = data['data']['active'];
    }
  }

  Future<void> saveExtraGroup() async {
    loading.value = true;
    Map<String, dynamic> data = await extraGroupSaveRequest(
        productId.value,
        extraGroupName,
        extraGroupType.value,
        extraGroupActive.value,
        extrasGroupId.value);

    if (data['success']) {
      loading.value = false;
      extraGroupName.value = {};
      extraGroupType.value = extraGroupTypes[0]['id'];
      Get.back();
      Get.bottomSheet(SuccessAlert(
        message: "Successfully completed",
        onClose: () {
          Get.back();
        },
      ));

      extrasGroup.value = [];
      getProductExtrasGroup(productId.value);
    }
  }

  Future<void> getExtraGroupById(id) async {
    Map<String, dynamic> data = await extraGroupGetRequest(id);

    if (data['success']) {
      Map<String, String> name = {};

      for (int i = 0; i < data['data']['languages'].length; i++) {
        name[data['data']['languages'][i]['language']['short_name']] =
            data['data']['languages'][i]['name'];
      }

      extraGroupName.value = name;
      extrasGroupId.value = data['data']['id'];
      extraGroupType.value = data['data']['type'];
      extraGroupActive.value = data['data']['active'];
    }
  }

  @override
  void onInit() {
    loadData.value = true;
    super.onInit();
  }
}
