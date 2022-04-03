import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class OrderItemShadow extends StatelessWidget {
  const OrderItemShadow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
            width: 1.sw - 30,
            height: 150,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(251, 251, 248, 1),
                borderRadius: BorderRadius.circular(10))));
  }
}
