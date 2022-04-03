import 'package:deliveryboy/src/components/order_detail.dart';
import 'package:deliveryboy/src/components/order_detail_accept.dart';
import 'package:deliveryboy/src/controllers/chat_controller.dart';
import 'package:deliveryboy/src/controllers/order_controller.dart';
import 'package:deliveryboy/src/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderItem extends GetView<OrderController> {
  final Map<String, dynamic>? data;
  final Function? onChangeStatus;
  OrderItem({Key? key, this.data, this.onChangeStatus}) : super(key: key);

  final ChatController chatController = Get.put(ChatController());

  void showSheet(context, item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (_, controller) {
            if (item['order_status'] == 1) {
              return SingleChildScrollView(
                child: OrderDetailAccept(
                  data: item,
                  onChangeStatus: onChangeStatus,
                ),
                controller: controller,
              );
            } else {
              return SingleChildScrollView(
                child: OrderDetail(
                  data: item,
                  onChangeStatus: onChangeStatus,
                ),
                controller: controller,
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 30,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Get.isDarkMode
              ? const Color.fromRGBO(26, 34, 44, 1)
              : const Color.fromRGBO(251, 251, 248, 1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            width: 1.sw - 30,
            decoration: BoxDecoration(
                color: Get.isDarkMode
                    ? const Color.fromRGBO(37, 48, 63, 1)
                    : const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                      spreadRadius: 0,
                      color: Get.isDarkMode
                          ? const Color.fromRGBO(23, 27, 32, 0.13)
                          : const Color.fromRGBO(169, 169, 150, 0.13))
                ]),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Name",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.4,
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(130, 139, 150, 1)
                                  : const Color.fromRGBO(136, 136, 126, 1),
                              fontSize: 14.sp),
                        ),
                        Text(
                          "${data!['clients']['name']} ${data!['clients']['surname']}",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.5,
                              height: 1.4,
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : const Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 16.sp),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(19, 20, 21, 1)
                              : const Color.fromRGBO(243, 243, 240, 1)),
                      child: RichText(
                          text: TextSpan(
                              text: "Order — ",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5,
                                  color: Get.isDarkMode
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 12.sp),
                              children: <TextSpan>[
                            TextSpan(
                              text: "#${data!['id']}",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                  color: Get.isDarkMode
                                      ? const Color.fromRGBO(255, 255, 255, 1)
                                      : const Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 12.sp),
                            )
                          ])),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Phone number",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.4,
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(130, 139, 150, 1)
                                  : const Color.fromRGBO(136, 136, 126, 1),
                              fontSize: 14.sp),
                        ),
                        Text(
                          "${data!['clients']['phone']}",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.5,
                              height: 1.4,
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : const Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 16.sp),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Order amount",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.4,
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(130, 139, 150, 1)
                                  : const Color.fromRGBO(136, 136, 126, 1),
                              fontSize: 14.sp),
                        ),
                        Text(
                          "${data!['total_sum']}",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.5,
                              height: 1.4,
                              color: Get.isDarkMode
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : const Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 16.sp),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          InkWell(
            child: SizedBox(
              height: 30,
              width: 1.sw - 30,
              child: const Icon(
                IconData(0xea4e, fontFamily: 'MIcon'),
                color: Color.fromRGBO(136, 136, 126, 1),
              ),
            ),
            onTap: () async {
              controller.activeOrder.value = data!;
              chatController.user.value = ChatUser(
                  id: data!['clients']['id'],
                  name:
                      "${data!['clients']['name']} ${data!['clients']['surname']}",
                  imageUrl: data!['clients']['image_url'],
                  role: 4);

              String origin =
                  "${data!['shop']['longtitude']},${data!['shop']['latitude']}";
              String destination =
                  "${data!['address']['longtitude']},${data!['address']['latitude']}";
              controller.getRoute(
                  data!['id'],
                  origin,
                  destination,
                  LatLng(double.parse(data!['shop']['latitude'].toString()),
                      double.parse(data!['shop']['longtitude'].toString())),
                  LatLng(double.parse(data!['address']['latitude'].toString()),
                      double.parse(data!['address']['longtitude'].toString())));
              showSheet(context, data);
            },
          )
        ],
      ),
    );
  }
}
