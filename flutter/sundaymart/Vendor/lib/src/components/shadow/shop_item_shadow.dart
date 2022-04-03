import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class ShopItemShadow extends StatelessWidget {
  const ShopItemShadow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 1.sw - 30,
          margin: const EdgeInsets.only(bottom: 12),
          height: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: HexColor("#ffffff")),
        ));
  }
}
