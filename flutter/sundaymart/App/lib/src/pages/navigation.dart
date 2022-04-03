import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:githubit/src/components/map_point.dart';
import 'package:githubit/src/controllers/order_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  NavigationState createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  bool mapLoad = false;
  Timer? timer;
  int startTime = 0;
  int minutes = 0;

  final OrderController controller = Get.put(OrderController());

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        mapLoad = true;
      });
    });

    Map routeData = controller.activeCoords;

    setState(() {
      startTime = controller.remainedTime.value;
      minutes =
          routeData['data'] != null ? (controller.remainedTime.value ~/ 60) : 0;
    });

    if (controller.remainedTime.value > 0) startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) timer!.cancel();
    timer = null;
  }

  void startTimer() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    } else {
      timer = new Timer.periodic(
        const Duration(seconds: 1),
        (Timer timer) {
          setState(() {
            if (startTime < 1) {
              timer.cancel();
            } else {
              startTime = startTime - 1;
            }
          });
        },
      );
    }
  }

  String getTimeString() {
    int time = startTime;
    int hour = time ~/ 3600;
    time = time - hour * 3600;
    int minute = time ~/ 60;
    time = time - minute * 60;
    String hourString = hour < 10 ? "0$hour" : "$hour";
    String minuteString = minute < 10 ? "0$minute" : "$minute";

    return "$hourString : $minuteString";
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> order = controller.activeOrder;
    Completer<GoogleMapController>? mapController = Completer();
    var statusBarHeight = MediaQuery.of(context).padding.top;
    Map routeData = controller.activeCoords;
    String distance = routeData['data']['distance'];
    String duration = routeData['data']['duration'];
    int distanceInt =
        int.tryParse(distance.replaceAll(RegExp(r'[^0-9]'), '')) ?? 1;
    int point = minutes > 0
        ? ((15 / distanceInt) * (distanceInt - minutes)).toInt()
        : 0;

    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? Color.fromRGBO(19, 20, 21, 1)
          : Color.fromRGBO(243, 243, 240, 1),
      body: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: Stack(children: <Widget>[
            if (mapLoad)
              SizedBox(
                width: 1.sw,
                height: 1.sh,
                child: GoogleMap(
                  mapType: MapType.normal,
                  onTap: (LatLng data) {},
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  markers: Set<Marker>.of(controller.markers.values),
                  polylines: Set<Polyline>.of(controller.mapPolylines.values),
                  padding: const EdgeInsets.only(top: 600, right: 0),
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        double.parse(order['shop']['latitude'].toString()),
                        double.parse(order['shop']['longtitude'].toString())),
                    zoom: 10,
                  ),
                  onMapCreated: (GoogleMapController mapcontroller) {
                    if (!mapController.isCompleted) {
                      mapController.complete(mapcontroller);
                    }
                  },
                ),
              ),
            Positioned(
                top: statusBarHeight,
                left: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: 1.sw - 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: !Get.isDarkMode
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(0, 0, 0, 1),
                          ),
                          child: Icon(
                            const IconData(0xea64, fontFamily: 'MIcon'),
                            size: 24.sp,
                            color: Get.isDarkMode
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color.fromRGBO(0, 0, 0, 1)),
                        child: Icon(
                          const IconData(0xeb38, fontFamily: 'MIcon'),
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          size: 30.sp,
                        ),
                      )
                    ],
                  ),
                ))
          ])),
      extendBody: true,
      bottomNavigationBar: Container(
        height: 60,
        width: 0.76.sw,
        margin: EdgeInsets.only(left: 0.12.sw, right: 0.12.sw, bottom: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color.fromRGBO(255, 184, 0, 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  distance,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      letterSpacing: -0.4,
                      color: const Color.fromRGBO(255, 255, 255, 1)),
                ),
                if (startTime > 0)
                  Text(
                    "${getTimeString()} min",
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                        letterSpacing: -0.4,
                        color: const Color.fromRGBO(255, 255, 255, 1)),
                  ),
                Text(
                  duration,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 12.sp,
                      letterSpacing: -0.4,
                      color: const Color.fromRGBO(255, 255, 255, 1)),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List<int>.generate(15, (i) => i + 1).map((index) {
                return MapPoint(
                  isActive: index > point ? false : true,
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
