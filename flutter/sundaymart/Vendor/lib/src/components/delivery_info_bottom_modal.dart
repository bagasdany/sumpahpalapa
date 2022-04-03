import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryInfoBottomModal extends GetView<OrderController> {
  final ScrollController scrollController;
  const DeliveryInfoBottomModal({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        controller: scrollController,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
          constraints: const BoxConstraints(minHeight: 500),
          width: 1.sw,
          decoration: BoxDecoration(
              color: HexColor("#ffffff"),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                "Delivery info",
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
              SelectInput(
                title: "Delivery type",
                child: DropdownButton<int>(
                  underline: Container(),
                  value: controller.deliveryTypeId.value,
                  isExpanded: true,
                  icon: Icon(
                    const IconData(0xea4e, fontFamily: 'MIcon'),
                    size: 28.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                  items: [
                    {"id": 1, "name": "Delivery"},
                    {"id": 2, "name": "Pickup"}
                  ].map((Map<String, dynamic> value) {
                    return DropdownMenuItem<int>(
                      value: value['id'],
                      child: Text(
                        "${value['name']}",
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
                    controller.deliveryTypeId.value = value!;
                  },
                ),
                width: 1.sw - 30,
              ),
              const SizedBox(
                height: 30,
              ),
              SelectInput(
                title: "Delivery date",
                child: DropdownButton<String>(
                  underline: Container(),
                  value: controller.deliveryDate.value,
                  isExpanded: true,
                  icon: Icon(
                    const IconData(0xea4e, fontFamily: 'MIcon'),
                    size: 28.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                  items: controller.deliveryDates.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: HexColor("#000000"),
                            fontFamily: "MIcon",
                            fontSize: 16.sp,
                            letterSpacing: -0.4),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    controller.deliveryDate.value = value!;
                  },
                ),
                width: 1.sw - 30,
              ),
              const SizedBox(
                height: 30,
              ),
              SelectInput(
                title: "Delivery time",
                child: DropdownButton<int>(
                  underline: Container(),
                  value: controller.deliveryTimeId.value,
                  isExpanded: true,
                  icon: Icon(
                    const IconData(0xea4e, fontFamily: 'MIcon'),
                    size: 28.sp,
                    color: const Color.fromRGBO(0, 0, 0, 1),
                  ),
                  items: controller.deliveryTimes.map((value) {
                    return DropdownMenuItem<int>(
                      value: value['id'],
                      child: Text(
                        "${value['name']}",
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
                    controller.deliveryTimeId.value = value!;
                  },
                ),
                width: 1.sw - 30,
              ),
              if (controller.deliveryTypeId.value == 1)
                const SizedBox(
                  height: 30,
                ),
              if (controller.deliveryTypeId.value == 1)
                SelectInput(
                  title: "Delivery boy",
                  child: DropdownButton<int>(
                    underline: Container(),
                    value: controller.deliveryBoyId.value,
                    isExpanded: true,
                    icon: Icon(
                      const IconData(0xea4e, fontFamily: 'MIcon'),
                      size: 28.sp,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                    items: controller.deliveryBoys.map((value) {
                      return DropdownMenuItem<int>(
                        value: value['id'],
                        child: Text(
                          "${value['name']} ${value['surname']}",
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
                      controller.deliveryBoyId.value = value!;
                    },
                  ),
                  width: 1.sw - 30,
                ),
              if (controller.deliveryTypeId.value == 1)
                const SizedBox(
                  height: 30,
                ),
              if (controller.deliveryTypeId.value == 1)
                SelectInput(
                  title: "Shipping plan",
                  child: DropdownButton<int>(
                    underline: Container(),
                    value: controller.shippingPlanId.value,
                    isExpanded: true,
                    icon: Icon(
                      const IconData(0xea4e, fontFamily: 'MIcon'),
                      size: 28.sp,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                    items: controller.shippingPlans.map((value) {
                      return DropdownMenuItem<int>(
                        value: value['id'],
                        child: Text(
                          "${value['delivery_type']['name']}",
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
                      controller.shippingPlanId.value = value!;
                    },
                  ),
                  width: 1.sw - 30,
                ),
              if (controller.deliveryTypeId.value == 1)
                const SizedBox(
                  height: 30,
                ),
              if (controller.deliveryTypeId.value == 1)
                SelectInput(
                  title: "Shipping transport",
                  child: DropdownButton<int>(
                    underline: Container(),
                    value: controller.shippingTransportId.value,
                    isExpanded: true,
                    icon: Icon(
                      const IconData(0xea4e, fontFamily: 'MIcon'),
                      size: 28.sp,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                    items: controller.shippingTransports.map((value) {
                      return DropdownMenuItem<int>(
                        value: value['id'],
                        child: Text(
                          "${value['delivery_transport']['name']}",
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
                      controller.shippingTransportId.value = value!;
                    },
                  ),
                  width: 1.sw - 30,
                ),
              if (controller.deliveryTypeId.value == 1)
                const SizedBox(
                  height: 30,
                ),
              if (controller.deliveryTypeId.value == 1)
                SelectInput(
                  title: "Shipping Box",
                  child: DropdownButton<int>(
                    underline: Container(),
                    value: controller.shippingBoxId.value,
                    isExpanded: true,
                    icon: Icon(
                      const IconData(0xea4e, fontFamily: 'MIcon'),
                      size: 28.sp,
                      color: const Color.fromRGBO(0, 0, 0, 1),
                    ),
                    items: controller.shippingBoxs.map((value) {
                      return DropdownMenuItem<int>(
                        value: value['id'],
                        child: Text(
                          "${value['shipping_box']['name']}",
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
                      controller.shippingBoxId.value = value!;
                    },
                  ),
                  width: 1.sw - 30,
                ),
              if (controller.deliveryTypeId.value == 1)
                const SizedBox(
                  height: 30,
                ),
              if (controller.deliveryTypeId.value == 1)
                Text(
                  "Delivery boy comment",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.4,
                      color: const Color.fromRGBO(0, 0, 0, 0.3)),
                ),
              if (controller.deliveryTypeId.value == 1)
                Container(
                  width: 1.sw - 30,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(143, 146, 161, 0.05),
                      borderRadius: BorderRadius.circular(15)),
                  child: TextField(
                    controller: controller.deliveryBoyCommentController,
                    maxLines: 6,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        letterSpacing: -0.4,
                        color: HexColor("#000000")),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: InputBorder.none,
                        hintText: "Type here",
                        hintStyle: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            letterSpacing: -0.4,
                            color: HexColor("#AFAFAF"))),
                  ),
                ),
              const SizedBox(
                height: 300,
              ),
            ],
          ),
        ),
      );
    });
  }
}
