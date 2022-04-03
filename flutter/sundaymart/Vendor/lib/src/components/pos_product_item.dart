import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/config/global_config.dart';
import 'package:vendor/src/components/extras.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class PosProductItem extends GetView<OrderController> {
  final Map<String, dynamic> product;
  final Function onAdd;
  const PosProductItem({Key? key, required this.product, required this.onAdd})
      : super(key: key);

  void bottomDialog(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        builder: (BuildContext context) {
          return Container(
            width: 1.sw,
            height: 0.9.sh,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            decoration: BoxDecoration(
                color: HexColor("#ffffff"),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Add extra products",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 22.sp,
                          letterSpacing: -0.4,
                          color: HexColor("#000000")),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 100,
                      width: 1.sw - 30,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(width: 1, color: HexColor("#EFEFEF"))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: "$globalImageUrl${product['image_url']}",
                            height: 70,
                            width: 60,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fitHeight,
                                  // colorFilter:
                                  //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              width: 60,
                              alignment: Alignment.center,
                              child: Icon(
                                const IconData(0xee4b, fontFamily: 'MIcon'),
                                color: const Color.fromRGBO(233, 233, 230, 1),
                                size: 40.sp,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                child: Text(
                                  "${product['name']}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontFamily: 'Inter',
                                      height: 2,
                                      color: HexColor("#000000"),
                                      fontWeight: FontWeight.w400),
                                ),
                                width: 1.sw - 150,
                              ),
                              Text(
                                "Instock — ${product['amount']}",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Inter',
                                    color: HexColor("#16AA16"),
                                    letterSpacing: -0.5,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "${product['price']}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontFamily: 'Inter',
                                    letterSpacing: -0.5,
                                    color: HexColor("#000000"),
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 0.9.sh - 350,
                      width: 1.sw,
                      child: SingleChildScrollView(
                        child: FutureBuilder<List>(
                          future: controller.getExtras(product['id']),
                          builder: (BuildContext context,
                              AsyncSnapshot<List> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Container();
                              default:
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  List? extras = snapshot.data;

                                  return extras!.isNotEmpty
                                      ? Extras(
                                          extras: extras,
                                          onChange: (List temp) {
                                            controller.tempExtrasState.value =
                                                temp;
                                          },
                                        )
                                      : Container();
                                }
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                if (controller.tempExtrasState.isNotEmpty)
                  InkWell(
                    onTap: () {
                      if (controller.tempExtrasState.isNotEmpty) {
                        for (int i = 0;
                            i < controller.tempExtrasState.length;
                            i++) {
                          Map<String, dynamic> extra =
                              controller.tempExtrasState[i];

                          controller.addToExtras(
                              extra['id_product'],
                              extra['id_extra_group'],
                              extra['id'],
                              extra['language']['name'],
                              extra['price']);
                        }
                      }
                      Get.back();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 20),
                      width: 1.sw - 30,
                      height: 60,
                      decoration: BoxDecoration(
                          color: HexColor("#16AA16"),
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
                              "Add Extras",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                  letterSpacing: -0.4,
                                  color: HexColor("#ffffff")),
                            ),
                    ),
                  )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5.sw - 20,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(top: 10),
      height: 240,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: HexColor("#ffffff")),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: "$globalImageUrl${product['image_url']}",
            height: 100,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fitHeight,
                  // colorFilter:
                  //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              width: 250,
              alignment: Alignment.center,
              child: Icon(
                const IconData(0xee4b, fontFamily: 'MIcon'),
                color: const Color.fromRGBO(233, 233, 230, 1),
                size: 40.sp,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${product['name']}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Inter',
                      height: 2,
                      color: HexColor("#000000"),
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "Instock — ${product['amount']}",
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      color: HexColor("#16AA16"),
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "${product['price']}",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Inter',
                  letterSpacing: -0.5,
                  color: HexColor("#000000"),
                  fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            height: 40,
            width: 0.5.sw - 20,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 1,
                        color: HexColor("#000000").withOpacity(0.1)))),
            child: Row(
              children: <Widget>[
                InkWell(
                  child: Container(
                    height: 39,
                    width: 0.25.sw - 10,
                    decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(
                                width: 1,
                                color: HexColor("#000000").withOpacity(0.1)))),
                    child: Icon(
                      const IconData(0xf00e, fontFamily: 'MIcon'),
                      size: 20.sp,
                      color: HexColor("#000000"),
                    ),
                  ),
                  onTap: () {
                    controller.tempExtrasState.value = [];
                    bottomDialog(context);
                  },
                ),
                InkWell(
                  child: SizedBox(
                    height: 39,
                    width: 0.25.sw - 10,
                    child: Icon(
                      const IconData(0xea12, fontFamily: 'MIcon'),
                      size: 24.sp,
                      color: HexColor("#000000"),
                    ),
                  ),
                  onTap: () {
                    onAdd();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
