import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/src/components/success_alert.dart';
import 'package:vendor/src/controllers/language_controller.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/requests/category_active_taxes_request.dart';
import 'package:vendor/src/requests/category_delete_request.dart';
import 'package:vendor/src/requests/category_detail_get_request.dart';
import 'package:vendor/src/requests/category_parent_get_request.dart';
import 'package:vendor/src/requests/category_request.dart';
import 'package:vendor/src/requests/category_save_request.dart';
import 'package:vendor/src/requests/category_tax_delete_request.dart';
import 'package:vendor/src/requests/category_tax_details_get_request.dart';
import 'package:vendor/src/requests/category_taxes_save_request.dart';

class CategoryController extends GetxController {
  var category = [].obs;
  var edit = false.obs;
  var loading = false.obs;
  var tabIndex = 0.obs;
  var categoryName = <String, String>{}.obs;
  var parentCategoryId = 0.obs;
  var active = false.obs;
  var activeParentCategories = [].obs;
  var activeLanguage = "".obs;
  var search = "".obs;
  var categoryImageName = "".obs;
  var categoryId = 0.obs;
  var categoryTaxEdit = false.obs;
  var categoryTaxActive = true.obs;
  var taxes = [].obs;
  var categoryTaxes = [].obs;
  var taxId = 0.obs;
  var categoryTaxId = 0.obs;

  final ImagePicker picker = ImagePicker();

  OrderController orderController = Get.put(OrderController());
  LanguageController languageController = Get.put(LanguageController());

  Future<List> getCategory() async {
    Map<String, dynamic> data =
        await categoryRequest(10, category.length, search.value);
    if (data['success'] != 0) {
      for (int i = 0; i < data['data'].length; i++) {
        int index = category
            .indexWhere((element) => element['id'] == data['data'][i]['id']);
        if (index == -1) {
          category.add(data['data'][i]);
        }
      }
    }

    activeLanguage.value = languageController.language.value;
    getParentCategory(orderController.shopId.value);

    return category;
  }

  Future<void> getParentCategory(shopId) async {
    Map<String, dynamic> data = await categoryParentGetRequest(
      shopId,
    );
    if (data['success'] != 0) {
      activeParentCategories.value = data['data'];
      parentCategoryId.value = data['data'][0]['id'];
    }
  }

  Future<void> saveCategory() async {
    loading.value = true;
    Map<String, dynamic> data = await categorySaveRequest(
        categoryId.value,
        categoryName,
        parentCategoryId.value,
        orderController.shopId.value,
        categoryImageName.value,
        active.value);
    if (data['success'] != 0) {
      category.value = [];
      categoryName.value = {};
      categoryImageName.value = "";
      active.value = false;
      parentCategoryId.value = activeParentCategories[0]['id'];
      orderController.shopId.value = orderController.shops[0]['id'];
      Get.back();
      Get.bottomSheet(SuccessAlert(
        message: "Successfully completed",
        onClose: () {
          Get.back();
        },
      ));

      getCategory();
    }

    loading.value = false;
  }

  Future<void> getCategoryDetail(id) async {
    Map<String, dynamic> data = await categoryDetailGetRequest(id);
    if (data['success']) {
      await getParentCategory(data['data']['id_shop']);
      Map<String, String> brandNameData = {};

      categoryTaxes.value = data['data']['taxes'];

      for (int i = 0; i < data['data']['languages'].length; i++) {
        brandNameData[data['data']['languages'][i]['language']['short_name']] =
            data['data']['languages'][i]['name'] ?? "";
      }

      categoryName.value = brandNameData;
      categoryImageName.value = data['data']['image_url'];
      parentCategoryId.value = data['data']['parent'];
      orderController.shopId.value = data['data']['id_shop'];
      active.value = data['data']['active'] == 1;
      categoryId.value = data['data']['id'];
    }
  }

  Future<void> getCategoryTaxes() async {
    Map<String, dynamic> data =
        await categoriesActiveTaxesRequest(orderController.shopId.value);
    if (data['success']) {
      taxes.value = data['data'];
      if (data['data'].length > 0) taxId.value = data['data'][0]['id'];
    }
  }

  Future<void> saveCategoryTaxes() async {
    loading.value = true;
    Map<String, dynamic> data = await categoryTaxesSaveRequest(categoryId.value,
        taxId.value, categoryTaxEdit.value ? "&id=$categoryTaxId" : "");

    if (data['success']) {
      if (taxes.isNotEmpty) taxId.value = taxes[0]['id'];
      categoryId.value = 0;
      getCategoryDetail(categoryId.value);
      Get.back();
      Get.bottomSheet(SuccessAlert(
        message: "Successfully completed",
        onClose: () {
          Get.back();
        },
      ));
    }
    loading.value = false;
  }

  Future<void> getCtegoryTaxes(id) async {
    Map<String, dynamic> data = await categoryTaxGetRequest(id);
    if (data['success']) {}
  }
}
