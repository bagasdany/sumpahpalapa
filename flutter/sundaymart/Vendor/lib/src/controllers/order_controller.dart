import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vendor/src/components/error_dialog.dart';
import 'package:vendor/src/components/success_alert.dart';
import 'package:vendor/src/controllers/shop_controller.dart';
import 'package:vendor/src/requests/address_get_request.dart';
import 'package:vendor/src/requests/clients_request.dart';
import 'package:vendor/src/requests/delivery_boys_request.dart';
import 'package:vendor/src/requests/extras_get_request.dart';
import 'package:vendor/src/requests/order_detail_get_request.dart';
import 'package:vendor/src/requests/order_save_request.dart';
import 'package:vendor/src/requests/order_status_request.dart';
import 'package:vendor/src/requests/orders_get_request.dart';
import 'package:vendor/src/requests/orders_request.dart';
import 'package:vendor/src/requests/payment_method_request.dart';
import 'package:vendor/src/requests/payment_status_request.dart';
import 'package:vendor/src/requests/product_active_request.dart';
import 'package:vendor/src/requests/shipping_box_request.dart';
import 'package:vendor/src/requests/shipping_plan_request.dart';
import 'package:vendor/src/requests/shipping_transport_request.dart';
import 'package:vendor/src/requests/shops_data_request.dart';
import 'package:vendor/src/requests/shops_request.dart';
import 'package:vendor/src/requests/time_unit_request.dart';
import 'package:vendor/src/requests/transaction_send_request.dart';

class OrderController extends GetxController {
  var loading = false.obs;
  var orders = [].obs;
  var productList = [].obs;
  var newOrdersCount = 0.obs;
  var activeOrder = {}.obs;
  var activeOrderDetail = {}.obs;
  var clients = [].obs;
  var addresses = [].obs;
  var orderStatuses = [].obs;
  var paymentStatuses = [].obs;
  var paymentMethods = [].obs;
  var deliveryTimes = [].obs;
  var deliveryDates = [].obs;
  var deliveryBoys = [].obs;
  var shippingPlans = [].obs;
  var shippingTransports = [].obs;
  var shippingBoxs = [].obs;
  var productActive = [].obs;
  var shops = [].obs;
  var edit = false.obs;
  late TextEditingController orderCommentController;
  late TextEditingController deliveryBoyCommentController;
  var orderTabIndex = 0.obs;
  var shopTabIndex = 0.obs;

  var orderId = 0.obs;
  var clientId = 0.obs;
  var shopId = 0.obs;
  var addressId = 0.obs;
  var orderTotal = RxDouble(0);
  var total = RxDouble(0);
  var discountTotal = RxDouble(0);
  var tax = RxDouble(0);
  var shopTax = RxDouble(0);
  var deliveryFee = RxDouble(0);
  var orderStatusId = 0.obs;
  var paymentStatusId = 0.obs;
  var paymentMethodId = 0.obs;
  var orderComment = "".obs;
  var deliveryDate = "".obs;
  var tempDeliveryDate = "".obs;
  var dateName = "".obs;
  var deliveryTimeId = 0.obs;
  var deliveryBoyId = 0.obs;
  var deliveryTypeId = 1.obs;
  var shippingPlanId = 0.obs;
  var shippingTransportId = 0.obs;
  var shippingBoxId = 0.obs;
  var productActiveId = 0.obs;
  var replaceProductId = 0.obs;
  var couponAmount = RxDouble(0);
  var search = "".obs;

  var activeCartIndex = 0.obs;
  var carts = [].obs;
  var tempExtrasState = [].obs;
  var shopsData = [].obs;
  var shopEditId = 0.obs;
  var loadData = false.obs;

  ShopController shopController = Get.put(ShopController());
  ScrollController orderScrollController = ScrollController();

  List<Color> statusColors = [
    const Color.fromRGBO(53, 105, 184, 1),
    const Color.fromRGBO(0, 0, 0, 1),
    const Color.fromRGBO(241, 146, 4, 1),
    const Color.fromRGBO(22, 170, 22, 1),
    const Color.fromRGBO(210, 18, 52, 1)
  ];

  Future<List> getOrders(int status) async {
    if (loadData.value) {
      Map<String, dynamic> data =
          await ordersRequest(status, 10, orders.length, search.value);

      if (data['success'] != 0) {
        if (data['data'] != null) {
          for (int i = 0; i < data['data'].length; i++) {
            int index = orders.indexWhere(
                (element) => element['id'] == data['data'][i]['id']);
            if (index == -1) {
              orders.add(data['data'][i]);
            }
          }

          if (status == 1) newOrdersCount.value = orders.length;

          loadData.value = false;
        }
      }
    }

    return orders;
  }

  Future<void> getOrderDetail(id) async {
    Map<String, dynamic> data = await ordersGetRequest(id);

    activeOrderDetail.value = data['data'];
    clientId.value = data['data']['id_user'];
    addressId.value = data['data']['id_delivery_address'];
    total.value = double.parse(data['data']['total_sum'].toString());
    deliveryFee.value = double.parse(data['data']['delivery_fee'].toString());
    discountTotal.value =
        double.parse(data['data']['total_discount'].toString());
    tax.value = double.parse(data['data']['tax'].toString());
    orderStatusId.value = data['data']['order_status'];
    shopId.value = data['data']['id_shop'];
    orderId.value = data['data']['id'];
    orderComment.value = data['data']['comment'];
  }

