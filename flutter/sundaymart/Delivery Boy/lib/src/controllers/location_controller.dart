import 'dart:async';

import 'package:deliveryboy/src/controllers/auth_controller.dart';
import 'package:deliveryboy/src/requests/live_tracking.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationController extends GetxController {
  Location? location;
  bool? serviceEnabled;
  PermissionStatus? permissionGranted;
  Timer? timer;
  final AuthController authController = Get.put(AuthController());

  @override
  void onInit() {
    super.onInit();

    getServicePermission();
  }

  Future<void> getServicePermission() async {
    location = Location();
    //location!.enableBackgroundMode(enable: true);

    serviceEnabled = await location!.serviceEnabled();
    if (!serviceEnabled!) {
      serviceEnabled = await location!.requestService();
      if (!serviceEnabled!) {
        return;
      }
    }

    permissionGranted = await location!.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location!.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location!.onLocationChanged.listen((LocationData data) async {
      int idDeliveryBoy = -1;
      if (authController.user.value != null &&
          authController.user.value!.id != null) {
        idDeliveryBoy = authController.user.value!.id!;

        LocationData data = await location!.getLocation();
        String coords = "${data.longitude},${data.latitude}";

        await liveTrackingRequest(idDeliveryBoy, coords);
      }
    });
  }
}
