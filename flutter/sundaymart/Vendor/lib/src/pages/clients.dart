import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/config/global_config.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/dialog_error.dart';
import 'package:vendor/src/components/shadow/product_item_shadow.dart';
import 'package:vendor/src/controllers/admin_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/requests/client_delete_request.dart';

class Clients extends GetView<AdminController> {
  const Clients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: HexColor("#ECEFF3"),
        appBar: customAppBar(
            icon: const IconData(0xea60, fontFamily: 'MIcon'),
            onClickIcon: () {
              Get.back();
            },
            title: "Clients"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 1.sw - 30,
                height: 1.sh - 100,
                child: NotificationListener(
                  onNotification: (t) {
                    if (t is ScrollEndNotification) {
                      if (t.metrics.atEdge &&
                          controller.scrollController.position.pixels > 0) {
                        controller.loadData.value = true;
                        controller.getClients();
                      }
                    }
                    return false;
                  },
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      itemCount: controller.loadData.value &&
                              controller.clients.length % 10 == 0
                          ? controller.clients.length + 10
                          : controller.clients.length,
                      controller: controller.scrollController,
                      itemBuilder: (_, index) {
                        if (index > controller.clients.length - 1) {
                          return const ProductItemShadow();
                        }
                        Map<String, dynamic> client = controller.clients[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          width: 1.sw - 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: HexColor("#ffffff")),
                          padding: const EdgeInsets.only(
                              top: 15, bottom: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 93,
                                width: 4,
                                decoration: BoxDecoration(
                                    color: client['active'] == 1
                                        ? HexColor("#45A524")
                                        : HexColor("#D21234"),
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 50,
                                        height: 50,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            color: HexColor("#000000")
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: client['image_url'] != null &&
                                                client['image_url'].length > 3
                                            ? ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "$globalImageUrl${client['image_url']}",
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                        // colorFilter:
                                                        //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                                      ),
                                                    ),
                                                  ),
                                                  placeholder: (context, url) =>
                                                      Container(
                                                    width: 250,
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      const IconData(0xee4b,
                                                          fontFamily: 'MIcon'),
                                                      color:
                                                          const Color.fromRGBO(
                                                              233, 233, 230, 1),
                                                      size: 40.sp,
                                                    ),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              )
                                            : Icon(
                                                const IconData(0xf254,
                                                    fontFamily: 'MIcon'),
                                                color: HexColor("#ffffff"),
                                              ),
                                      ),
                                      SizedBox(
                                          width: 1.sw - 165,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                  "${client['name']} ${client['surname']}",
                                                  style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: -0.5,
                                                      color:
                                                          HexColor("#000000"))),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text("${client['phone']}",
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          HexColor("#88887E"))),
                                            ],
                                          )),
                                      InkWell(
                                        child: Container(
                                          height: 36,
                                          margin:
                                              const EdgeInsets.only(left: 10),
                                          width: 36,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              color: const Color.fromRGBO(
                                                  0, 0, 0, 0.05)),
                                          child: Icon(
                                            const IconData(0xec24,
                                                fontFamily: 'MIcon'),
                                            color: HexColor("#000000"),
                                            size: 20.sp,
                                          ),
                                        ),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              barrierColor: HexColor("#000000")
                                                  .withOpacity(0.2),
                                              builder: (_) {
                                                return DialogError(
                                                  title: "Delete client",
                                                  description:
                                                      "Do you want to delete client #${client['id']}",
                                                  onPressOk: () async {
                                                    Get.back();
                                                    await clientDeleteRequest(
                                                        client['id']);
                                                    controller.loadData.value =
                                                        true;
                                                    controller.clients.value =
                                                        [];
                                                    controller.getClients();
                                                  },
                                                );
                                              });
                                        },
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color:
                                        HexColor("#000000").withOpacity(0.05),
                                  ),
                                  SizedBox(
                                    width: 1.sw - 60,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 1.sw - 220,
                                              child: Text(
                                                "Email",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    color: HexColor("#000000")
                                                        .withOpacity(0.5),
                                                    fontSize: 12.sp,
                                                    letterSpacing: -0.4),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 1.sw - 220,
                                              child: Text(
                                                "${client['email']}",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    fontWeight: FontWeight.w500,
                                                    color: HexColor("#000000"),
                                                    fontSize: 14.sp,
                                                    letterSpacing: -0.7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
