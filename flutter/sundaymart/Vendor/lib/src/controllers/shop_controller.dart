import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/src/components/error_dialog.dart';
import 'package:vendor/src/components/success_alert.dart';
import 'package:vendor/src/controllers/language_controller.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/requests/payment_request.dart';
import 'package:vendor/src/requests/phone_prefix_request.dart';
import 'package:vendor/src/requests/shipping_box_delete_request.dart';
import 'package:vendor/src/requests/shipping_box_get_request.dart';
import 'package:vendor/src/requests/shipping_box_request.dart';
import 'package:vendor/src/requests/shop_box_request.dart';
import 'package:vendor/src/requests/shop_box_save_request.dart';
import 'package:vendor/src/requests/shop_categories_request.dart';
import 'package:vendor/src/requests/shop_deliveries_request.dart';
import 'package:vendor/src/requests/shop_deliveries_type_request.dart';
import 'package:vendor/src/requests/shop_delivery_delete_request.dart';
import 'package:vendor/src/requests/shop_delivery_get_request.dart';
import 'package:vendor/src/requests/shop_delivery_save_request.dart';
import 'package:vendor/src/requests/shop_get_request.dart';
import 'package:vendor/src/requests/shop_payment_request.dart';
import 'package:vendor/src/requests/shop_payment_save_request.dart';
import 'package:vendor/src/requests/shop_save_request.dart';
import 'package:vendor/src/requests/shop_transport_get_request.dart';
import 'package:vendor/src/requests/shop_transport_request.dart';
import 'package:vendor/src/requests/shop_transport_save_request.dart';
import 'package:vendor/src/requests/shop_transport_type_request.dart';

class ShopController extends GetxController {
  LanguageController languageController = Get.put(LanguageController());
  var activeLanguage = "en".obs;

  var activePayments = [].obs;
  var payments = {}.obs;
  var currentShopId = 0.obs;
  var shopBoxList = [].obs;
  var shopDeliveriesList = [].obs;
  var shopTransportList = [].obs;
  var shopTransportEdit = false.obs;
  var shopTransportId = 0.obs;
  var shopDeliveryEdit = false.obs;
  var shopDeliveryId = 0.obs;
  var shopBoxEdit = false.obs;
  var shopBoxId = 0.obs;
  var shopDeliveryInputs = {}.obs;
  var shopDeliveries = [].obs;
  var shopTransportInput = {}.obs;
  var transports = [].obs;
  var shippingBoxInputs = {}.obs;
  var shippingBoxs = [].obs;
  var shopId = 0.obs;
  var shopCategories = [].obs;
  var phonePrefixs = [].obs;
  var phonePrefixId = "".obs;

  var loading = false.obs;

  var shopLogoName = "".obs;
  var shopBackImageName = "".obs;
  var shopName = {}.obs;
  var shopAddress = {}.obs;
  var shopComission = "".obs;
  var shopActive = 0.obs;
  var shopCategoryId = 0.obs;
  var shopDescription = {}.obs;
  var shopInfo = {}.obs;
  var shopDeliveryRange = "".obs;
  var shopDeliveryType = 1.obs;
  var shopFeatureType = 1.obs;
  var shopIsClosed = 0.obs;
  var shopPhone = "".obs;
  var shopMobile = "".obs;
  var openHours = "".obs;
  var closeHours = "".obs;

  var markers = <MarkerId, Marker>{}.obs;
  Completer<GoogleMapController>? mapController = Completer();
  var mapCenter = {}.obs;

  final ImagePicker picker = ImagePicker();

  List type = [
    {
      "id": 1,
      "name": "Hours",
    },
    {
      "id": 2,
      "name": "Days",
    },
    {
      "id": 3,
      "name": "Km",
    },
  ];

  @override
  void onInit() {
    final box = GetStorage();
    String jwtToken = box.read('jwtToken') ?? "";
    if (jwtToken.length > 1) {
      getShopCategories();
      getActivePayments();
      getPhonePrefix();
      shopDeliveryInputs['type'] = 1;
    }
    mapCenter['latitude'] = 37.42796133580664;
    mapCenter['longitude'] = (-122.085749655962);

    activeLanguage.value = languageController.language.value;

    super.onInit();
  }

  Future<void> getPhonePrefix() async {
    Map<String, dynamic> data = await phonePrefixRequest();
    if (data['success'] && data['data'].length > 0) {
      phonePrefixs.value = data['data'];
      phonePrefixId.value = data['data'][0]['prefix'];
    }
  }