  Future<void> getOrderClients() async {
    Map<String, dynamic> data = await clientsRequest();

    if (data['data'] != null && data['data'].length > 0) {
      clients.value = data['data'];
      clientId.value = data['data'][0]['id'];
    }

    if (clientId.value > 0) {
      getClientAddresses(clientId.value);
    } else {
      if (data['data'] != null && data['data'].length > 0) {
        getClientAddresses(data['data'][0]['id']);
      }
    }
  }

  Future<void> getClientAddresses(id) async {
    Map<String, dynamic> data = await addressGetRequest(id);

    addresses.value = data['data'];
    if (data['data'] != null && data['data'].length > 0) {
      addressId.value = data['data'][0]['id'];
    }
    addresses.refresh();
    update();
  }

  Future<void> getPaymentStatus() async {
    Map<String, dynamic> data = await paymentStatusRequest();

    paymentStatuses.value = data['data'];
    if (data['data'] != null && data['data'].length > 0) {
      paymentStatusId.value = data['data'][0]['id'];
    }
  }

  Future<void> getPaymentMethod(shopId) async {
    Map<String, dynamic> data = await paymentMethodRequest(shopId);

    paymentMethods.value = data['data'];
    if (data['data'] != null && data['data'].length > 0) {
      paymentMethodId.value = data['data'][0]['id'];
    }
  }

  Future<void> getOrderStatus() async {
    Map<String, dynamic> data = await orderStatusRequest();

    orderStatuses.value = data['data'];
    if (data['data'] != null && data['data'].length > 0) {
      orderStatusId.value = data['data'][0]['id'];
    }
  }

  void setActiveOrder(order) {
    activeOrder.value = order;
    orderStatusId.value = order['order_status_id'];
    total.value = double.parse(order['amount'].toString());

    getOrderDetail(order['id']);
  }

  Future<List> getShops() async {
    shops.value = [];
    Map<String, dynamic> data = await shopsRequest();
    if (data['success'] != null) {
      if (data['data'] != null) {
        shops.value = data['data'];
        shopId.value = data['data'][0]['id'];
        getPaymentMethod(data['data'][0]['id']);
        getDeliveryTimes(data['data'][0]['id']);
        getDeliveryboys(data['data'][0]['id']);
        await getShippingBox(data['data'][0]['id']);
        await getShippingPlan(data['data'][0]['id']);
        await getShippingTransport(data['data'][0]['id']);
        getActiveProduct(data['data'][0]['id']);

        if (carts.isEmpty) addNewCart();

        calculateShipping(shippingPlanId.value, shippingBoxId.value,
            shippingTransportId.value);
      }
    }

    return shops;
  }

  Future<List> getDeliveryTimes(shopId) async {
    Map<String, dynamic> data = await timeUnitRequest(shopId);
    if (data['success'] != 0) {
      if (data['data'] != null) {
        deliveryTimes.value = data['data'];
        deliveryTimeId.value = data['data'][0]['id'];
      }
    }

    return shops;
  }

  Future<List> getActiveProduct(shopId) async {
    Map<String, dynamic> data = await productActiveRequest(shopId);
    if (data['success'] != 0) {
      if (data['data'] != null) {
        productActive.value = data['data'];
        productActiveId.value = data['data'][0]['id'];
        replaceProductId.value = data['data'][0]['id'];
      }
    }

    return shops;
  }

  Future<List> getDeliveryboys(shopId) async {
    Map<String, dynamic> data = await deliveryBoysRequest(shopId);
    if (data['success'] != 0) {
      if (data['data'] != null) {
        deliveryBoys.value = data['data'];
        if (!edit.value) deliveryBoyId.value = data['data'][0]['id'];
        deliveryBoys.insert(0, {"id": -1, "name": "-", "surname": ""});
      }
    }

    return shops;
  }

  Future<List> getShippingPlan(shopId) async {
    Map<String, dynamic> data = await shippingPlanRequest(shopId);
    if (data['success'] != 0) {
      if (data['data'] != null) {
        shippingPlans.value = data['data'];
        if (!edit.value && data['data'].length > 0) {
          shippingPlanId.value = data['data'][0]['id'];
        }
        shippingPlans.insert(0, {
          "id": -1,
          "delivery_type": {"name": "No shipping plan"}
        });
      }
    }

    return shops;
  }

  Future<List> getShippingTransport(shopId) async {
    Map<String, dynamic> data = await shippingTransportRequest(shopId);
    if (data['success'] != 0) {
      if (data['data'] != null) {
        shippingTransports.value = data['data'];
        if (!edit.value && data['data'].length > 0) {
          shippingTransportId.value = data['data'][0]['id'];
        }
        shippingTransports.insert(0, {
          "id": -1,
          "delivery_transport": {"name": "No transport"}
        });
      }
    }

    return shops;
  }

