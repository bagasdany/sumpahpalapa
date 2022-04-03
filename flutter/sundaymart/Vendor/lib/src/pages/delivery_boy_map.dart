import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/controllers/admin_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryBoyMap extends GetView<AdminController> {
  const DeliveryBoyMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#ECEFF3"),
      appBar: customAppBar(
          icon: const IconData(0xea60, fontFamily: 'MIcon'),
          onClickIcon: () {
            Get.back();
          },
          title: "Delivery boy location"),
      body: SizedBox(
        width: 1.sw,
        height: 1.sh - 100,
        child: GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          markers: Set<Marker>.of(controller.markers.values),
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(controller.mapCenter['latitude'],
                controller.mapCenter['longitude']),
            zoom: 14,
          ),
          onMapCreated: (GoogleMapController mapcontroller) {
            if (!controller.mapController!.isCompleted) {
              controller.mapController!.complete(mapcontroller);
            }
          },
        ),
      ),
    );
  }
}
