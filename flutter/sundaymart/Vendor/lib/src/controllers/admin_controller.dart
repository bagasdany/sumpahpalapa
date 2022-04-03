import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vendor/src/components/error_dialog.dart';
import 'package:vendor/src/components/success_alert.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/requests/address_data_request.dart';
import 'package:vendor/src/requests/address_save_request.dart';
import 'package:vendor/src/requests/client_save.dart';
import 'package:vendor/src/requests/clients_data_request.dart';
import 'package:vendor/src/requests/delivery_boy_get_request.dart';

class AdminController extends GetxController {
  OrderController orderController = Get.put(OrderController());
  var deliveryBoys = [].obs;
  var tabIndex = 0.obs;
  var markers = <MarkerId, Marker>{}.obs;
  Completer<GoogleMapController>? mapController = Completer();
  var mapCenter = {}.obs;

  var loading = false.obs;
  var clientName = "".obs;
  var clientSurname = "".obs;
  var clientPhone = "".obs;
  var clientPassword = "".obs;
  var clientPasswordConfirm = "".obs;
  var clientEmail = "".obs;

  var addressName = "".obs;
  var lat = RxDouble(37.42796133580664);
  var lon = RxDouble(-122.085749655962);

  var clients = [].obs;
  var addresses = [].obs;

  ScrollController scrollController = ScrollController();
  var loadData = false.obs;

  Future<List> getDeliveryBoys() async {
    deliveryBoys.value = [];
    Map<String, dynamic> data =
        await deliveryBoysGetRequest(orderController.shopId.value);
    Map<MarkerId, Marker> markerData = {};

    if (data['data'] != null) {
      for (int i = 0; i < data['data'].length; i++) {
        int index = deliveryBoys
            .indexWhere((element) => element['id'] == data['data'][i]['id']);
        if (index == -1) {
          deliveryBoys.add(data['data'][i]);
        }

        String position = data['data'][i]['position']['coordinates'];
        List<String> coords = position.split(",");

        MarkerId _markerId = MarkerId('marker_id_$index');
        Marker _marker = Marker(
          markerId: _markerId,
          position: LatLng(double.parse(coords[1]), double.parse(coords[0])),
          draggable: false,
        );

        // if (i == 0) {
        //   final GoogleMapController? controller = await mapController!.future;

        //   mapCenter['latitude'] = double.parse(coords[1]);
        //   mapCenter['longitude'] = double.parse(coords[0]);

        //   try {
        //     controller!.animateCamera(CameraUpdate.newCameraPosition(
        //       CameraPosition(
        //         bearing: 0,
        //         target:
        //             LatLng(double.parse(coords[1]), double.parse(coords[0])),
        //         zoom: 17.0,
        //       ),
        //     ));
        //   } catch (e) {}
        // }

        markerData[_markerId] = _marker;
      }
    }

    markers.value = markerData;
    markers.refresh();

    return deliveryBoys;
  }

  @override
  void onInit() {
    mapCenter['latitude'] = 37.42796133580664;
    mapCenter['longitude'] = (-122.085749655962);
    super.onInit();
  }

  Future<void> saveClient() async {
    loading.value = true;
    if (clientPassword.value != clientPasswordConfirm.value) {
      Get.bottomSheet(ErrorAlert(
        message: "Password mismatch",
        onClose: () {
          Get.back();
        },
      ));
    } else {
      Map<String, dynamic> data = await clientSaveRequest(
          clientName.value,
          clientSurname.value,
          clientEmail.value,
          clientPhone.value,
          clientPassword.value,
          "",
          1,
          0);

      if (data['success'] != null && data['success']) {
        orderController.getOrderClients();
        clientName.value = "";
        clientSurname.value = "";
        clientEmail.value = "";
        clientPhone.value = "";
        clientPassword.value = "";
        clientPasswordConfirm.value = "";
        Get.back();
        Get.bottomSheet(SuccessAlert(
          message: "Successfully saved",
          onClose: () {
            Get.back();
          },
        ));

        loading.value = false;
      }
    }
  }

  Future<void> saveAddress() async {
    loading.value = true;

    Map<String, dynamic> params = {
      "address": addressName.value,
      "latitude": lat.value,
      "longitude": lon.value,
      "client_id": orderController.clientId.value,
      "id": 0,
    };

    Map<String, dynamic> data = await addressSaveRequest(params);

    if (data['success'] != null && data['success']) {
      orderController.getOrderClients();
      addressName.value = "";
      Get.back();
      Get.bottomSheet(SuccessAlert(
        message: "Successfully saved",
        onClose: () {
          Get.back();
        },
      ));

      loading.value = false;
    }
  }

  Future<void> getClients() async {
    if (loadData.value) {
      Map<String, dynamic> data = await clientsDataRequest(10, clients.length);
      if (data['data'] != null) {
        clients.addAll(data['data']);
      }

      loadData.value = false;
    }
  }

  Future<void> getAddresses() async {
    if (loadData.value) {
      Map<String, dynamic> data =
          await addressDataRequest(10, addresses.length);
      if (data['data'] != null) {
        addresses.addAll(data['data']);
      }

      loadData.value = false;
    }
  }
}
