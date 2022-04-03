import 'package:cached_network_image/cached_network_image.dart';
import 'package:deliveryboy/config/global_config.dart';
import 'package:deliveryboy/src/components/info_row.dart';
import 'package:deliveryboy/src/components/product_item.dart';
import 'package:deliveryboy/src/controllers/chat_controller.dart';
import 'package:deliveryboy/src/controllers/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetail extends GetView<OrderController> {
  final Map<String, dynamic>? data;
  final Function? onChangeStatus;
  OrderDetail({Key? key, this.data, this.onChangeStatus}) : super(key: key);

  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? const Color.fromRGBO(37, 48, 63, 1)
            : const Color.fromRGBO(255, 255, 255, 1),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(
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
                            width:
                                data!['clients']['image_url'] != null ? 0 : 10,
                            color: Get.isDarkMode
                                ? const Color.fromRGBO(37, 48, 63, 1)
                                : const Color.fromRGBO(232, 232, 232, 0.35)),
                        borderRadius: BorderRadius.circular(
                          30,
                        )),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: data!['clients']['image_url'] != null
                          ? CachedNetworkImage(
                              width: 40,
                              height: 40,
                              fit: BoxFit.fill,
                              imageUrl:
                                  "$globalImageUrl${data!['clients']['image_url']}",
                              placeholder: (context, url) => Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                child: Icon(
                                  const IconData(0xee4b, fontFamily: 'MIcon'),
                                  color: const Color.fromRGBO(233, 233, 230, 1),
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
                        "${data!['clients']['name']} ${data!['clients']['surname']}",
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
                        "${data!['clients']['phone']}",
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
                  if (data!['clients']['phone'] != null)
                    InkWell(
                      onTap: () async {
                        String url = "tel:${data!['clients']['phone']}";
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
                    onTap: () async {
                      chatController.dialog(chatController.user.value!.id!, 2);
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
            height: 20,
          ),
          const Divider(
            color: Color.fromRGBO(0, 0, 0, 0.1),
          ),
          const SizedBox(
            height: 20,
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
                          fontSize: 14.sp,
                          height: 1.3,
                          letterSpacing: -0.4,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(130, 139, 150, 1)
                              : const Color.fromRGBO(136, 136, 126, 1)),
                    ),
                    Text(
                      "${data!['shop']['language']['name']}",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          height: 1.2,
                          letterSpacing: -0.4,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(255, 255, 255, 1)
                              : const Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    Text(
                      "${data!['shop']['language']['address']} ",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
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
                          fontSize: 14.sp,
                          height: 1.3,
                          letterSpacing: -0.4,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(130, 139, 150, 1)
                              : const Color.fromRGBO(136, 136, 126, 1)),
                    ),
                    Text(
                      "${data!['clients']['name']} ${data!['clients']['surname']}",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          height: 1.2,
                          letterSpacing: -0.4,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(255, 255, 255, 1)
                              : const Color.fromRGBO(0, 0, 0, 1)),
                    ),
                    Text(
                      "${data!['address']['address']}",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
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
            height: 50,
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      const IconData(0xee59, fontFamily: 'MIcon'),
                      size: 24.sp,
                      color: Get.isDarkMode
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(0, 0, 0, 1),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Shop info",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          letterSpacing: -1,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(255, 255, 255, 1)
                              : const Color.fromRGBO(0, 0, 0, 1)),
                    ),
                  ],
                ),
                InfoRow(
                  value: "${data!['shop']['language']['name']}",
                  title: "Name",
                ),
                InfoRow(
                  value: "${data!['shop']['phone']}",
                  title: "Phone",
                ),
                InfoRow(
                  value: "${data!['shop']['language']['address']}",
                  title: "Address",
                  hasUnderline: false,
                ),
              ],
            ),
          ),
          const Divider(color: Color.fromRGBO(0, 0, 0, 0.1)),
          Container(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      const IconData(0xeced, fontFamily: 'MIcon'),
                      size: 24.sp,
                      color: Get.isDarkMode
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(0, 0, 0, 1),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Order info",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          letterSpacing: -1,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(255, 255, 255, 1)
                              : const Color.fromRGBO(0, 0, 0, 1)),
                    ),
                  ],
                ),
                InfoRow(
                  value: "#${data!['id']}",
                  title: "Order ID",
                ),
                InfoRow(
                  value: "${data!['total_sum']}",
                  title: "Order amount",
                ),
                InfoRow(
                  value:
                      "${data!['delivery_date']} | ${data!['time_unit']['name']}",
                  title: "Delivery time",
                  hasUnderline: false,
                ),
              ],
            ),
          ),
          const Divider(color: Color.fromRGBO(0, 0, 0, 0.1)),
          Container(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      const IconData(0xf116, fontFamily: 'MIcon'),
                      size: 24.sp,
                      color: Get.isDarkMode
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(0, 0, 0, 1),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Items",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                          letterSpacing: -1,
                          color: Get.isDarkMode
                              ? const Color.fromRGBO(255, 255, 255, 1)
                              : const Color.fromRGBO(0, 0, 0, 1)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: data!['details'].map<Widget>((item) {
                    var index = data!['details']
                        .indexWhere((element) => element['id'] == item['id']);

                    return ProductItem(
                      orderItem: item,
                      checkEnabled: false,
                      type: item['is_replaced'] == 1
                          ? 3
                          : item['id_replace_product'] != null
                              ? 2
                              : 1,
                      hasUnderline: index < data!['details'].length - 1,
                    );
                  }).toList(),
                )
              ],
            ),
          ),
          const Divider(color: Color.fromRGBO(0, 0, 0, 0.1)),
          const SizedBox(
            height: 40,
          ),
          if (data!['order_status'] == 2)
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                                "On way".tr,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1)),
                              ),
                      ),
                      onTap: () async {
                        await controller.changeStatus(data!['id'], 3);
                        onChangeStatus!();
                        Get.back();
                      },
                    ),
                  ],
                )),
          if (data!['order_status'] == 3)
            Obx(
              () => Row(
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
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 1)),
                            ),
                    ),
                    onTap: () async {
                      await controller.changeStatus(data!['id'], 4);
                      onChangeStatus!();
                      Get.back();
                    },
                  ),
                  if (controller.activeCoords.isNotEmpty)
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
                              Icon(const IconData(0xef88, fontFamily: 'MIcon'),
                                  size: 20.sp,
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 1)),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Navigate".tr,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    color:
                                        const Color.fromRGBO(255, 255, 255, 1)),
                              ),
                            ],
                          )),
                      onTap: () async {
                        Get.toNamed("/map");
                      },
                    ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
