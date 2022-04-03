import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/admin_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressAdd extends GetView<AdminController> {
  const AddressAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          backgroundColor: HexColor("#F9F9FA"),
          appBar: customAppBar(
              icon: const IconData(0xea60, fontFamily: 'MIcon'),
              onClickIcon: () {
                Get.back();
              },
              title: "Client address Add"),
          body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 40,
                  ),
                  SelectInput(
                    title: "Client",
                    child: DropdownButton<int>(
                      underline: Container(),
                      value: controller.orderController.clientId.value,
                      isExpanded: true,
                      icon: Icon(
                        const IconData(0xea4e, fontFamily: 'MIcon'),
                        size: 28.sp,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                      items: controller.orderController.clients.map((value) {
                        return DropdownMenuItem<int>(
                          value: value['id'],
                          child: Text(
                            "${value['name']} ${value['surname']}",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: HexColor("#000000"),
                                fontFamily: "MIcon",
                                fontSize: 16.sp,
                                letterSpacing: -0.4),
                          ),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        controller.orderController.clientId.value = value!;
                        controller.update();
                      },
                    ),
                    width: 1.sw - 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SelectInput(
                      title: "Address",
                      child: TextField(
                        onChanged: (text) {
                          controller.addressName.value = text;
                        },
                        controller: TextEditingController(
                            text: controller.addressName.value)
                          ..selection = TextSelection.fromPosition(
                            TextPosition(
                                offset: controller.addressName.value.length),
                          ),
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: HexColor("#000000"),
                            fontFamily: "MIcon",
                            fontSize: 16.sp,
                            letterSpacing: -0.4),
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      width: 1.sw,
                      height: 300,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        onTap: (LatLng value) {
                          controller.lat.value = value.latitude;
                          controller.lon.value = value.longitude;

                          MarkerId _markerId = const MarkerId('marker_id_0');
                          Marker _marker = Marker(
                            markerId: _markerId,
                            position: LatLng(value.latitude, value.longitude),
                            draggable: false,
                          );

                          Map<MarkerId, Marker> markerData = {};
                          markerData[_markerId] = _marker;

                          controller.markers.value = markerData;
                        },
                        markers: Set<Marker>.of(controller.markers.values),
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                              controller.lat.value, controller.lon.value),
                          zoom: 14,
                        ),
                        onMapCreated: (GoogleMapController mapcontroller) {
                          if (!controller.mapController!.isCompleted) {
                            controller.mapController!.complete(mapcontroller);
                          }
                        },
                      )),
                  const SizedBox(
                    height: 120,
                  ),
                ],
              )),
          extendBody: true,
          bottomNavigationBar: InkWell(
            onTap: () {
              if (controller.addressName.value.isNotEmpty) {
                controller.saveAddress();
              }
            },
            child: Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              width: 1.sw - 30,
              height: 60,
              decoration: BoxDecoration(
                  color: (controller.addressName.value.isNotEmpty)
                      ? HexColor("#16AA16")
                      : HexColor("#F1F1F1"),
                  borderRadius: BorderRadius.circular(30)),
              alignment: Alignment.center,
              child: controller.loading.value
                  ? SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        color: HexColor("ffffff"),
                      ),
                    )
                  : Text(
                      "Save",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          letterSpacing: -0.4,
                          color: HexColor("#ffffff")),
                    ),
            ),
          ));
    });
  }
}
