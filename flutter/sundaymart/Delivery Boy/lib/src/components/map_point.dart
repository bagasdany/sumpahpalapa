import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapPoint extends StatelessWidget {
  final bool? isActive;

  const MapPoint({Key? key, this.isActive = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (1.sw - 170) / 15,
      height: 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: isActive!
              ? const Color.fromRGBO(255, 255, 255, 1)
              : const Color.fromRGBO(243, 213, 107, 1)),
    );
  }
}