  Future<List> getShippingBox(shopId) async {
    Map<String, dynamic> data = await shippingBoxRequest(shopId);
    if (data['success'] != 0) {
      if (data['data'] != null) {
        shippingBoxs.value = data['data'];
        if (!edit.value && data['data'].length > 0) {
          shippingBoxId.value = data['data'][0]['id'];
        }
        shippingBoxs.insert(0, {
          "id": -1,
          "shipping_box": {"name": "No shipping box"}
        });
      }
    }

    return shops;
  }

  void getDeliveryDatesList() {
    List deliveryDatesData = [];
    final now = DateTime.now();

    for (int i = 0; i < 6; i++) {
      final day = DateTime(now.year, now.month, now.day + i);
      deliveryDatesData.add("${day.year}-${day.month}-${day.day}");

      if (i == 0) deliveryDate.value = "${day.year}-${day.month}-${day.day}";
    }

    deliveryDates.value = deliveryDatesData;
  }

  @override
  void onInit() {
    final box = GetStorage();
    String jwtToken = box.read('jwtToken') ?? "";
    if (jwtToken.length > 1) {
      getData();
    }

    orderCommentController = TextEditingController();
    deliveryBoyCommentController = TextEditingController();

    loadData.value = true;

    super.onInit();
  }

  Future<void> getData() async {
    getOrderClients();
    getOrderStatus();
    getShops();
    getPaymentStatus();
    getDeliveryDatesList();
  }

  Future<void> getInfoById(id) async {
    productList.clear();
    Map<String, dynamic> data = await orderDetailGetRequest(id);
    if (data['success']) {
      Map<String, dynamic> order = data['data'];
      //String orderComment = data['data']["comment"];
      List orderDetail = data['data']["details"];

      getActiveProduct(order['id_shop']);
      getDeliveryTimes(order['id_shop']);
      getDeliveryboys(order['id_shop']);
      getShippingBox(order['id_shop']);
      getShippingTransport(order['id_shop']);
      getShippingPlan(order['id_shop']);
      getPaymentMethod(order['id_shop']);
      getClientAddresses(order['id_user']);

      for (int i = 0; i < orderDetail.length; i++) {
        var extras = orderDetail[i]['extras'].map((item) {
          return {
            "extras_group_id": item['id_extras_group'],
            "id": item['id_extras'],
            "extras_name": item['language']['name'],
            "price": item['price']
          };
        }).toList();

        var extrasAmount =
            orderDetail[i]['extras'].fold(0, (t, e) => t + e['price']);

        double productTax = ((orderDetail[i]['price'] +
                    extrasAmount -
                    orderDetail[i]['discount']) *
                orderDetail[i]['product']['taxes'].fold(
                  0,
                  (previousValue, currentValue) =>
                      previousValue + currentValue["percent"],
                )) /
            100;

        Map<String, dynamic> productObject = {
          "id": orderDetail[i]['id_product'],
          "name": orderDetail[i]['name'].length >= 50
              ? orderDetail[i]['name'].toString().substring(0, 50)
              : orderDetail[i]['name'],
          "price": orderDetail[i]['price'],
          "price_with_extras": orderDetail[i]['price'] + extrasAmount,
          "tax": productTax,
          "taxes": orderDetail[i]['taxes'],
          "in_stock": orderDetail[i]['quantity'],
          "discount_type": orderDetail[i]['product']['discount'] != null
              ? orderDetail[i]['product']['discount']['discount_type']
              : 0,
          "discount_amount": orderDetail[i]['product']['discount'] != null
              ? orderDetail[i]['product']['discount']['discount_amount']
              : 0,
          "discount": orderDetail[i]['discount'],
          "price_total": (orderDetail[i]['price'] + extrasAmount) *
              orderDetail[i]['quantity'],
          "discount_total":
              orderDetail[i]['discount'] * orderDetail[i]['quantity'],
          "total": (orderDetail[i]['price'] +
                  extrasAmount -
                  orderDetail[i]['discount']) *
              orderDetail[i]['quantity'],
          "quantity": orderDetail[i]['quantity'],
          "options": {
            "replace": orderDetail[i]['is_replaced'] != 1 ? 1 : null,
            "delete": orderDetail[i]['is_replaced'] != 1 ? 1 : null,
          },
          "extras": extras ?? []
        };

        productList.add(productObject);
      }

      shippingPlanId.value =
          order['delivery_type'] != null ? order['delivery_type']['id'] : -1;
      shippingTransportId.value = order['delivery_transport'] != null
          ? order['delivery_transport']['id']
          : -1;
      shippingBoxId.value =
          order['delivery_box'] != null ? order['delivery_box']['id'] : -1;
      orderStatusId.value = order['order_status'];
      if (order['payment_method'] != null) {
        paymentMethodId.value = order['payment_method'];
      }
      if (order['payment_status'] != null) {
        paymentStatusId.value = order['payment_status'];
      }
      clientId.value = order['id_user'];
      addressId.value = order['id_delivery_address'];
      shopId.value = order['id_shop'];
      deliveryBoyId.value = order['delivery_boy'] ?? 0;
      deliveryTypeId.value = order['type'];
      deliveryDate.value = order['delivery_date'];

      int index =
          deliveryDates.indexWhere((item) => item == order['delivery_date']);
      if (index == -1) deliveryDates.add(order['delivery_date']);

      calculateShipping(
          shippingPlanId.value, shippingBoxId.value, shippingTransportId.value);
    }
  }