  Future<void> getShopCategories() async {
    Map<String, dynamic> data = await shopCategoriesRequest();
    if (data['success'] != null && data['data'].length > 0) {
      shopCategories.value = data['data'];
      shopCategoryId.value = data['data'][0]['id'];
    }
  }

  Future<void> getActivePayments() async {
    Map<String, dynamic> data = await paymentRequest();
    if (data['success'] != null && data['success']) {
      activePayments.value = data['data'];
    }
  }

  Future<void> getShopPayments(shopId) async {
    currentShopId.value = shopId;
    Map<String, dynamic> data = await shopPaymentRequest(shopId);

    if (data['success'] != null && data['success']) {
      for (int i = 0; i < data['data'].length; i++) {
        Map<String, dynamic> item = data['data'][i];
        payments[item['id_payment']] = {
          "payment_id": item['id_payment'],
          "private_key": item['secret_id'],
          "public_key": item['key_id'],
          "active": item['active']
        };
      }

      payments.refresh();
    }
  }

  Future<void> getShopBoxList(shopId) async {
    currentShopId.value = shopId;
    Map<String, dynamic> data = await shippingBoxRequest(shopId);

    if (data['data'] != null) {
      shopBoxList.value = data['data'];
    }
  }

  Future<void> saveShopPayment(paymentId) async {
    if (payments[paymentId] != null) {
      Map<String, dynamic> data = await shopPaymentSaveRequest(
          currentShopId.value,
          paymentId,
          payments[paymentId]['active'],
          payments[paymentId]['public_key'],
          payments[paymentId]['private_key']);

      if (data['success'] != null && data['success']) {
        Get.bottomSheet(SuccessAlert(
          message: "Successfully saved",
          onClose: () {
            Get.back();
          },
        ));
      }
    }
  }

  Future<void> getShopDeliveriesList(shopId) async {
    currentShopId.value = shopId;
    Map<String, dynamic> data = await shopDeliveryRequest(shopId);

    if (data['data'] != null) {
      shopDeliveriesList.value = data['data'];
    }
  }

  Future<void> getShopTransportList(shopId) async {
    currentShopId.value = shopId;
    Map<String, dynamic> data = await shopTransportRequest(shopId);

    if (data['data'] != null) {
      shopTransportList.value = data['data'];
    }
  }

  Future<void> saveShopDelivery() async {
    loading.value = true;
    Map<String, dynamic> data = await shopsDeliverySaveRequest(
        shopDeliveryId.value,
        currentShopId.value,
        shopDeliveryInputs['active'],
        shopDeliveryInputs['delivery_type'],
        shopDeliveryInputs['type'],
        double.parse(shopDeliveryInputs['to_day']),
        double.parse(shopDeliveryInputs['from_day']),
        double.parse(shopDeliveryInputs['price']));

    if (data['success'] != null && data['success']) {
      await getShopDeliveriesList(currentShopId.value);
      Get.back();
      loading.value = false;
      shopDeliveryInputs.value = {};
      shopDeliveries.refresh();
      Get.bottomSheet(SuccessAlert(
        message: "Successfully saved",
        onClose: () {
          Get.back();
        },
      ));
    } else {
      Get.bottomSheet(ErrorAlert(
        message: "Error happened",
        onClose: () {
          Get.back();
        },
      ));
    }
  }

  Future<void> getShopDeliveryTypes() async {
    List data = await shopDeliverytypeRequest();
    if (data.isNotEmpty) {
      shopDeliveries.value = data;
      shopDeliveryInputs['delivery_type'] = data[0]['id'];
    }
  }

  Future<void> getShoptransports() async {
    Map<String, dynamic> data = await shopTransporttypeRequest();

    if (data['data'] != null && data['data'].length > 0) {
      transports.value = data['data'];
      shopTransportInput['type'] = data['data'][0]['id'];
    }
  }

  Future<void> getShopBoxes() async {
    Map<String, dynamic> data = await shopBoxRequest();

    if (data['data'] != null && data['data'].length > 0) {
      shippingBoxs.value = data['data'];
      shippingBoxInputs['type'] = data['data'][0]['id'];
    }
  }

  Future<void> getShopDeliveryById(id) async {
    Map<String, dynamic> data = await shopDeliviryGetRequest(id);
    if (data['success'] != null && data['success']) {
      shopDeliveryInputs['delivery_type'] = data['data']['delivery_type_id'];
      shopDeliveryInputs['active'] = data['data']['active'];
      shopDeliveryInputs['to_day'] = data['data']['end'].toString();
      shopDeliveryInputs['from_day'] = data['data']['start'].toString();
      shopDeliveryInputs['type'] = data['data']['type'];
      shopDeliveryInputs['price'] = data['data']['amount'].toString();
    }
  }

