import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/components/delivery_boy_item.dart';
import 'package:vendor/src/components/shadow/delivery_boy_box_shadow.dart';
import 'package:vendor/src/controllers/admin_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class DeliveryBoy extends GetView<AdminController> {
  final Function() openDrawer;
  const DeliveryBoy({Key? key, required this.openDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: HexColor("#ECEFF3"),
        appBar: customAppBar(
            icon: const IconData(0xef3e, fontFamily: 'MIcon'),
            title: "Delivery boy",
            onClickIcon: () {
              openDrawer();
            }),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      width: 0.5.sw - 20,
                      height: 130,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: HexColor("#FFFFFF"),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                offset: const Offset(0, 2),
                                color: HexColor("#D4D4D4").withOpacity(0.25),
                                blurRadius: 2,
                                spreadRadius: 0)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            const IconData(0xea99, fontFamily: 'MIcon'),
                            color: HexColor("#4F4F4F"),
                            size: 32.sp,
                          ),
                          SizedBox(
                            width: 0.5.sw - 50,
                            child: Text(
                              "Delivery order status",
                              style: TextStyle(
                                  color: HexColor("#000000"),
                                  fontFamily: 'Inter',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.toNamed("/deliveryBoyOrderList");
                    },
                  ),
                  InkWell(
                    child: Container(
                      width: 0.5.sw - 20,
                      height: 130,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: HexColor("#FFFFFF"),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                offset: const Offset(0, 2),
                                color: HexColor("#D4D4D4").withOpacity(0.25),
                                blurRadius: 2,
                                spreadRadius: 0)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            const IconData(0xef13, fontFamily: 'MIcon'),
                            color: HexColor("#4F4F4F"),
                            size: 32.sp,
                          ),
                          SizedBox(
                            width: 0.5.sw - 50,
                            child: Text(
                              "Delivery map",
                              style: TextStyle(
                                  color: HexColor("#000000"),
                                  fontFamily: 'Inter',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.toNamed("/deliveryBoyMap");
                    },
                  )
                ],
              ),
              SizedBox(
                  width: 1.sw,
                  height: 1.sh - 250,
                  child: FutureBuilder<List>(
                    future: controller.getDeliveryBoys(),
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return ListView.builder(
                              itemCount: 10,
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 120),
                              itemBuilder: (_, index) {
                                return const DeliveryboyBoxShadow();
                              });
                        default:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            List? deliveryBoys = snapshot.data;
                            return ListView.builder(
                                itemCount: deliveryBoys!.length,
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 120),
                                itemBuilder: (_, index) {
                                  return DeliveryBoyItem(
                                    id: deliveryBoys[index]['id'],
                                    onEdit: () {
                                      Get.toNamed("/deliveryBoyEdit");
                                    },
                                    name:
                                        "${deliveryBoys[index]['name']} ${deliveryBoys[index]['surname']}",
                                    shopName: deliveryBoys[index]['shop_name'],
                                    balance: deliveryBoys[index]['balance']
                                            ['balance']
                                        .toString(),
                                    isActive:
                                        deliveryBoys[index]['active'] == 1,
                                  );
                                });
                          }
                      }
                    },
                  )),
              const SizedBox(
                height: 120,
              ),
            ],
          ),
        ),
      );
    });
  }
}