  Future<void> orderSave() async {
    loading.value = true;
    if (couponAmount.value > 0) {
      couponAmount.value = 0;
    }
    Map<String, dynamic> body = {
      "id": orderId.value,
      "total_amount": (total.value * 1 + shopTax.value * 1).toStringAsFixed(2),
      "delivery_time_id": deliveryTimeId.value,
      "delivery_date": deliveryDate.value,
      "id_user": clientId.value,
      "id_delivery_address": addressId.value,
      "id_shop": shopId.value,
      "id_shipping": shippingPlanId.value,
      "id_shipping_transport": shippingTransportId.value,
      "id_shipping_box": shippingBoxId.value,
      "product_details": productList.map((element) {
        return {
          "extras":
              element['extras'].length > 0 ? element['extras'].toList() : [],
          "id": element['id'],
          "price": element["price"],
          "discount": element["discount"],
          "quantity": element["quantity"],
          "id_replace_product": element["id_replace_product"],
          "is_replaced": element['is_replaced']
        };
      }).toList(),
      "order_status": orderStatusId.value,
      "type": deliveryTypeId.value,
      "payment_status": paymentStatusId.value,
      "comment": orderComment.value,
      "payment_method": paymentMethodId.value,
      "total_discount": discountTotal.value.toStringAsFixed(2),
      "delivery_boy_comment": deliveryBoyCommentController.text,
      "delivery_boy": deliveryBoyId.value,
      "tax": (tax * 1 + shopTax * 1).toStringAsFixed(2),
      "delivery_fee": deliveryFee.value,
      "coupon": couponAmount.value
    };

    Map<String, dynamic> data = await orderSaveRequest(body);

    if (data['success'] != null && !data['success']) {
      Get.bottomSheet(ErrorAlert(
        message: data['message'],
        onClose: () {
          Get.back();
        },
      ));
    }

    if (data['data'] != null &&
        data['data']['missed_products'] != null &&
        data['data']['missed_products'].length > 0) {
      Get.bottomSheet(ErrorAlert(
        message: "Some products are out of stock",
        onClose: () {
          Get.back();
        },
      ));
    }

    if (data['success'] != null) {
      if (data['success']) {
        edit.value = false;
        orders.value = [];
        productList.clear();
        loadData.value = true;
        getOrders(orderTabIndex.value);
        if (orderId.value > 0) {
          Get.back();
        }
        Get.back();
        Get.bottomSheet(SuccessAlert(
          message: "Successfully completed",
          onClose: () {
            Get.back();
          },
        ));
        getOrderClients();
        getOrderStatus();
        getShops();
        getPaymentStatus();
        getDeliveryDatesList();
        orderId.value = 0;
      }

      loadData.value = true;
      loading.value = false;
    } else {
      loading.value = false;
      Get.bottomSheet(ErrorAlert(
        message: data['message'],
        onClose: () {
          Get.back();
        },
      ));
    }
  }

  deleteProduct(id) {
    int index = productList.indexWhere((val) => val['id'] == id);
    if (index > -1) {
      for (int i = 0; i < productList.length; i++) {
        if (productList[i]["id_replace_product"] == id) {
          productList.removeAt(i);
        }

        if (productList[i]["id"] == id ||
            productList[i]["id"] == productList[index]["id_replace_product"]) {
          productList.removeAt(i);
        }
      }

      calculateShipping(
          shippingPlanId.value, shippingBoxId.value, shippingTransportId.value);
    }
  }

  onDecrement(id) {
    int index = productList.indexWhere((val) => val['id'] == id);
    if (index > -1) {
      List productDetails = productList;
      if (productDetails[index]['quantity'] > 1) {
        productDetails[index]['quantity'] -= 1;
        productDetails[index]['price_total'] = (productDetails[index]
                ['price_with_extras'] *
            productDetails[index]['quantity']);
        productDetails[index]['discount_total'] = (productDetails[index]
                ['discount'] *
            productDetails[index]['quantity']);
        productDetails[index]['total'] = ((productDetails[index]
                    ['price_with_extras'] -
                productDetails[index]['discount']) *
            productDetails[index]['quantity']);

        productList[index] = productDetails[index];
        calculateShipping(shippingPlanId.value, shippingBoxId.value,
            shippingTransportId.value);
      }
    }
  }

  onIncrement(id) {
    int index = productList.indexWhere((val) => val['id'] == id);

    if (index > -1) {
      List productDetails = productList;
      productDetails[index]['quantity'] += 1;
      productDetails[index]['price_total'] = (productDetails[index]
              ['price_with_extras'] *
          productDetails[index]['quantity']);
      productDetails[index]['discount_total'] = (productDetails[index]
              ['discount'] *
          productDetails[index]['quantity']);
      productDetails[index]['total'] = ((productDetails[index]
                  ['price_with_extras'] -
              productDetails[index]['discount']) *
          productDetails[index]['quantity']);

      productList[index] = productDetails[index];

      calculateShipping(
          shippingPlanId.value, shippingBoxId.value, shippingTransportId.value);
    }
  }

