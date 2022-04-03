import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/select_input.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class ClientInfoBottomModal extends GetView<OrderController> {
  const ClientInfoBottomModal({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
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
              "Client info",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 22.sp,
                  letterSpacing: -0.4,
                  color: HexColor("#000000")),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  width: 1.sw - 80,
                  child: SelectInput(
                    title: "Client",
                    child: DropdownButton<int>(
                      underline: Container(),
                      value: controller.clientId.value,
                      isExpanded: true,
                      icon: Icon(
                        const IconData(0xea4e, fontFamily: 'MIcon'),
                        size: 28.sp,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                      items: controller.clients.map((value) {
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
                        controller.clientId.value = value!;
                        controller.addresses.value = [];
                        controller.getClientAddresses(value);
                      },
                    ),
                    width: 1.sw - 80,
                  ),
                ),
                InkWell(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: HexColor("#16AA16")),
                    child: Icon(
                      const IconData(0xea13, fontFamily: 'MIcon'),
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                  onTap: () {
                    Get.toNamed("/clientAdd");
                  },
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 1.sw - 80,
                  child: SelectInput(
                    title: "Address",
                    child: DropdownButton<int>(
                      underline: Container(),
                      value: controller.addressId.value,
                      isExpanded: true,
                      icon: Icon(
                        const IconData(0xea4e, fontFamily: 'MIcon'),
                        size: 28.sp,
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                      items: controller.addresses.map((value) {
                        return DropdownMenuItem<int>(
                          value: value['id'],
                          child: Text(
                            value['address'],
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
                        controller.addressId.value = value!;
                      },
                    ),
                    width: 1.sw - 80,
                  ),
                ),
                InkWell(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: HexColor("#16AA16")),
                    child: Icon(
                      const IconData(0xea13, fontFamily: 'MIcon'),
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                  onTap: () {
                    Get.toNamed("/addressAdd");
                  },
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
