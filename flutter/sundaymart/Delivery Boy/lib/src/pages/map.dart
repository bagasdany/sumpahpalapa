import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:deliveryboy/config/global_config.dart';
import 'package:deliveryboy/src/components/map_info_shape.dart';
import 'package:deliveryboy/src/components/map_point.dart';
import 'package:deliveryboy/src/controllers/chat_controller.dart';
import 'package:deliveryboy/src/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  OrderController controller = Get.put(OrderController());
  bool mapLoad = false;
  Timer? timer;
  int startTime = 0;
  int minutes = 0;
  final ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        mapLoad = true;
      });
    });

    Map routeData = controller.activeCoords;
    String duration = routeData['data']['duration'];
    int distanceInt =
        int.tryParse(duration.replaceAll(RegExp(r'[^0-9]'), '')) ?? 1;

    int minute = controller.remainedTime.value;

    setState(() {
      startTime = distanceInt > minute ? (distanceInt * 60 - minute) : 0;
      minutes = (distanceInt > minute ? (distanceInt * 60 - minute) : 0);
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
      timer = Timer.periodic(
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
    int minute = time ~/ 60;
    time = time - minute * 60;
    String minuteString = minute < 10 ? "0$minute" : "$minute";
    String secondString = time < 10 ? "0$time" : "$time";

    return "$minuteString : $secondString";
  }

  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    Map<String, dynamic> order = controller.activeOrder;
    Completer<GoogleMapController>? mapController = Completer();
    Map routeData = controller.activeCoords;
    String distance = routeData['data']['distance'];
    String duration = routeData['data']['duration'];
    int distanceInt =
        int.tryParse(duration.replaceAll(RegExp(r'[^0-9]'), '')) ?? 1;
    int point = ((15 / distanceInt) * (distanceInt - minutes)).toInt();

    return Scaffold(
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
                      SizedBox(
                        width: 1.sw - 105,
                        height: 80,
                        child: CustomPaint(
                          painter: MapInfoShape(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 1.sw - 105,
                                height: 60,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          distance,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12.sp,
                                              letterSpacing: -0.4,
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1)),
                                        ),
                                        if (startTime > 0)
                                          Text(
                                            "${getTimeString()} min",
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                                fontSize: 12.sp,
                                                letterSpacing: -0.4,
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 1)),
                                          ),
                                        Text(
                                          duration,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12.sp,
                                              letterSpacing: -0.4,
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 1)),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children:
                                          List<int>.generate(15, (i) => i + 1)
                                              .map((index) {
                                        return MapPoint(
                                          isActive:
                                              index > point ? false : true,
                                        );
                                      }).toList(),
                                    )
                                  ],
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: <Widget>[
                              //     Text(
                              //       "Go back",
                              //       style: TextStyle(
                              //           fontFamily: 'Inter',
                              //           fontWeight: FontWeight.w600,
                              //           fontSize: 12.sp,
                              //           letterSpacing: -0.4,
                              //           color:
                              //               const Color.fromRGBO(0, 0, 0, 1)),
                              //     ),
                              //     const SizedBox(
                              //       width: 5,
                              //     ),
                              //     RotatedBox(
                              //       quarterTurns: 1,
                              //       child: Icon(
                              //           const IconData(0xea59,
                              //               fontFamily: 'MIcon'),
                              //           size: 14.sp,
                              //           color:
                              //               const Color.fromRGBO(0, 0, 0, 1)),
                              //     )
                              //   ],
                              // )
                            ],
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
        width: 1.sw,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          boxShadow: const <BoxShadow>[
            BoxShadow(
                offset: Offset(0, -8),
                blurRadius: 70,
                spreadRadius: 0,
                color: Color.fromRGBO(169, 169, 169, 0.25))
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Get.isDarkMode
              ? const Color.fromRGBO(37, 48, 63, 1)
              : const Color.fromRGBO(255, 255, 255, 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: order['clients']['image_url'] != null
                                  ? 0
                                  : 10,
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(37, 48, 63, 1)
                                  : const Color.fromRGBO(232, 232, 232, 0.35)),
                          borderRadius: BorderRadius.circular(
                            30,
                          )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: order['clients']['image_url'] != null
                            ? CachedNetworkImage(
                                width: 40,
                                height: 40,
                                fit: BoxFit.fill,
                                imageUrl:
                                    "$globalImageUrl${order['clients']['image_url']}",
                                placeholder: (context, url) => Container(
                                  width: 40,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: Icon(
                                    const IconData(0xee4b, fontFamily: 'MIcon'),
                                    color:
                                        const Color.fromRGBO(233, 233, 230, 1),
                                    size: 20.sp,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : SizedBox(
                                width: 60,
                                height: 60,
                                child: Icon(
                                  const IconData(0xf25c, fontFamily: 'MIcon'),
                                  color: Get.isDarkMode
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(0, 0, 0, 1),
                                  size: 20.sp,
                                ),
                              ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${order['clients']['name']} ${order['clients']['surname']}",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            letterSpacing: -1,
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        Text(
                          "${order['clients']['phone']}",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            height: 1.5,
                            letterSpacing: -0.5,
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if (order['clients']['phone'] != null)
                      InkWell(
                        onTap: () async {
                          String url = "tel:${order['clients']['phone']}";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(19, 20, 21, 1)
                                  : const Color.fromRGBO(243, 243, 240, 1)),
                          child: const Icon(
                            IconData(0xefe9, fontFamily: 'MIcon'),
                          ),
                        ),
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        chatController.dialog(
                            chatController.user.value!.id!, 2);
                        Get.toNamed("/chat");
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(19, 20, 21, 1)
                                : const Color.fromRGBO(243, 243, 240, 1)),
                        child: const Icon(
                          IconData(0xef45, fontFamily: 'MIcon'),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Color.fromRGBO(0, 0, 0, 0.1),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(69, 165, 36, 1),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              offset: Offset(0, 14),
                              blurRadius: 15,
                              spreadRadius: 0,
                              color: Color.fromRGBO(69, 165, 36, 0.26),
                            )
                          ]),
                      child: Icon(
                        const IconData(0xea47, fontFamily: 'MIcon'),
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        size: 14.sp,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [1, 2, 3, 4, 5].map((e) {
                        return Container(
                          width: 4,
                          height: 4,
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: const Color.fromRGBO(196, 196, 196, 0.44)),
                        );
                      }).toList(),
                    )
                  ],
                ),
                SizedBox(
                  width: 1.sw - 72,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Pickup address",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            height: 1.3,
                            letterSpacing: -0.4,
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(130, 139, 150, 1)
                                : const Color.fromRGBO(136, 136, 126, 1)),
                      ),
                      Text(
                        "${order['shop']['language']['name']}",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            height: 1.2,
                            letterSpacing: -0.4,
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      Text(
                        "${order['shop']['language']['address']} ",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            height: 1.2,
                            letterSpacing: -0.4,
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(0, 0, 0, 1)),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(222, 31, 54, 1),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              offset: Offset(0, 14),
                              blurRadius: 15,
                              spreadRadius: 0,
                              color: Color.fromRGBO(222, 31, 54, 0.26),
                            )
                          ]),
                      child: Icon(
                        const IconData(0xea47, fontFamily: 'MIcon'),
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        size: 14.sp,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 1.sw - 72,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Delivery addres",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            height: 1.3,
                            letterSpacing: -0.4,
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(130, 139, 150, 1)
                                : const Color.fromRGBO(136, 136, 126, 1)),
                      ),
                      Text(
                        "${order['clients']['name']} ${order['clients']['surname']}",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                            height: 1.2,
                            letterSpacing: -0.4,
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(0, 0, 0, 1)),
                      ),
                      Text(
                        "${order['address']['address']}",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            height: 1.2,
                            letterSpacing: -0.4,
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(0, 0, 0, 1)),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  child: Container(
                    width: 0.44.sw,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color.fromRGBO(69, 165, 36, 1)),
                    alignment: Alignment.center,
                    child: controller.loading.value
                        ? const SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            "Delivered".tr,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                                color: const Color.fromRGBO(255, 255, 255, 1)),
                          ),
                  ),
                  onTap: () async {
                    await controller.changeStatus(order['id'], 4);
                    Get.back();
                  },
                ),
                InkWell(
                  child: Container(
                      width: 0.44.sw,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: const Color.fromRGBO(0, 0, 0, 1)),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(const IconData(0xecf0, fontFamily: 'MIcon'),
                              size: 20.sp,
                              color: const Color.fromRGBO(255, 255, 255, 1)),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Detail".tr,
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                                color: const Color.fromRGBO(255, 255, 255, 1)),
                          ),
                        ],
                      )),
                  onTap: () async {
                    Get.back();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