  void onSelectProduct(productId) {
    var index =
        productActive.indexWhere((element) => element['id'] == productId);
    if (index > -1) {
      double productTax = ((productActive[index]['price'] -
                  ((productActive[index]['discount'] == null ||
                          productActive[index]['discount']['discount_type'] ==
                              0)
                      ? 0
                      : productActive[index]['discount']['discount_type'] == 1
                          ? (double.parse(productActive[index]['discount']
                                          ['discount_amount']
                                      .toString()) *
                                  double.parse(productActive[index]['price']
                                      .toString())) /
                              100
                          : productActive[index]['discount']
                              ['discount_amount'])) *
              productActive[index]['taxes']
                  .fold(0, (t, e) => t + e['percent'])) /
          100;

      double discount = ((productActive[index]['discount'] == null ||
              productActive[index]['discount']['discount_type'] == 0)
          ? 0
          : productActive[index]['discount']['discount_type'] == 1
              ? (double.parse(productActive[index]['discount']
                              ['discount_amount']
                          .toString()) *
                      double.parse(productActive[index]['price'].toString())) /
                  100
              : productActive[index]['discount']['discount_amount'] * 1);

      Map<String, dynamic> productObject = {
        "id": productActive[index]['id'],
        "name": productActive[index]['name'].length >= 50
            ? productActive[index]['name'].toString().substring(0, 50)
            : productActive[index]['name'],
        "price": productActive[index]['price'],
        "price_with_extras": productActive[index]['price'],
        "tax": productTax,
        "taxes": productActive[index]['taxes'],
        "in_stock": productActive[index]['quantity'],
        "discount_type": productActive[index]['discount'] != null
            ? productActive[index]['discount']['discount_type']
            : 0,
        "discount_amount": productActive[index]['discount'] != null
            ? productActive[index]['discount']['discount_amount']
            : 0,
        "discount": discount,
        "price_total": productActive[index]['price'],
        "discount_total": discount,
        "total": (productActive[index]['price'] - discount),
        "quantity": 1,
        "options": {
          "replace": 1,
          "delete": 1,
        },
        "extras": []
      };

      int idx = productList.indexWhere((element) => element['id'] == productId);

      if (idx == -1) {
        productList.add(productObject);

        calculateShipping(shippingPlanId.value, shippingBoxId.value,
            shippingTransportId.value);
      }
    }
  }

  void handleOk() {
    int index = productActive
        .indexWhere((element) => element['id'] == productActiveId.value);
    int replacedIndex = productList
        .indexWhere((element) => element['id'] == replaceProductId.value);
    int idx =
        productList.indexWhere((item) => item["id"] == productActiveId.value);
    if (idx == -1) {
      for (int i = 0; i < productList.length; i++) {
        if (productList[i]["id"] == replaceProductId.value) {
          productList[i]['is_replaced'] = 1;
          productList[i]['id_replace_product'] = null;
        }
      }

      if (index > -1) {
        double productTax = ((productActive[index]['price'] -
                    ((productActive[index]['discount'] == null ||
                            productActive[index]['discount']['discount_type'] ==
                                0)
                        ? 0
                        : productActive[index]['discount']['discount_type'] == 1
                            ? (productActive[index]['discount']
                                        ['discount_amount'] *
                                    productActive[index]['price']) /
                                100
                            : productActive[index]['discount']
                                ['discount_amount'])) *
                productActive[index]['taxes']
                    .fold(0, (t, e) => t + e['percent'])) /
            100;

        double discount = ((productActive[index]['discount'] == null ||
                productActive[index]['discount']['discount_type'] == 0)
            ? 0
            : productActive[index]['discount']['discount_type'] == 1
                ? (double.parse(productActive[index]['discount']
                                ['discount_amount']
                            .toString()) *
                        double.parse(productActive[index]['price_with_extras']
                            .toString())) /
                    100
                : productActive[index]['discount']['discount_amount'] * 1);

        Map<String, dynamic> productObject = {
          "id": productActive[index]['id'],
          "name": productActive[index]['name'].length >= 50
              ? productActive[index]['name'].toString().substring(0, 50)
              : productActive[index]['name'],
          "price": productActive[index]['price'],
          "price_with_extras": productActive[index]['price'],
          "tax": productTax,
          "taxes": productActive[index]['taxes'],
          "in_stock": productActive[index]['quantity'],
          "discount_type": productActive[index]['discount'] != null
              ? productActive[index]['discount']['discount_type']
              : 0,
          "discount_amount": productActive[index]['discount'] != null
              ? productActive[index]['discount']['discount_amount']
              : 0,
          "discount": discount,
          "price_total": productActive[index]['price'] *
              productList[replacedIndex]['quantity'],
          "discount_total": (discount * productList[replacedIndex]['quantity']),
          "total": ((productActive[index]['price'] - discount) *
              productList[replacedIndex]['quantity']),
          "quantity": productList[replacedIndex]['quantity'],
          "is_replaced": null,
          "id_replace_product": replaceProductId.value,
          "options": {
            "delete": 1,
          },
          "extras": []
        };

        productList.add(productObject);

        calculateShipping(shippingPlanId.value, shippingBoxId.value,
            shippingTransportId.value);
      }
    } else {}
  }

