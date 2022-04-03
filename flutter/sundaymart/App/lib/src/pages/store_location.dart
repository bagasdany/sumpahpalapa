import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:githubit/src/components/shops_location_item.dart';
import 'package:githubit/src/controllers/shop_controller.dart';
import 'package:githubit/src/themes/map_dark_theme.dart';
import 'package:githubit/src/themes/map_light_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreLocation extends StatefulWidget {
  @override
  StoreLocationState createState() => StoreLocationState();
}

class StoreLocationState extends State<StoreLocation> {
  final ShopController controller = Get.put(ShopController());
  Completer<GoogleMapController> _controller = Completer();
  bool loadGoogleMap = false;
  Map<MarkerId, Marker> markers = {};

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        loadGoogleMap = true;
      });
    });

    Map<MarkerId, Marker> markerData = {};
    if (controller.shopList.length > 0)
      for (int i = 0; i < controller.shopList.length; i++) {
        Map<String, dynamic> shop = controller.shopList[i];
        MarkerId _markerId = MarkerId('marker_id_$i');
        Marker _marker = Marker(
          markerId: _markerId,
          position: LatLng(double.parse(shop['latitude'].toString()),
              double.parse(shop['longtitude'].toString())),
          draggable: false,
        );

        markerData[_markerId] = _marker;
      }

    setState(() {
      markers = markerData;
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.isDarkMode
            ? Color.fromRGBO(19, 20, 21, 1)
            : Color.fromRGBO(243, 243, 240, 1),
        body: SingleChildScrollView(
          child: Obx(() => Container(
                width: 1.sw,
                height: 1.sh,
                child: Stack(
                  children: <Widget>[
                    if (loadGoogleMap)
                      Container(
                        width: 1.sw,
                        height: 1.sh,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          markers: Set<Marker>.of(markers.values),
                          initialCameraPosition: _kGooglePlex,
                          onMapCreated: (GoogleMapController controller) {
                            controller.setMapStyle(json.encode(Get.isDarkMode
                                ? MAP_DARK_THEME
                                : MAP_LIGHT_THEME));
                            _controller.complete(controller);
                          },
                        ),
                      ),
                    Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 1.sw,
                          height: 382,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              color: Get.isDarkMode
                                  ? Color.fromRGBO(37, 48, 63, 1)
                                  : Colors.white,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Color.fromRGBO(153, 153, 153, 0.2),
                                    offset: Offset(0, 4),
                                    blurRadius: 70,
                                    spreadRadius: 0)
                              ]),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 60,
                                height: 5,
                                margin: EdgeInsets.only(top: 10, bottom: 13),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Get.isDarkMode
                                        ? Colors.white
                                        : Color.fromRGBO(175, 175, 175, 1)),
                              ),
                              Container(
                                height: 50,
                                width: 1.sw,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    130, 139, 150, 0.14)
                                                : Color.fromRGBO(
                                                    136, 136, 126, 0.14)))),
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search".tr,
                                      prefixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          const IconData(0xf0cd,
                                              fontFamily: 'MIcon'),
                                          size: 18.sp,
                                          color: Get.isDarkMode
                                              ? Color.fromRGBO(130, 139, 150, 1)
                                              : Color.fromRGBO(
                                                  136, 136, 126, 0.14),
                                        ),
                                      ),
                                      hintStyle: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                          letterSpacing: -0.5,
                                          color: Get.isDarkMode
                                              ? Color.fromRGBO(130, 139, 150, 1)
                                              : Color.fromRGBO(
                                                  136, 136, 126, 0.14))),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                height: 224,
                                width: 1.sw,
                                child: ListView.builder(
                                    itemCount: controller.shopList.length,
                                    padding: EdgeInsets.only(left: 20),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> shop =
                                          controller.shopList[index];

                                      return ShopLocationItem(
                                        onTap: () async {
                                          final GoogleMapController?
                                              mapController =
                                              await _controller.future;
                                          try {
                                            mapController!.animateCamera(
                                                CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                bearing: 0,
                                                target: LatLng(
                                                    double.parse(
                                                        shop['latitude']
                                                            .toString()),
                                                    double.parse(
                                                        shop['longtitude']
                                                            .toString())),
                                                zoom: 17.0,
                                              ),
                                            ));
                                          } catch (e) {}
                                        },
                                        name: shop['language']['name'],
                                        address: shop['language']['address'],
                                        rating:
                                            "5", //shop['rating'].toString(),
                                        backImage: shop['backimage_url'],
                                        logoImage: shop['logo_url'],
                                      );
                                    }),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              )),
        ));
  }
}
