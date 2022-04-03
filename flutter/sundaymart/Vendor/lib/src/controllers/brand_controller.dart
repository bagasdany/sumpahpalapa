import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/src/components/success_alert.dart';
import 'package:vendor/src/controllers/language_controller.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/requests/brand_category_active_request.dart';
import 'package:vendor/src/requests/brand_category_detail_get_request.dart';
import 'package:vendor/src/requests/brand_category_request.dart';
import 'package:vendor/src/requests/brand_category_save_request.dart';
import 'package:vendor/src/requests/brand_detail_get_request.dart';
import 'package:vendor/src/requests/brand_request.dart';
import 'package:vendor/src/requests/brand_save_request.dart';

class BrandController extends GetxController {
  OrderController orderController = Get.put(OrderController());
  LanguageController languageController = Get.put(LanguageController());
  var brandCategories = [].obs;
  var brand = [].obs;
  var edit = false.obs;
  var activeBrandCategories = [].obs;
  var brandCategoryId = 0.obs;
  var brandName = "".obs;
  var brandImage = "".obs;
  var loading = false.obs;
  var active = false.obs;
  var brandId = 0.obs;

  var brandCategoryName = <String, String>{}.obs;
  var brandCategoryMId = 0.obs;
  var activeLanguage = "".obs;
  var search = "".obs;

  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    final box = GetStorage();
    String jwtToken = box.read('jwtToken') ?? "";
    if (jwtToken.length > 1) {
      getActiveBrandCategories();
    }
    super.onInit();
  }

  Future<List> getBrandCategories() async {
    Map<String, dynamic> data =
        await brandsCategoryRequest(10, brandCategories.length);
    if (data['success'] != 0) {
      for (int i = 0; i < data['data'].length; i++) {
        int index = brandCategories
            .indexWhere((element) => element['id'] == data['data'][i]['id']);
        if (index == -1) {
          brandCategories.add(data['data'][i]);
        }
      }
    }

    activeLanguage.value = languageController.language.value;

    return brandCategories;
  }

  Future<List> getBrands() async {
    Map<String, dynamic> data =
        await brandsRequest(10, brand.length, search.value);
    if (data['success'] != 0) {
      for (int i = 0; i < data['data'].length; i++) {
        int index = brand
            .indexWhere((element) => element['id'] == data['data'][i]['id']);
        if (index == -1) {
          brand.add(data['data'][i]);
        }
      }
    }

    getActiveBrandCategories();

    return brand;
  }

  Future<void> getActiveBrandCategories() async {
    Map<String, dynamic> data = await brandsCategoryActiveRequest();
    if (data['success'] != null && data['data'].length > 0) {
      activeBrandCategories.value = data['data'];
      brandCategoryId.value = data['data'][0]['id'];
    }
  }

  Future<void> brandSave() async {
    loading.value = true;
    Map<String, dynamic> data = await brandSaveRequest(
        brandId.value,
        brandCategoryId.value,
        brandName.value,
        orderController.shopId.value,
        brandImage.value,
        active.value);

    if (data['success']) {
      brand.value = [];
      brandName.value = "";
      active.value = false;
      brandImage.value = "";
      brandId.value = 0;
      brandCategoryId.value = activeBrandCategories[0]['id'];
      orderController.shopId.value = orderController.shops[0]['id'];
      Get.back();
      Get.bottomSheet(SuccessAlert(
        message: "Successfully completed",
        onClose: () {
          Get.back();
        },
      ));

      getBrands();
    }

    loading.value = false;
  }

  Future<void> brandCategorySave() async {
    loading.value = true;
    Map<String, dynamic> data = await brandCategorySaveRequest(
        brandCategoryMId.value, brandCategoryName, active.value);

    if (data['success'] != null && data['success'] != 0) {
      brandCategories.value = [];
      brandCategoryName.value = {};
      active.value = false;
      brandCategoryMId.value = 0;
      Get.back();
      Get.bottomSheet(SuccessAlert(
        message: "Successfully completed",
        onClose: () {
          Get.back();
        },
      ));

      getBrandCategories();
    }

    loading.value = false;
  }

  Future<void> getBrandDetail(id) async {
    Map<String, dynamic> data = await brandDetailGetRequest(id);
    if (data['success']) {
      brandImage.value = data['data']['image_url'];
      brandCategoryId.value = data['data']['id_brand_category'];
      orderController.shopId.value = data['data']['id_shop'];
      brandName.value = data['data']['name'];
      active.value = data['data']['active'] == 1;
      brandId.value = data['data']['id'];
    }
  }

  Future<void> getBrandCategoryDetail(id) async {
    Map<String, dynamic> data = await brandCategoryDetailGetRequest(id);
    if (data['success']) {
      Map<String, String> brandNameData = {};

      for (int i = 0; i < data['data']['languages'].length; i++) {
        brandNameData[data['data']['languages'][i]['language']['short_name']] =
            data['data']['languages'][i]['name'];
      }

      brandCategoryName.value = brandNameData;
      active.value = data['data']['active'] == 1;
      brandCategoryMId.value = data['data']['id'];
    }
  }
}