  void addExtrasToProduct(
      productId, extrasGroupId, extrasId, extrasName, price) {
    int productIndex =
        productList.indexWhere((item) => item['id'] == productId);
    if (productIndex > -1) {
      List extrases = productList[productIndex]['extras'];
      var index = extrases
          .indexWhere((item) => item['extras_group_id'] == extrasGroupId);

      var extras = {
        "extras_group_id": extrasGroupId,
        "id": extrasId,
        "extras_name": extrasName,
        "price": price
      };

      if (index == -1) {
        productList[productIndex]['extras'].add(extras);
      } else {
        productList[productIndex]['extras'][index] = extras;
      }

      productList[productIndex]['price_with_extras'] = calculatePriceWithExtras(
          productList[productIndex], productList[productIndex]['extras']);

      double discount = ((productList[productIndex]['discount'] == null ||
              productList[productIndex]['discount_type'] == 0)
          ? 0
          : productList[productIndex]['discount_type'] == 1
              ? (double.parse(productList[productIndex]['discount_amount']
                          .toString()) *
                      double.parse(productList[productIndex]
                              ['price_with_extras']
                          .toString())) /
                  100
              : productList[productIndex]['discount_amount'] * 1);

      productList[productIndex]['discount'] = discount;
      productList[productIndex]['price_total'] = productList[productIndex]
              ['price_with_extras'] *
          productList[productIndex]['quantity'];
      productList[productIndex]['discount_total'] = (productList[productIndex]
              ['discount'] *
          productList[productIndex]['quantity']);
      productList[productIndex]['total'] =
          ((productList[productIndex]['price_with_extras'] * 1 -
                  productList[productIndex]['discount'] * 1) *
              productList[productIndex]['quantity']);

      productList.refresh();
      calculateShipping(
          shippingPlanId.value, shippingBoxId.value, shippingTransportId.value);
    }
  }

  void calculateShipping(shippingId, shippingBoxId, shippingTransportId) {
    var index = shippingPlans.indexWhere((item) => item['id'] == shippingId);
    var price = index != -1 && shippingId != -1
        ? shippingPlans[index]['amount'] * 1
        : 0;

    var index2 =
        shippingBoxs.indexWhere((element) => element['id'] == shippingBoxId);
    var price2 = index2 != -1 && shippingBoxId != -1
        ? shippingBoxs[index2]['price'] * 1
        : 0;

    var index3 = shippingTransports
        .indexWhere((item) => item['id'] == shippingTransportId);
    var price3 = index3 != -1 && shippingTransportId != -1
        ? shippingTransports[index3]['price'] * 1
        : 0;

    double totalAmount = productList.fold(0, (t, e) {
      if (e['is_replaced'] == 1) return t * 1;
      return t + e['price_total'];
    });

    double totalDiscount = productList.fold(0, (t, e) {
      if (e['is_replaced'] == 1) return t * 1;
      return t + e['discount_total'];
    });
    double totalTax = productList.fold(0, (t, e) {
      if (e['is_replaced'] == 1) return t * 1;
      return t + e['tax'] * e['quantity'];
    });

    totalAmount = double.parse(totalAmount.toStringAsFixed(2));
    totalDiscount = double.parse(totalDiscount.toStringAsFixed(2));
    double deliveryFeeAmount = deliveryTypeId.value == 1
        ? double.parse((price + price3 + price2).toString())
        : 0;

    orderTotal.value = totalAmount;
    discountTotal.value = totalDiscount;
    tax.value = double.parse(totalTax.toStringAsFixed(2));
    total.value = (totalAmount -
        totalDiscount +
        double.parse(totalTax.toStringAsFixed(2)) +
        double.parse(deliveryFeeAmount.toStringAsFixed(2)));

    deliveryFee.value = deliveryFeeAmount;

    setShopTax(double.parse((totalAmount - totalDiscount).toStringAsFixed(2)));
  }

  void setShopTax(amount) {
    int index = shops.indexWhere((item) => item['id'] == shopId.value);
    if (index > -1) {
      double tax = double.parse(
          shops[index]["taxes"].fold(0, (t, e) => t + e['percent']).toString());

      double shopTaxDate = double.parse(((amount * tax) / 100).toString());

      shopTax.value = shopTaxDate;
    }
  }

  void addNewCart() {
    if (carts.length < 4) {
      carts.add({
        "shop_id": shopId.value,
        "products": [],
        "amount": 0,
        "total_amount": 0,
        "tax": 0,
        "total_discount": 0,
        "delivery_fee": 0,
        "client_id": 0,
        "delivery_address_id": 0,
      });
      activeCartIndex.value = carts.length - 1;
      update();
    }
  }

  double calculatePriceWithExtras(product, extras) {
    return double.parse(double.parse((product['price'] * 1 +
                extras.fold(
                      0,
                      (previousValue, currentValue) =>
                          previousValue + currentValue['price'],
                    ) *
                    1)
            .toString())
        .toStringAsFixed(2));
  }

