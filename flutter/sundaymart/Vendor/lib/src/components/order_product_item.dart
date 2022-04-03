import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/extras.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderProductItem extends GetView<OrderController> {
  final Map<String, dynamic> product;

  const OrderProductItem({Key? key, required this.product}) : super(key: key);
  void bottomExtraDialog(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return Obx(() {
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
                InkWell(
                  onTap: () {
                    if (controller.tempExtrasState.isNotEmpty) {
                      for (int i = 0;
                          i < controller.tempExtrasState.length;
                          i++) {
                        Map<String, dynamic> extra =
                            controller.tempExtrasState[i];

                        controller.addExtrasToProduct(
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
                    margin:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 20),
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
                            "Add Products",
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
      },
    );
  }

  void bottomDialog(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return Obx(() {
          return Container(
            height: 0.7.sh,
            width: 1.sw,
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
                      "Replase product",
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 22.sp,
                          letterSpacing: -0.4,
                          color: HexColor("#000000")),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SelectInput(
                      title: "Products",
                      child: DropdownButton<int>(
                        underline: Container(),
                        value: controller.productActiveId.value,
                        isExpanded: true,
                        icon: Icon(
                          const IconData(0xea4e, fontFamily: 'MIcon'),
                          size: 28.sp,
                          color: const Color.fromRGBO(0, 0, 0, 1),
                        ),
                        items: controller.productActive.map((value) {
                          return DropdownMenuItem<int>(
                            value: value['id'],
                            child: Text(
                              value['name'].length >= 50
                                  ? value['name'].substring(0, 50)
                                  : value['name'],
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
                          controller.productActiveId.value = value!;
                        },
                      ),
                      width: 1.sw - 30,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 5, bottom: 20),
                        width: 0.5.sw - 20,
                        height: 60,
                        decoration: BoxDecoration(
                            color: HexColor("#000000").withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                              letterSpacing: -0.4,
                              color: HexColor("#000000")),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.handleOk();
                        Get.back();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 5, bottom: 20),
                        width: 0.5.sw - 20,
                        height: 60,
                        decoration: BoxDecoration(
                            color: HexColor("#16AA16"),
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        child: Text(
                          "Ok",
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
                )
              ],
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String extrasName = "";
    double extrasPrice = 0;
    if (product['extras'].length > 0) {
      extrasName = product['extras']
          .map((item) {
            return item['extras_name'];
          })
          .toList()
          .join(",");

      extrasPrice = double.parse(
          product['extras'].fold(0, (e, t) => e + t['price']).toString());
    }

    return Container(
      width: 1.sw - 30,
      margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: product['is_replaced'] != null
              ? const Color.fromRGBO(222, 31, 54, 0.05)
              : product['id_replace_product'] != null
                  ? const Color.fromRGBO(69, 165, 36, 0.05)
                  : HexColor("#ffffff"),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: HexColor("#EFEFEF"))),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    width: 0.5.sw - 30,
                    child: Text(
                      "${product['name']}",
                      softWrap: true,
                      style: TextStyle(
                          color: HexColor("#000000"),
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.4),
                    ),
                  ),
                  SizedBox(
                    width: 0.5.sw - 30,
                    child: Text(
                      extrasName,
                      softWrap: true,
                      style: TextStyle(
                          color: HexColor("#DE1F36"),
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.4),
                    ),
                  ),
                ],
              ),
              if (product['options']['replace'] != null &&
                  product['is_replaced'] != 1)
                InkWell(
                  child: Container(
                    height: 35,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: HexColor("#F19204").withOpacity(0.1),
                        borderRadius: BorderRadius.circular(18)),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          const IconData(0xea74, fontFamily: 'MIcon'),
                          color: HexColor("#F19204"),
                          size: 14.sp,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Replase",
                          style: TextStyle(
                              color: HexColor("#F19204"),
                              fontFamily: 'Inter',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.5),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    controller.replaceProductId.value = product['id'];
                    bottomDialog(context);
                  },
                ),
              InkWell(
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: const Color.fromRGBO(0, 0, 0, 0.05)),
                  child: Icon(
                    const IconData(0xf00e, fontFamily: 'MIcon'),
                    color: HexColor("#000000"),
                    size: 20.sp,
                  ),
                ),
                onTap: () {
                  controller.tempExtrasState.value = [];
                  bottomExtraDialog(context);
                },
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Price",
                    softWrap: true,
                    style: TextStyle(
                        color: HexColor("#AAAAAA"),
                        fontFamily: 'Inter',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.4),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 0.18.sw,
                    child: RichText(
                      text: TextSpan(
                          text: "${product['price']}",
                          style: TextStyle(
                              color: HexColor("#000000"),
                              fontFamily: 'Inter',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.4),
                          children: <TextSpan>[
                            if (extrasName.isNotEmpty)
                              TextSpan(
                                text: " + $extrasPrice",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Inter',
                                    letterSpacing: -0.4,
                                    color: HexColor("#DE1F36"),
                                    fontWeight: FontWeight.w500),
                              ),
                          ]),
                    ),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Total",
                    softWrap: true,
                    style: TextStyle(
                        color: HexColor("#AAAAAA"),
                        fontFamily: 'Inter',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.4),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    double.parse(product['price_total'].toString())
                        .toStringAsFixed(2),
                    softWrap: true,
                    style: TextStyle(
                        color: HexColor("#000000"),
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.4),
                  ),
                ],
              ),
              SizedBox(
                width: 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 110,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: const Color.fromRGBO(0, 0, 0, 0.05)),
                              child: Icon(
                                const IconData(0xf1af, fontFamily: 'MIcon'),
                                color: HexColor("#000000"),
                                size: 20.sp,
                              ),
                            ),
                            onTap: () {
                              if (product['is_replaced'] == null) {
                                controller.onDecrement(product['id']);
                              }
                            },
                          ),
                          Text(
                            "${product['quantity']}",
                            softWrap: true,
                            style: TextStyle(
                                color: HexColor("#000000"),
                                fontFamily: 'Inter',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.4),
                          ),
                          InkWell(
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  color: const Color.fromRGBO(0, 0, 0, 0.05)),
                              child: Icon(
                                const IconData(0xea13, fontFamily: 'MIcon'),
                                color: HexColor("#000000"),
                                size: 20.sp,
                              ),
                            ),
                            onTap: () {
                              if (product['is_replaced'] == null) {
                                controller.onIncrement(product['id']);
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    if (product['options']['delete'] != null &&
                        product['is_replaced'] != 1)
                      InkWell(
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: const Color.fromRGBO(0, 0, 0, 0.05)),
                          child: Icon(
                            const IconData(0xec24, fontFamily: 'MIcon'),
                            color: HexColor("#000000"),
                            size: 20.sp,
                          ),
                        ),
                        onTap: () {
                          controller.deleteProduct(product['id']);
                        },
                      )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
