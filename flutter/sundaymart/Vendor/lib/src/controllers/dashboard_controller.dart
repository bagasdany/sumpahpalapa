import 'package:get/get.dart';
import 'package:vendor/src/requests/active_client_request.dart';
import 'package:vendor/src/requests/client_request.dart';
import 'package:vendor/src/requests/order_total_by_shop.dart';
import 'package:vendor/src/requests/orders_total_request.dart';
import 'package:vendor/src/requests/products_most_sold_request.dart';
import 'package:vendor/src/requests/products_total_request.dart';
import 'package:vendor/src/requests/shops_total_request.dart';

class DashboardController extends GetxController {
  var clientTotal = 0.obs;
  var clientActive = 0.obs;
  var shopTotal = 0.obs;
  var orderTotal = 0.obs;
  var productTotal = 0.obs;
  var productSold = 0.obs;
  var totalSum = RxDouble(0);
  var orderTotalByShop = [].obs;
  var star = RxDouble(0);
  Future<void> getInfo() async {
    Map<String, dynamic> data7 = await orderTotalByShopRequest();
    if (data7['success'] != null && data7['success']) {
      orderTotalByShop.value = data7['data'];
      double sum = 0;
      for (int i = 0; i < data7['data'].length; i++) {
        sum += double.parse(data7['data'][i]['value'].toString());
      }

      totalSum.value = double.parse(sum.toStringAsFixed(2));
    }
    Map<String, dynamic> data = await totalClientRequest();
    if (data['success'] != null && data['success']) {
      clientTotal.value = data['data'];
    }
    Map<String, dynamic> data2 = await shopTotalRequest();
    if (data2['success'] != null && data2['success']) {
      shopTotal.value = data2['data'];
    }
    Map<String, dynamic> data3 = await productsTotalRequest();
    if (data3['success'] != null && data3['success']) {
      productTotal.value = data3['data'];
    }
    Map<String, dynamic> data4 = await orderTotalRequest();
    if (data4['success'] != null && data4['success']) {
      orderTotal.value = data4['data'];
    }
    Map<String, dynamic> data5 = await productsMostSoldRequest();
    if (data5['success'] != null && data5['success']) {
      productSold.value = data5['data'].length;
    }
    Map<String, dynamic> data6 = await activeClientRequest();
    if (data6['success'] != null && data6['success']) {
      clientActive.value = data6['data'];
    }
  }

  @override
  void onInit() {
    getInfo();
    super.onInit();
  }
}
