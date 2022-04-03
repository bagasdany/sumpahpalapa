import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/src/components/app_bar.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class DeliveryBoyEdit extends StatelessWidget {
  const DeliveryBoyEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#ECEFF3"),
      appBar: customAppBar(
          icon: const IconData(0xea60, fontFamily: 'MIcon'),
          onClickIcon: () {
            Get.back();
          },
          title: "Delivery boy edit"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
