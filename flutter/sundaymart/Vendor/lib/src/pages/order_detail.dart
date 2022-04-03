import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/components/dialog_error.dart';
import 'package:vendor/src/components/dialog_success.dart';
import 'package:vendor/src/components/order_detail_item.dart';
import 'package:vendor/src/components/order_detail_status_item.dart';
import 'package:vendor/src/controllers/order_controller.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/requests/orders_delete_request.dart';

class OrderDetail extends GetView<OrderController> {
  const OrderDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(controller.activeOrder['order_date']);
    String hour = "${date.hour}";
    if (date.hour < 10) hour = "0" + hour;
    String minute = "${date.minute}";
    if (date.minute < 10) minute = "0" + minute;
    String day = "${date.day}";
    if (date.day < 10) day = "0" + day;
    String month = "${date.month}";
    if (date.month < 10) month = "0" + month;

    print(controller.activeOrder);

    return Scaffold(
      backgroundColor: HexColor("#F9F9FA"),
      appBar: customAppBar(
          icon: const IconData(0xea60, fontFamily: 'MIcon'),
          onClickIcon: () {
            Get.back();
          },
          title: "Order — #${controller.activeOrder['id']}"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: <Widget>[
            OrderDetailItem(
              keyStr: "Name",
              value: "${controller.activeOrder['user']}",
            ),
            OrderDetailItem(
              keyStr: "Amount",
              value: "${controller.activeOrder['amount']}",
            ),
            OrderDetailItem(
              keyStr: "Shop",
              value: "${controller.activeOrder['shop']}",
            ),
            OrderDetailItem(
              keyStr: "Order date",
              value: "$day.$month.${date.year} | $hour:$minute",
            ),
            OrderDetailItem(
              keyStr: "Delivery date",
              value: "${controller.activeOrder['delivery_date']}",
              isUnderlined: false,
            ),
            const SizedBox(
              height: 25,
            ),
            OrderDetailStatusItem(
                title: "Order status",
                status: "${controller.activeOrder['order_status']}",
                statusColor: controller.statusColors[
                    controller.activeOrder['order_status_id'] - 1],
                statusBackColor: controller
                    .statusColors[controller.activeOrder['order_status_id'] - 1]
                    .withOpacity(0.1)),
            // OrderDetailStatusItem(
            //     title: "Payment status",
            //     status: "Not paid",
            //     statusColor: Color.fromRGBO(210, 18, 52, 1),
            //     statusBackColor: Color.fromRGBO(210, 18, 52, 0.1)),
            // OrderDetailStatusItem(
            //     title: "Payment method",
            //     status: "Cash",
            //     statusColor: Color.fromRGBO(22, 170, 22, 1),
            //     statusBackColor: Color.fromRGBO(22, 170, 22, 0.1))
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              child: Container(
                height: 50,
                width: 0.5.sw - 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 1, color: HexColor("#000000"))),
                child: Text(
                  "Delete",
                  style: TextStyle(
                      color: HexColor("#000000"),
                      fontFamily: 'Inter',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1),
                ),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    barrierColor: HexColor("#000000").withOpacity(0.2),
                    builder: (_) {
                      return DialogError(
                        title: "Delete order",
                        description:
                            "Do you want to delete order #${controller.activeOrder['id']}",
                        onPressOk: () async {
                          await ordersDeleteRequest(
                              controller.activeOrder['id']);
                          controller.orders.value = [];
                          controller.orders.refresh();
                          controller.loadData.value = true;
                          controller.getOrders(controller.orderStatusId.value);
                          Get.back();
                          Get.back();
                        },
                      );
                    });
              },
            ),
            InkWell(
              child: Container(
                height: 50,
                width: 0.5.sw - 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 1, color: HexColor("#000000"))),
                child: Text(
                  "Edit",
                  style: TextStyle(
                      color: HexColor("#000000"),
                      fontFamily: 'Inter',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1),
                ),
              ),
              onTap: () {
                controller.getInfoById(controller.activeOrder['id']);
                controller.edit.value = true;
                Get.toNamed("/orderAdd");
              },
            )
          ],
        ),
      ),
    );
  }
}