  void addProductToCart(product) {
    if (carts.isEmpty || carts[activeCartIndex.value] == null) {
      Get.bottomSheet(ErrorAlert(
        message: "Please, select cart",
        onClose: () {
          Get.back();
        },
      ));
    } else {
      int index = carts[activeCartIndex.value]['products']
          .indexWhere((item) => item['id'] == product['id']);
      if (index == -1) {
        double taxes = double.parse((product["taxes"].fold(
          0,
          (cal, val) => cal + val["percent"],
        )).toString());

        double discount = double.parse((product['actual_discount'] == null
                ? 0
                : product['actual_discount']['discount_type'] == 0
                    ? 0
                    : product['actual_discount']['discount_type'] == 1
                        ? (double.parse(product['actual_discount']
                                        ['discount_amount']
                                    .toString()) *
                                double.parse(product['price'].toString())) /
                            100
                        : product['actual_discount']['discount_amount'])
            .toString());

        double price = product['extras'] != null
            ? calculatePriceWithExtras(product, product['extras'] ?? [])
            : double.parse(product['price'].toString());

        Map<String, dynamic> data = {
          ...product,
          "qty": 1,
          "price_with_extras": price,
          "discount": discount,
          "tax": ((taxes * (price - discount)) / 100),
          "extras": product['extras'] ?? []
        };

        carts[activeCartIndex.value]['products'].add(data);

        calculateCartTotal(activeCartIndex.value);
      }

      for (int i = 0;
          i < carts[activeCartIndex.value]['products'].length;
          i++) {
        double taxes = double.parse(carts[activeCartIndex.value]['products'][i]
                ["taxes"]
            .fold(0, (t, e) => t + e['percent'])
            .toString());
        if (carts[activeCartIndex.value]['products'][i]['id'] ==
            product['id']) {
          if (carts[activeCartIndex.value]['products'][i]['qty'] != null &&
              carts[activeCartIndex.value]['products'][i]['qty'] > 0) {
            carts[activeCartIndex.value]['products'][i]['qty'] += 1;
          } else {
            carts[activeCartIndex.value]['products'][i]['qty'] = 1;
          }
        }

        carts[activeCartIndex.value]['products'][i]['tax'] = double.parse(
            ((taxes *
                        (carts[activeCartIndex.value]['products'][i]
                                    ['price_with_extras'] *
                                1 -
                            carts[activeCartIndex.value]['products'][i]
                                    ['discount'] *
                                1)) /
                    100)
                .toStringAsFixed(2));
      }

      calculateCartTotal(activeCartIndex.value);
    }
  }

  void calculateCartTotal(index) {
    double total = double.parse(carts[index]['products']
        .fold(0, (t, e) => t + e['price_with_extras'] * e['qty'])
        .toString());
    double tax = double.parse(carts[index]['products']
        .fold(0, (t, e) => t + e['tax'] * e['qty'])
        .toString());

    double discountTotal = double.parse(carts[index]['products']
        .fold(0, (t, e) => t + e['discount'] * e['qty'])
        .toString());

    int shopIndex =
        shops.indexWhere((item) => item['id'] == carts[index]['shop_id']);

    double shopTax = double.parse(shops[shopIndex]["taxes"]
        .fold(0, (t, e) => t + e['percent'])
        .toString());

    double shopTaxTotal =
        double.parse((((total - discountTotal) * shopTax) / 100).toString());

    carts[index]['tax'] = double.parse((tax + shopTaxTotal).toStringAsFixed(2));
    carts[index]['total_amount'] = double.parse(total.toStringAsFixed(2));
    carts[index]['discount'] = double.parse(discountTotal.toStringAsFixed(2));
    carts[index]['total'] = double.parse(
        (total + tax + shopTaxTotal - discountTotal + deliveryFee.value)
            .toStringAsFixed(2));

    update();
  }

  Future<void> sendTransaction(id) async {
    Map<String, dynamic> data =
        await transactionSendRequest(shopId.value, id, paymentMethodId.value);
    if (data['success']) {}
  }

  Future<List> getExtras(id) async {
    Map<String, dynamic> data = await extrasGetRequest(id);

    if (data['success'] != null && data['success']) {
      return data['data']['extras'];
    }

    return [];
  }

