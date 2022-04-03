import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:githubit/src/controllers/language_controller.dart';
import 'package:githubit/src/controllers/shop_controller.dart';
import 'package:githubit/src/models/product.dart';
import 'package:githubit/src/models/shop.dart';
import 'package:githubit/src/requests/coupon_request.dart';
import 'package:githubit/src/requests/discount_request.dart';
import 'package:githubit/src/utils/utils.dart';

class SavingsController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController? tabController;
  var tabIndex = 0.obs;
  var discountList = <Product>[].obs;
  var couponList = <Product>[].obs;
  final ShopController shopController = Get.put(ShopController());
  final LanguageController languageController = Get.put(LanguageController());
  Shop? shop;

  ScrollController? controllerCoupon;
  ScrollController? controllerDiscount;

  @override
  void onInit() {
    super.onInit();

    couponList.value = [];
    couponList.refresh();
    discountList.value = [];
    discountList.refresh();

    controllerCoupon = new ScrollController()
      ..addListener(_scrollListenerCoupon);
    controllerDiscount = new ScrollController()
      ..addListener(_scrollListenerDiscount);

    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controllerCoupon!.removeListener(_scrollListenerCoupon);
    controllerDiscount!.removeListener(_scrollListenerDiscount);
    super.dispose();
  }

  void setTab(index) {
    tabIndex.value = index;
  }

  void _scrollListenerCoupon() {
    if (controllerCoupon!.position.extentAfter < 500) {}
  }

  void _scrollListenerDiscount() {
    if (controllerDiscount!.position.extentAfter < 500) {}
  }

  List<Product> get discountProductList => discountList;

  Future<List<Product>> getDiscount() async {
    shop = shopController.defaultShop.value;
    if (await Utils.checkInternetConnectivity()) {
      Map<String, dynamic> data = await discountRequest(
          shop!.id!,
          languageController.activeLanguageId.value,
          10,
          discountProductList.length);

      if (data['success']) {
        for (int i = 0; i < data['data'].length; i++) {
          Map<String, dynamic> item = data['data'][i];

          int index = discountProductList
              .indexWhere((element) => element.id == item['product']['id']);

          int startTime = item['actual_discount'] != null
              ? DateTime.parse(item['actual_discount']['start_time'])
                  .toUtc()
                  .millisecondsSinceEpoch
              : 0;
          int endTime = item['actual_discount'] != null
              ? DateTime.parse(item['actual_discount']['end_time'])
                  .toUtc()
                  .millisecondsSinceEpoch
              : 0;

          if (index == -1 && item['product'] != null) {
            double tax = double.parse((item['product']['taxes'].length > 0
                    ? item['product']['taxes']
                        .fold(0, (a, b) => a + b['percent'])
                    : 0)
                .toString());

            discountProductList.add(Product(
                startTime: startTime,
                endTime: endTime,
                id: item['product']['id'],
                price: double.parse(item['product']['origin_price'].toString()),
                name: item['product']['language']['name'],
                discountType: int.parse(
                    item['actual_discount']['discount_type'].toString()),
                isCountDown: int.parse(
                    item['actual_discount']['is_count_down'].toString()),
                discount: double.parse(
                    item['actual_discount']['discount_amount'].toString()),
                description: item['product']['language']['description'],
                rating: int.parse(item['comments_count'].toString()) > 0
                    ? (int.parse(item['comments_sum_star'].toString()) /
                        int.parse(item['comments_count'].toString()))
                    : 5.0,
                hasCoupon: item['coupon'] != null,
                tax: tax,
                image: item['product']['images'][0]['image_url'],
                unit: item['product']['units'] != null
                    ? item['product']['units']['language']['name']
                    : "",
                images: item['product']['images'],
                amount: int.parse(item['product']['quantity'].toString()),
                reviewCount: int.parse(item['comments_count'].toString())));
          }
        }
      }
    }

    return discountProductList;
  }

  List<Product> get couponProductList => couponList;

  Future<List<Product>> getCoupons() async {
    if (await Utils.checkInternetConnectivity()) {
      shop = shopController.defaultShop.value;

      Map<String, dynamic> data = await couponRequest(
          shop!.id!,
          languageController.activeLanguageId.value,
          10,
          couponProductList.length);

      if (data['success']) {
        for (int i = 0; i < data['data'].length; i++) {
          Map<String, dynamic> item = data['data'][i];

          if (item['product'] == null) continue;

          int index = couponProductList
              .indexWhere((element) => element.id == item['product']['id']);

          int startTime = item['actual_discount'] != null
              ? DateTime.parse(item['actual_discount']['start_time'])
                  .toUtc()
                  .millisecondsSinceEpoch
              : 0;
          int endTime = item['actual_discount'] != null
              ? DateTime.parse(item['actual_discount']['end_time'])
                  .toUtc()
                  .millisecondsSinceEpoch
              : 0;

          if (index == -1 && item['product'] != null) {
            double tax = double.parse((item['product']['taxes'].length > 0
                    ? item['product']['taxes']
                        .fold(0, (a, b) => a + b['percent'])
                    : 0)
                .toString());

            couponProductList.add(Product(
                startTime: startTime,
                endTime: endTime,
                tax: tax,
                id: item['product']['id'],
                price: double.parse(item['product']['origin_price'].toString()),
                name: item['product']['language']['name'],
                discountType: item['actual_discount'] != null
                    ? int.parse(
                        item['actual_discount']['discount_type'].toString())
                    : 0,
                isCountDown: item['actual_discount'] != null
                    ? int.parse(
                        item['actual_discount']['is_count_down'].toString())
                    : 0,
                discount: item['actual_discount'] != null
                    ? double.parse(
                        item['actual_discount']['discount_amount'].toString())
                    : 0,
                description: item['product']['language']['description'],
                hasCoupon: true,
                rating: int.parse(item['comments_count'].toString()) > 0
                    ? (int.parse(item['comments_sum_star'].toString()) /
                        int.parse(item['comments_count'].toString()))
                    : 5.0,
                image: item['product']['images'][0]['image_url'],
                unit: item['product']['units'] != null
                    ? item['product']['units']['language']['name']
                    : "",
                images: item['product']['images'],
                amount: int.parse(item['product']['quantity'].toString()),
                reviewCount: int.parse(item['comments_count'].toString())));
          }
        }
      }
    }

    return couponProductList;
  }
}
