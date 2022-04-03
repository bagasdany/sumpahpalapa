import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class ProductCharacterItem extends StatelessWidget {
  final String ikey;
  final String value;
  final bool isActive;
  final Function() onDelete;
  final Function() onEdit;
  const ProductCharacterItem(
      {Key? key,
      required this.ikey,
      required this.isActive,
      required this.value,
      required this.onDelete,
      required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 30,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: HexColor("#ffffff"),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 2,
                spreadRadius: 0,
                color: Color.fromRGBO(200, 200, 200, 0.25))
          ],
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                width: 0.5.sw - 40,
                child: Text(
                  "$ikey:",
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: HexColor("#000000"),
                      letterSpacing: -0.5),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: 0.5.sw - 40,
                child: Text(
                  value,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: HexColor("#000000"),
                      letterSpacing: -0.5),
                ),
              )
            ],
          ),
          Divider(
            color: HexColor("#000000").withOpacity(0.05),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: HexColor("#16AA16").withOpacity(0.1)),
                child: Text(
                  isActive ? "Active" : "Inactive",
                  style: TextStyle(
                      color: HexColor("#16AA16"),
                      fontFamily: 'Inter',
                      fontSize: 14.sp,
                      letterSpacing: -0.4,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Row(
                children: <Widget>[
                  InkWell(
                    child: Container(
                      height: 36,
                      width: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: const Color.fromRGBO(0, 0, 0, 0.05)),
                      child: Icon(
                        const IconData(0xefe0, fontFamily: 'MIcon'),
                        color: HexColor("#000000"),
                        size: 20.sp,
                      ),
                    ),
                    onTap: () {
                      onEdit();
                    },
                  ),
                  InkWell(
                    child: Container(
                      height: 36,
                      margin: const EdgeInsets.only(left: 8),
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
                      onDelete();
                    },
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