  void addToExtras(productId, extrasGroupId, extrasId, extrasName, price) {
    List productdetail = carts[activeCartIndex.value]['products'];
    int productIndex =
        productdetail.indexWhere((item) => item['id'] == productId);
    if (productIndex > -1) {
      List extrases = productdetail[productIndex]['extras'];
      var index = extrases
          .indexWhere((item) => item['extras_group_id'] == extrasGroupId);

      var extras = {
        "extras_group_id": extrasGroupId,
        "id": extrasId,
        "extras_name": extrasName,
        "price": price
      };

      if (index == -1) {
        productdetail[productIndex]['extras'].add(extras);
      } else {
        productdetail[productIndex]['extras'][index] = extras;
      }

      productdetail[productIndex]['price_with_extras'] =
          calculatePriceWithExtras(productdetail[productIndex],
              productdetail[productIndex]['extras']);

      double discount = double.parse(
          (productdetail[productIndex]['actual_discount']['discount_type'] == 0
                  ? 0
                  : productdetail[productIndex]['actual_discount']
                              ['discount_type'] ==
                          1
                      ? (double.parse(productdetail[productIndex]
                                      ['actual_discount']['discount_amount']
                                  .toString()) *
                              double.parse(productdetail[productIndex]
                                      ['price_with_extras']
                                  .toString())) /
                          100
                      : productdetail[productIndex]['actual_discount']
                          ['discount_amount'])
              .toString());

      productdetail[productIndex]['discount'] = discount;
      productdetail[productIndex]['price_total'] = productdetail[productIndex]
              ['price_with_extras'] *
          productdetail[productIndex]['qty'];
      productdetail[productIndex]['discount_total'] =
          (productdetail[productIndex]['discount'] *
              productdetail[productIndex]['qty']);
      productdetail[productIndex]['total'] =
          ((productdetail[productIndex]['price_with_extras'] * 1 -
                  productdetail[productIndex]['discount'] * 1) *
              productdetail[productIndex]['qty']);

      carts[activeCartIndex.value]['products'] = productdetail;
      calculateCartTotal(activeCartIndex.value);
    }
  }

  void onIncrementPos(int productId) {
    int productIndex = carts[activeCartIndex.value]['products']
        .indexWhere((item) => item['id'] == productId);
    if (productIndex > -1) {
      carts[activeCartIndex.value]['products'][productIndex]['qty'] += 1;

      calculateCartTotal(activeCartIndex.value);
    }
  }

  void onDecrementPos(int productId) {
    int productIndex = carts[activeCartIndex.value]['products']
        .indexWhere((item) => item['id'] == productId);

    if (productIndex > -1) {
      if (carts[activeCartIndex.value]['products'][productIndex]['qty'] > 1) {
        carts[activeCartIndex.value]['products'][productIndex]['qty'] -= 1;
      }

      calculateCartTotal(activeCartIndex.value);
    }
  }

  void onDeletePos(int productId) {
    int productIndex = carts[activeCartIndex.value]['products']
        .indexWhere((item) => item['id'] == productId);

    if (productIndex > -1) {
      carts[activeCartIndex.value]['products'].removeAt(productIndex);
      calculateCartTotal(activeCartIndex.value);
    }
  }

  Future<void> orderSavePos(index) async {
    loading.value = true;

    List productsList = [];

    for (int i = 0; i < carts[index]['products'].length; i++) {
      productsList.add({
        ...carts[index]['products'][i],
        "extras": carts[index]['products'][i]['extras'].length > 0
            ? carts[index]['products'][i]['extras'].toList()
            : [],
        "quantity": carts[index]['products'][i]["qty"]
      });
    }

    Map<String, dynamic> body = {
      "id": 0,
      "total_amount": carts[index]['total'] + deliveryFee.value,
      "delivery_time_id": deliveryTimeId.value,
      "delivery_date": deliveryDate.value,
      "id_user": clientId.value,
      "id_delivery_address": addressId.value,
      "id_shop": carts[index]['shop_id'],
      "id_shipping": shippingPlanId.value,
      "id_shipping_transport": shippingTransportId.value,
      "id_shipping_box": shippingBoxId.value,
      "product_details": productsList,
      "order_status": 1,
      "type": deliveryTypeId.value,
      "payment_status": 1,
      "comment": "",
      "payment_method": 1,
      "total_discount": carts[index]['discount'],
      "delivery_boy_comment": "",
      "delivery_boy": "",
      "tax": carts[index]['tax'],
      "delivery_fee": deliveryFee.value
    };

    Map<String, dynamic> data = await orderSaveRequest(body);

    if (!data['success']) {
      Get.bottomSheet(ErrorAlert(
        message: data['message'],
        onClose: () {
          Get.back();
        },
      ));
    }

    if (data['data'] != null &&
        data['data']['missed_products'] != null &&
        data['data']['missed_products'].length > 0) {
      Get.bottomSheet(ErrorAlert(
        message: "Some products are out of stock",
        onClose: () {
          Get.back();
        },
      ));
    }

    if (data['success'] != null) {
      if (data['success']) {
        carts.removeAt(index);
        if (carts.isEmpty) {
          addNewCart();
          activeCartIndex.value = 0;
        }

        update();
        Get.back();
        Get.back();
        Get.bottomSheet(SuccessAlert(
          message: "Successfully completed",
          onClose: () {
            Get.back();
          },
        ));

        orders.value = [];
        loadData.value = true;
        getOrders(orderTabIndex.value);
        loading.value = false;
        update();
      } else {
        loading.value = false;
        Get.bottomSheet(ErrorAlert(
          message: data['message'],
          onClose: () {
            Get.back();
          },
        ));
      }
    }
  }

  Future<List> getAllShops() async {
    Map<String, dynamic> data = await shopsDataRequest(10, shopsData.length);
    if (data['data'] != null) {
      for (int i = 0; i < data['data'].length; i++) {
        int index = shopsData
            .indexWhere((element) => element['id'] == data['data'][i]['id']);
        if (index == -1) {
          shopsData.add(data['data'][i]);
        }
      }

      shopController.getShopCategories();
      shopController.getActivePayments();
      shopController.getPhonePrefix();
    }

    return shopsData;
  }
}
