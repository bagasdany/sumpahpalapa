import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class BrandCategoryItem extends StatelessWidget {
  final String name;
  final Function() onPressEdit;
  final Function() onPressDelete;
  final bool isActive;
  const BrandCategoryItem(
      {Key? key,
      required this.name,
      required this.onPressEdit,
      required this.onPressDelete,
      required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw - 30,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: HexColor("#FFFFFF")),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: 32,
                width: 2,
                decoration: BoxDecoration(
                    color: isActive ? HexColor("#45A524") : HexColor("#D21234"),
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 1.sw - 170,
                child: Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: HexColor("#000000"),
                      fontSize: 14.sp,
                      letterSpacing: -0.4),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
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
                onTap: onPressEdit,
              ),
              InkWell(
                child: Container(
                  height: 36,
                  margin: const EdgeInsets.only(left: 10),
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
                onTap: onPressDelete,
              )
            ],
          )
        ],
      ),
    );
  }
}
