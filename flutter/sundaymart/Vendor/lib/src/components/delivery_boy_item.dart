import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class DeliveryBoyItem extends StatelessWidget {
  final bool isActive;
  final int id;
  final String shopName;
  final String name;
  final String balance;
  final Function() onEdit;
  const DeliveryBoyItem(
      {Key? key,
      required this.isActive,
      required this.name,
      required this.balance,
      required this.id,
      required this.onEdit,
      required this.shopName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 1.sw - 30,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: HexColor("#ffffff")),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 93,
            width: 4,
            decoration: BoxDecoration(
                color: isActive ? HexColor("#45A524") : HexColor("#D21234"),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 0.5.sw - 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 10),
                          decoration: BoxDecoration(
                              color: HexColor("#F4F4F4"),
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(
                            "ID — #$id",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                letterSpacing: -0.4,
                                color: HexColor("#000000")),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 0.5.sw - 70,
                    child: Row(
                      children: <Widget>[
                        Text(
                          balance,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              letterSpacing: -0.4,
                              color: HexColor("#000000")),
                        ),
                      ],
                    ),
                  ),
                  // InkWell(
                  //   child: Container(
                  //     width: 35,
                  //     height: 35,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(20),
                  //         color: HexColor("#000000").withOpacity(0.05)),
                  //     child: Icon(
                  //       const IconData(0xefe0, fontFamily: 'MIcon'),
                  //       color: HexColor("#000000"),
                  //       size: 18.sp,
                  //     ),
                  //   ),
                  //   onTap: onEdit,
                  // )
                ],
              ),
              SizedBox(
                width: 1.sw - 70,
                child: Divider(
                  color: HexColor("#000000").withOpacity(0.05),
                  height: 1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 0.5.sw - 35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              letterSpacing: -0.4,
                              color: HexColor("#88887E")),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          name,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              letterSpacing: -0.4,
                              color: HexColor("#000000")),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 0.5.sw - 35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Shop name",
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              letterSpacing: -0.4,
                              color: HexColor("#88887E")),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          shopName,
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              letterSpacing: -0.4,
                              color: HexColor("#000000")),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