  Future<void> deleteShopDeliveryById(id) async {
    Map<String, dynamic> data = await shopDeliveryDeleteRequest(id);
    if (data['success'] != null && data['success']) {
      Get.bottomSheet(SuccessAlert(
        message: "Successfully saved",
        onClose: () {
          Get.back();
        },
      ));
      await getShopDeliveriesList(currentShopId.value);
      shopDeliveries.refresh();
    }
  }

  Future<void> saveShopTransport() async {
    loading.value = true;
    Map<String, dynamic> data = await shopsTransportSaveRequest(
        shopTransportId.value,
        currentShopId.value,
        shopTransportInput['active'],
        shopTransportInput['default'],
        shopTransportInput['type'],
        double.parse(shopTransportInput['price']));

    if (data['success'] != null && data['success']) {
      await getShopTransportList(currentShopId.value);
      Get.back();
      loading.value = false;
      shopTransportInput.value = {};
      shopTransportList.refresh();
      Get.bottomSheet(SuccessAlert(
        message: "Successfully saved",
        onClose: () {
          Get.back();
        },
      ));
    } else {
      Get.bottomSheet(ErrorAlert(
        message: "Error happened",
        onClose: () {
          Get.back();
        },
      ));
    }
  }

  Future<void> getShopTransportById(id) async {
    Map<String, dynamic> data = await shopTransportGetRequest(id);
    if (data['success'] != null && data['success']) {
      shopTransportInput['type'] = data['data']['delivery_transport_id'];
      shopTransportInput['active'] = data['data']['active'];
      shopTransportInput['default'] = data['data']['default'];
      shopTransportInput['price'] = data['data']['price'].toString();
    }
  }

  Future<void> deleteShopTransportById(id) async {
    Map<String, dynamic> data = await shopDeliveryDeleteRequest(id);
    if (data['success'] != null && data['success']) {
      Get.bottomSheet(SuccessAlert(
        message: "Successfully saved",
        onClose: () {
          Get.back();
        },
      ));
      await getShopDeliveriesList(currentShopId.value);
      shopDeliveries.refresh();
    }
  }

  Future<void> saveShopBox() async {
    loading.value = true;
    Map<String, dynamic> data = await shopsBoxSaveRequest(
        shopTransportId.value,
        currentShopId.value,
        shippingBoxInputs['active'],
        shippingBoxInputs['type'],
        double.parse(shippingBoxInputs['start'].toString()),
        double.parse(shippingBoxInputs['end'].toString()),
        double.parse(shippingBoxInputs['price']));

    if (data['success'] != null && data['success']) {
      await getShopBoxList(currentShopId.value);
      Get.back();
      loading.value = false;
      shippingBoxInputs.value = {};
      shopBoxList.refresh();
      Get.bottomSheet(SuccessAlert(
        message: "Successfully saved",
        onClose: () {
          Get.back();
        },
      ));
    } else {
      Get.bottomSheet(ErrorAlert(
        message: "Error happened",
        onClose: () {
          Get.back();
        },
      ));
    }
  }

  Future<void> getShopBoxById(id) async {
    Map<String, dynamic> data = await shopBoxGetRequest(id);
    if (data['success'] != null && data['success']) {
      shippingBoxInputs['type'] = data['data']['shipping_box_id'];
      shippingBoxInputs['active'] = data['data']['active'];
      shippingBoxInputs['start'] = data['data']['start'].toString();
      shippingBoxInputs['end'] = data['data']['end'].toString();
      shippingBoxInputs['price'] = data['data']['price'].toString();
    }
  }

  Future<void> deleteShopBoxById(id) async {
    Map<String, dynamic> data = await shopBoxDeleteRequest(id);
    if (data['success'] != null && data['success']) {
      Get.bottomSheet(SuccessAlert(
        message: "Successfully saved",
        onClose: () {
          Get.back();
        },
      ));
      await getShopBoxList(currentShopId.value);
      shopBoxList.refresh();
    }
  }

