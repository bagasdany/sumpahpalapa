import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:shimmer/shimmer.dart';

class PosProductItemShadow extends StatelessWidget {
  const PosProductItemShadow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 0.5.sw - 20,
          margin: const EdgeInsets.only(bottom: 10),
          height: 240,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: HexColor("#ffffff")),
        ));
  }
}
