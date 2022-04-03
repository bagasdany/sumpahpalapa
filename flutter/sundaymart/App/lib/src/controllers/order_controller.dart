import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:githubit/src/models/user.dart';
import 'package:githubit/src/requests/order_count_request.dart';
import 'package:githubit/src/requests/order_history_request.dart';
import 'package:githubit/src/requests/route_request.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderController extends GetxController with SingleGetTickerProviderMixin {
  List<String> months = [
    "January".tr,
    "February".tr,
    "March".tr,
    "April".tr,
    "May".tr,
    "June".tr,
    "July".tr,
    "August".tr,
    "September".tr,
    "October".tr,
    "November".tr,
    "December".tr
  ];

  var newOrderCount = 0.obs;
  var load = false.obs;
  var load2 = false.obs;
  var ordersList = [].obs;
  var activeOrder = <String, dynamic>{}.obs;
  var mapPolylines = <PolylineId, Polyline>{}.obs;
  var markers = <MarkerId, Marker>{}.obs;
  var activeCoords = {}.obs;
  var remainedTime = 0.obs;
  ScrollController? scrollController;

  @override
  void onInit() {
    super.onInit();

    scrollController = new ScrollController();
    load.value = true;
  }

  Future<int> getOrderCount(int userId) async {
    Map<String, dynamic> data = await orderCountRequest(userId);
    int count = 0;
    if (data['success']) {
      count = data['data'];
      newOrderCount.value = data['data'];
      newOrderCount.refresh();
    }

    return count;
  }

  Future<List> getOrderHistory(User user, int status, int idLang) async {
    int limit = 10;
    int offset = ordersList.length;

    if (load2.value || load.value) {
      Map<String, dynamic> data =
          await orderHistoryRequest(user.id!, status, idLang, limit, offset);

      if (data['success']) {
        for (int i = 0; i < data['data'].length; i++) {
          int index = ordersList
              .indexWhere((element) => element['id'] == data['data'][i]['id']);
          if (index == -1) {
            ordersList.add(data['data'][i]);
          }
        }

        load.value = false;
        load2.value = false;
      }
    }

    return ordersList;
  }

  String getTime(String time) {
    String stringTime = "";
    DateTime dateTime = DateTime.parse(time);
    String apm = "am";
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String minuteString = "$minute";
    String hourString = "$hour";
    if (hour > 12) {
      apm = "pm";
      hour = hour - 12;
    } else if (hour < 10) {
      hourString = "0$hour";
    }

    if (minute < 10) minuteString = "0$minute";

    stringTime =
        "${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year} | $hourString:$minuteString $apm";

    return stringTime;
  }

  String getTime2(String time) {
    String stringTime = "";
    DateTime dateTime = DateTime.parse(time);
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String minuteString = "$minute";
    String hourString = "$hour";
    if (hour < 10) {
      hourString = "0$hour";
    }

    if (minute < 10) minuteString = "0$minute";

    stringTime =
        "${dateTime.day} ${months[dateTime.month - 1]}, $hourString:$minuteString";

    return stringTime;
  }

  String getOnlyTime(String time) {
    String stringTime = "";
    DateTime dateTime = DateTime.parse(time);
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String minuteString = "$minute";
    String hourString = "$hour";
    if (hour < 10) {
      hourString = "0$hour";
    }

    if (minute < 10) minuteString = "0$minute";

    stringTime = "$hourString:$minuteString";

    return stringTime != "00:00" ? stringTime : "";
  }

  Future<void> setActiveOrder(Map<String, dynamic> order) async {
    activeOrder.value = order;
    remainedTime.value = 0;

    String origin =
        "${order['shop']['longtitude']},${order['shop']['latitude']}";
    String destination =
        "${order['address']['longtitude']},${order['address']['latitude']}";
    LatLng originLatLng = LatLng(
        double.parse(order['shop']['latitude'].toString()),
        double.parse(order['shop']['longtitude'].toString()));
    LatLng destinationLatLng = LatLng(
        double.parse(order['address']['latitude'].toString()),
        double.parse(order['address']['longtitude'].toString()));

    if (order['ready_date'] != null &&
        order['ready_date'] != "0000-00-00 00:00:00") {
      int now = DateTime.now().toUtc().millisecondsSinceEpoch;

      int time =
          DateTime.parse(order['ready_date']).toUtc().millisecondsSinceEpoch;

      remainedTime.value = (now - time) ~/ 1000;
    }

    getRoute(order['id'], origin, destination, originLatLng, destinationLatLng);
  }

  Future<void> getRoute(int idOrder, String origin, String destination,
      LatLng originLatLng, LatLng destinationLatLng) async {
    markers.value = {};
    mapPolylines.value = {};
    activeCoords.value = {};

    Map<String, dynamic> data =
        await routeRequest(idOrder, origin, destination);
    if (data['success'] != null && data['success']) {
      BitmapDescriptor shopIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(), 'lib/assets/images/dark_mode/shop.png');
      BitmapDescriptor clientIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(), 'lib/assets/images/dark_mode/client.png');
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
