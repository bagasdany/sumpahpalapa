import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vendor/src/helpers/hex_color.dart';
import 'package:shimmer/shimmer.dart';

class BrandItemShadow extends StatelessWidget {
  const BrandItemShadow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 1.sw - 30,
          height: 120,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              color: HexColor("#ffffff"),
              borderRadius: BorderRadius.circular(12)),
        ));
  }
}
