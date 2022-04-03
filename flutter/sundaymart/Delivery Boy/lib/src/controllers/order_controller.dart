import 'package:deliveryboy/src/controllers/auth_controller.dart';
import 'package:deliveryboy/src/controllers/language_controller.dart';
import 'package:deliveryboy/src/requests/balance_request.dart';
import 'package:deliveryboy/src/requests/change_status_request.dart';
import 'package:deliveryboy/src/requests/order_request.dart';
import 'package:deliveryboy/src/requests/route_request.dart';
import 'package:deliveryboy/src/requests/statistics_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderController extends GetxController {
  LanguageController languageController = Get.put(LanguageController());
  AuthController authController = Get.put(AuthController());
  var activeOrder = <String, dynamic>{}.obs;
  var activeCoords = {}.obs;
  var statistics = <String, dynamic>{}.obs;
  var activeStatus = 1.obs;
  var loading = false.obs;
  var status = 0.obs;
  var mapPolylines = <PolylineId, Polyline>{}.obs;
  var markers = <MarkerId, Marker>{}.obs;
  var remainedTime = 0.obs;

  @override
  void onInit() {
    super.onInit();

    if (authController.user.value != null &&
        authController.user.value!.id! > 0) {
      getStatistics();
    }
  }

  Future<List> getOrders(int status) async {
    Map<String, dynamic> data = await orderRequest(
        languageController.activeLanguageId.value,
        authController.user.value!.id!,
        status,
        0,
        10);

    List orders = [];

    if (data['success'] != null && data['success']) {
      orders = data['data'];
      await getStatistics();
    }

    return orders;
  }

  Future<void> getStatistics() async {
    Map<String, dynamic> data =
        await statisticsRequest(authController.user.value!.id!);

    if (data['success']) {
      statistics.value = data['data'];
    }
  }

  Future<bool> changeStatus(int orderId, int status) async {
    loading.value = true;
    Map<String, dynamic> data = await changeStatusRequest(orderId, status);

    if (data['success']) {
      loading.value = false;

      Map<String, dynamic> balanceData =
          await balanceRequest(authController.user.value!.id!);

      if (balanceData['success']) {
        double dailyBalance = balanceData['data']['daily_balance'].isNotEmpty
            ? double.parse(balanceData['data']['daily_balance']
                .values
                .toList()[0]
                .toString())
            : 0;
        double balance =
            double.parse(balanceData['data']['balance']['balance'].toString());

        authController.user.value!.dailyBalance = dailyBalance;
        authController.user.value!.totalBalance = balance;
      }

      return true;
    }

    return false;
  }

  Future<void> getRoute(int idOrder, String origin, String destination,
      LatLng originLatLng, LatLng destinationLatLng) async {
    markers.value = {};
    mapPolylines.value = {};
    activeCoords.value = {};
    remainedTime.value = 0;

    if (activeOrder['ready_date'] != null &&
        activeOrder['ready_date'] != "0000-00-00 00:00:00") {
      int now = DateTime.now().toUtc().millisecondsSinceEpoch;

      int time = DateTime.parse(activeOrder['ready_date'])
          .toUtc()
          .millisecondsSinceEpoch;

      remainedTime.value = (now - time) ~/ 1000;
    }

    Map<String, dynamic> data =
        await routeRequest(idOrder, origin, destination);
    if (data['success']) {
      BitmapDescriptor shopIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), 'lib/assets/images/dark_mode/shop.png');
      BitmapDescriptor clientIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(), 'lib/assets/images/dark_mode/client.png');
      activeCoords.value = data;

      final MarkerId markerId = MarkerId(data['data']['id'].toString());
      final MarkerId markerId2 = MarkerId("${data['data']['id']}2");

      final Marker shopMarker =
          Marker(markerId: markerId, position: originLatLng, icon: shopIcon);

      final Marker clientMarker = Marker(
          markerId: markerId, position: destinationLatLng, icon: clientIcon);

      markers[markerId] = shopMarker;
      markers[markerId2] = clientMarker;

      List<LatLng> points = <LatLng>[];

      List coordinates = data['data']['properties']['coordinates'];

      for (List coordinate in coordinates) {
        points.add(LatLng(coordinate[1], coordinate[0]));
      }

      final PolylineId polylineId = PolylineId(data['data']['id'].toString());

      final Polyline polyline = Polyline(
        polylineId: polylineId,
        consumeTapEvents: true,
        color: const Color.fromRGBO(69, 165, 36, 1),
        width: 5,
        points: points,
      );

      mapPolylines[polylineId] = polyline;
    }
  }
}
