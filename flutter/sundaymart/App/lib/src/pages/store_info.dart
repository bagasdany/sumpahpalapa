import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:githubit/config/global_config.dart';
import 'package:githubit/src/components/delivery_day_item.dart';
import 'package:githubit/src/components/delivery_time_item.dart';
import 'package:githubit/src/controllers/shop_controller.dart';
import 'package:githubit/src/models/shop.dart';

class StoreInfo extends StatefulWidget {
  @override
  StoreInfoState createState() => StoreInfoState();
}

class StoreInfoState extends State<StoreInfo>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final ShopController shopController = Get.put(ShopController());
  int tabIndex = 1;
  String dateString = "";
  String dateString2 = "";

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

  List<String> weekDays = [
    "Mon".tr,
    "Tue".tr,
    "Wed".tr,
    "Thu".tr,
    "Fri".tr,
    "Sat".tr,
    "Sun".tr
  ];

  @override
  void initState() {
    super.initState();

    int index = Get.arguments["tab_index"];

    setState(() {
      tabIndex = index;
    });

    _tabController =
        new TabController(length: 2, vsync: this, initialIndex: index);
  }

  @override
  Widget build(BuildContext context) {
    Shop? shop = shopController.defaultShop.value;
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
        backgroundColor: Get.isDarkMode
            ? Color.fromRGBO(19, 20, 21, 1)
            : Color.fromRGBO(243, 243, 240, 1),
        appBar: PreferredSize(
          preferredSize: Size(1.sw, statusBarHeight + appBarHeight),
          child: Container(
            width: 1.sw,
            height: statusBarHeight + appBarHeight,
            decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 2,
                      spreadRadius: 0,
                      color: Get.isDarkMode
                          ? Color.fromRGBO(23, 27, 32, 0.13)
                          : Color.fromRGBO(169, 169, 150, 0.13))
                ],
                color: Get.isDarkMode
                    ? Color.fromRGBO(37, 48, 63, 1)
                    : Colors.white),
            padding: EdgeInsets.only(left: 15, right: 15, top: statusBarHeight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        width: 34,
                        height: 34,
                        margin: EdgeInsets.only(right: 8),
                        child: Icon(
                          const IconData(0xea64, fontFamily: 'MIcon'),
                          size: 24.sp,
                          color: Get.isDarkMode
                              ? Color.fromRGBO(255, 255, 255, 1)
                              : Color.fromRGBO(0, 0, 0, 1),
                        ),
                      ),
                      onTap: () => Get.back(),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        width: 26,
                        height: 26,
                        imageUrl: "$GLOBAL_IMAGE_URL${shop!.logoUrl}",
                        placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          child: Icon(
                            const IconData(0xee4b, fontFamily: 'MIcon'),
                            color: Color.fromRGBO(233, 233, 230, 1),
                            size: 20.sp,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Container(
                      height: 34,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "${shop.name}",
                        style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            letterSpacing: -0.4,
                            color: Get.isDarkMode
                                ? Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(0, 0, 0, 1)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 1.sw,
                height: 60,
                decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? Color.fromRGBO(26, 34, 44, 1)
                        : Color.fromRGBO(249, 249, 246, 1)),
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Color.fromRGBO(69, 165, 36, 1),
                  indicatorWeight: 2,
                  labelColor: Get.isDarkMode
                      ? Color.fromRGBO(255, 255, 255, 1)
                      : Color.fromRGBO(0, 0, 0, 1),
                  unselectedLabelColor: Get.isDarkMode
                      ? Color.fromRGBO(130, 139, 150, 1)
                      : Color.fromRGBO(136, 136, 126, 1),
                  onTap: (index) {
                    setState(() {
                      tabIndex = index;
                    });
                  },
                  labelStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    letterSpacing: -0.4,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    letterSpacing: -0.4,
                  ),
                  tabs: [
                    Tab(
                      child: Text("Market info".tr),
                    ),
                    Tab(
                      child: Text("Delivery times".tr),
                    )
                  ],
                ),
              ),
              Container(
                child: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Get.isDarkMode
                                  ? Color.fromRGBO(37, 48, 63, 1)
                                  : Color.fromRGBO(255, 255, 255, 1)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 40,
                                    height: 40,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                        color: Get.isDarkMode
                                            ? Color.fromRGBO(26, 34, 44, 1)
                                            : Color.fromRGBO(248, 248, 248, 1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(
                                        const IconData(0xef0a,
                                            fontFamily: 'MIcon'),
                                        color: Get.isDarkMode
                                            ? Color.fromRGBO(255, 255, 255, 1)
                                            : Color.fromRGBO(0, 0, 0, 1),
                                        size: 24.sp),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Address".tr,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                            letterSpacing: -0.4,
                                            color: Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    130, 139, 150, 1)
                                                : Color.fromRGBO(
                                                    136, 136, 126, 1)),
                                      ),
                                      Container(
                                        width: 1.sw - 125,
                                        margin:
                                            EdgeInsets.only(top: 8, bottom: 40),
                                        child: Text(
                                          "${shop.address}",
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                              letterSpacing: -0.4,
                                              color: Get.isDarkMode
                                                  ? Color.fromRGBO(
                                                      255, 255, 255, 1)
                                                  : Color.fromRGBO(0, 0, 0, 1)),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 40,
                                    height: 40,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                        color: Get.isDarkMode
                                            ? Color.fromRGBO(26, 34, 44, 1)
                                            : Color.fromRGBO(248, 248, 248, 1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(
                                        const IconData(0xf20f,
                                            fontFamily: 'MIcon'),
                                        color: Get.isDarkMode
                                            ? Color.fromRGBO(255, 255, 255, 1)
                                            : Color.fromRGBO(0, 0, 0, 1),
                                        size: 24.sp),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Working hours".tr,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                            letterSpacing: -0.4,
                                            color: Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    130, 139, 150, 1)
                                                : Color.fromRGBO(
                                                    136, 136, 126, 1)),
                                      ),
                                      Container(
                                        width: 1.sw - 125,
                                        margin:
                                            EdgeInsets.only(top: 8, bottom: 40),
                                        child: Text(
                                          "${shop.openHours} - ${shop.closeHours}",
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                              letterSpacing: -0.4,
                                              color: Get.isDarkMode
                                                  ? Color.fromRGBO(
                                                      255, 255, 255, 1)
                                                  : Color.fromRGBO(0, 0, 0, 1)),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 40,
                                    height: 40,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                        color: Get.isDarkMode
                                            ? Color.fromRGBO(26, 34, 44, 1)
                                            : Color.fromRGBO(248, 248, 248, 1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(
                                        const IconData(0xef63,
                                            fontFamily: 'MIcon'),
                                        color: Get.isDarkMode
                                            ? Color.fromRGBO(255, 255, 255, 1)
                                            : Color.fromRGBO(0, 0, 0, 1),
                                        size: 24.sp),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Delivery fee".tr,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                            letterSpacing: -0.4,
                                            color: Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    130, 139, 150, 1)
                                                : Color.fromRGBO(
                                                    136, 136, 126, 1)),
                                      ),
                                      Container(
                                        width: 1.sw - 125,
                                        margin:
                                            EdgeInsets.only(top: 8, bottom: 40),
                                        child: Text(
                                          "${shop.deliveryFee}",
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                              letterSpacing: -0.4,
                                              color: Get.isDarkMode
                                                  ? Color.fromRGBO(
                                                      255, 255, 255, 1)
                                                  : Color.fromRGBO(0, 0, 0, 1)),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 40,
                                    height: 40,
                                    margin: EdgeInsets.only(right: 15),
                                    decoration: BoxDecoration(
                                        color: Get.isDarkMode
                                            ? Color.fromRGBO(26, 34, 44, 1)
                                            : Color.fromRGBO(248, 248, 248, 1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Icon(
                                        const IconData(0xf0e2,
                                            fontFamily: 'MIcon'),
                                        color: Get.isDarkMode
                                            ? Color.fromRGBO(255, 255, 255, 1)
                                            : Color.fromRGBO(0, 0, 0, 1),
                                        size: 24.sp),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Delivery type".tr,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                            letterSpacing: -0.4,
                                            color: Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    130, 139, 150, 1)
                                                : Color.fromRGBO(
                                                    136, 136, 126, 1)),
                                      ),
                                      Container(
                                        width: 1.sw - 125,
                                        margin:
                                            EdgeInsets.only(top: 8, bottom: 40),
                                        child: Text(
                                          "${"Delivery".tr} — ${shop.deliveryType == 3 ? "Delivery & Pickup".tr : shop.deliveryType == 1 ? "Delivery".tr : "Pickup".tr}",
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                              letterSpacing: -0.4,
                                              color: Get.isDarkMode
                                                  ? Color.fromRGBO(
                                                      255, 255, 255, 1)
                                                  : Color.fromRGBO(0, 0, 0, 1)),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Get.isDarkMode
                                  ? Color.fromRGBO(37, 48, 63, 1)
                                  : Color.fromRGBO(255, 255, 255, 1)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Description".tr,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    letterSpacing: -0.4,
                                    color: Get.isDarkMode
                                        ? Color.fromRGBO(130, 139, 150, 1)
                                        : Color.fromRGBO(136, 136, 126, 1)),
                              ),
                              Container(
                                width: 1.sw - 30,
                                margin: EdgeInsets.only(top: 8),
                                child: Text(
                                  "${shop.description}",
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      height: 1.6,
                                      letterSpacing: -0.4,
                                      color: Get.isDarkMode
                                          ? Color.fromRGBO(255, 255, 255, 1)
                                          : Color.fromRGBO(0, 0, 0, 1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.only(top: 8, bottom: 40),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Get.isDarkMode
                                    ? Color.fromRGBO(37, 48, 63, 1)
                                    : Color.fromRGBO(255, 255, 255, 1)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Info".tr,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        letterSpacing: -0.4,
                                        color: Get.isDarkMode
                                            ? Color.fromRGBO(130, 139, 150, 1)
                                            : Color.fromRGBO(136, 136, 126, 1)),
                                  ),
                                  Container(
                                    width: 1.sw - 30,
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "${shop.info}",
                                      style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                          letterSpacing: -0.4,
                                          height: 1.6,
                                          color: Get.isDarkMode
                                              ? Color.fromRGBO(255, 255, 255, 1)
                                              : Color.fromRGBO(0, 0, 0, 1)),
                                    ),
                                  ),
                                ]))
                      ],
                    ),
                  ),
                  Obx(() {
                    int deliveryTime = shopController.deliveryTime.value;
                    DateTime now = DateTime.now();

                    return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                        child: Column(children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            margin: EdgeInsets.only(bottom: 15),
                            width: 1.sw - 30,
                            decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Color.fromRGBO(37, 48, 63, 1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            const IconData(0xeb21,
                                                fontFamily: 'MIcon'),
                                            size: 24.sp,
                                            color: Get.isDarkMode
                                                ? Color.fromRGBO(
                                                    255, 255, 255, 1)
                                                : Color.fromRGBO(0, 0, 0, 1),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "${months[now.month - 1]} ${now.year}",
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.sp,
                                                letterSpacing: -0.4,
                                                color: Get.isDarkMode
                                                    ? Color.fromRGBO(
                                                        255, 255, 255, 1)
                                                    : Color.fromRGBO(
                                                        0, 0, 0, 1)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 1.sw - 30,
                                  margin: EdgeInsets.only(top: 20),
                                  height: 60,
                                  child: ListView.builder(
                                      itemCount: 5,
                                      scrollDirection: Axis.horizontal,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 12),
                                      itemBuilder: (context, index) {
                                        DateTime now = DateTime.now();
                                        DateTime date = DateTime(now.year,
                                            now.month, now.day + index);

                                        String day = "${date.day}";
                                        if (date.day < 10) day = "0${date.day}";

                                        return InkWell(
                                          child: DeliveryDayItem(
                                            day: day,
                                            weekDay: weekDays[date.weekday - 1],
                                            isSelected: dateString2 ==
                                                "$day ${months[date.month - 1]}",
                                          ),
                                          onTap: () {
                                            shopController.deliveryTime.value =
                                                0;

                                            setState(() {
                                              dateString2 =
                                                  "$day ${months[date.month - 1]}";
                                              dateString =
                                                  "${date.year}-${date.month}-$day";
                                            });
                                          },
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                shopController.shopTimeUnitsList.map((item) {
                              List<String> times = item.name!.split("-");
                              List<String> time1 = times[0].split(":");
                              List<String> time2 = times[1].split(":");
                              String time =
                                  "${time1[0]}:${time1[1]} - ${time2[0]}:${time2[1]}";

                              return InkWell(
                                child: DeliveryTimeItem(
                                  date: "$dateString2",
                                  time: time,
                                  color: Get.isDarkMode
                                      ? Color.fromRGBO(130, 139, 150, 1)
                                      : Color.fromRGBO(136, 136, 126, 1),
                                  isSelected: deliveryTime == item.id,
                                ),
                                onTap: () {
                                  shopController.deliveryTime.value = item.id!;

                                  shopController.deliveryDateString.value =
                                      dateString2;
                                  shopController.deliveryDate.value =
                                      dateString;
                                  shopController.deliveryTimeString.value =
                                      time;

                                  shopController.deliveryTime.refresh();
                                  shopController.deliveryDateString.refresh();
                                  shopController.deliveryTimeString.refresh();
                                },
                              );
                            }).toList(),
                          ),
                        ]));
                  })
                ][tabIndex],
              )
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: tabIndex == 0
            ? Container()
            : Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Obx(
                  () => TextButton(
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.all(0))),
                      child: Container(
                        width: 1.sw - 30,
                        height: 60,
                        alignment: Alignment.center,
                        child: Text(
                          "Save".tr,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        ),
                        decoration: BoxDecoration(
                            color: shopController.deliveryTime.value <= 0
                                ? Color.fromRGBO(0, 0, 0, 1)
                                : Color.fromRGBO(69, 165, 36, 1),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        if (shopController.deliveryTime.value > 0) Get.back();
                      }),
                )));
  }
}