  Future<void> onSaveShop() async {
    loading.value = true;
    Map<String, dynamic> params = {
      "names": shopName,
      "descriptions": shopDescription,
      "addresses": shopAddress,
      "infos": shopInfo,
      "latitude": mapCenter['latitude'],
      "longitude": mapCenter['longitude'],
      "commission": 0, //values.commission,
      "delivery_range": shopDeliveryRange.value,
      "mobile": phonePrefixId.value + "" + shopMobile.value,
      "phone": phonePrefixId.value + "" + shopPhone.value,
      // tax: values.tax,
      "delivery_type": shopDeliveryType.value,
      "feature_type": shopFeatureType.value,
      "close_hours": closeHours.value,
      "open_hours": openHours.value,
      "active": shopActive.value,
      "is_closed": shopIsClosed.value,
      "logo_url": shopLogoName.value,
      "back_image_url": shopBackImageName.value,
      "id": shopId.value,
      "shop_categories_id": shopCategoryId.value,
    };

    Map<String, dynamic> data = await shopSaveRequest(params);

    if (data['success'] != null && data['success']) {
      OrderController orderController = Get.put(OrderController());
      orderController.shops.value = [];
      orderController.shopsData.value = [];
      orderController.getShops();
      orderController.shops.refresh();

      loading.value = false;
      Get.back();
      Get.bottomSheet(SuccessAlert(
        message: "Successfully saved",
        onClose: () {
          Get.back();
        },
      ));

      shopName.value = {};
      shopDescription.value = {};
      shopAddress.value = {};
      shopDeliveryRange.value = "";
      shopMobile.value = "";
      shopPhone.value = "";
      shopDeliveryType.value = 1;
      shopFeatureType.value = 1;
      shopIsClosed.value = 0;
      shopLogoName.value = "";
      shopBackImageName.value = "";
      closeHours.value = "";
      openHours.value = "";
    } else {
      Get.bottomSheet(ErrorAlert(
        message: "Error happened",
        onClose: () {
          Get.back();
        },
      ));
    }
  }

  Future<void> getShopById(id) async {
    shopId.value = id;
    Map<String, dynamic> data = await shopGetRequest(id);

    if (data['success'] != null && data['success']) {
      shopBackImageName.value = data['data']['backimage_url'];
      shopLogoName.value = data['data']['logo_url'];
      shopDeliveryType.value = data['data']['delivery_type'];
      shopDeliveryRange.value = data['data']['delivery_range'].toString();
      shopFeatureType.value = data['data']['show_type'];
      mapCenter['latitude'] = data['data']['latitude'];
      mapCenter['longitude'] = data['data']['longtitude'];
      openHours.value = data['data']['open_hour'];
      closeHours.value = data['data']['close_hour'];
      shopActive.value = data['data']['active'];
      shopIsClosed.value = data['data']['is_closed'];

      MarkerId _markerId = const MarkerId('marker_id_0');
      Marker _marker = Marker(
        markerId: _markerId,
        position: LatLng(data['data']['latitude'], data['data']['longtitude']),
        draggable: false,
      );

      Map<MarkerId, Marker> markerData = {};
      markerData[_markerId] = _marker;

      markers.value = markerData;

      int index = phonePrefixs.indexWhere((element) {
        String prefix = element['prefix'];

        var arr = data['data']['phone'].split(prefix);

        return arr.length > 1;
      });

      if (index > -1) {
        var arr = data['data']['phone'].split(phonePrefixs[index]['prefix']);
        var arr2 = data['data']['mobile'].split(phonePrefixs[index]['prefix']);
        shopPhone.value = arr[1];
        shopMobile.value = arr2[1];
        phonePrefixId.value = phonePrefixs[index]['prefix'];
      }

      Map<String, String> shopNameStr = {};
      Map<String, String> shopDescriptionStr = {};
      Map<String, String> shopInfostr = {};
      Map<String, String> shopAddressstr = {};

      for (int i = 0; i < data['data']['languages'].length; i++) {
        shopNameStr[data['data']['languages'][i]['language']['short_name']] =
            data['data']['languages'][i]['name'] ?? "";
        shopDescriptionStr[data['data']['languages'][i]['language']
            ['short_name']] = data['data']['languages'][i]['description'] ?? "";
        shopInfostr[data['data']['languages'][i]['language']['short_name']] =
            data['data']['languages'][i]['info'] ?? "";
        shopAddressstr[data['data']['languages'][i]['language']['short_name']] =
            data['data']['languages'][i]['address'] ?? "";
      }

      shopName.value = shopNameStr;
      shopDescription.value = shopDescriptionStr;
      shopInfo.value = shopInfostr;
      shopAddress.value = shopAddressstr;
    }
  }
}
