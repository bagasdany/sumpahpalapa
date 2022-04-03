import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapInfoShape extends CustomPainter {
  MapInfoShape();

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = Paint()
      ..color = const Color.fromRGBO(255, 184, 0, 1)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(1.sw - 130, 0);
    path_0.arcToPoint(Offset(1.sw - 130, 60),
        radius: const Radius.circular(15));
    path_0.lineTo(50 * (1.sw - 105) / 65, 60);
    path_0.lineTo(45 * (1.sw - 105) / 65, 75);
    path_0.arcToPoint(Offset(40 * (1.sw - 105) / 65, 80),
        radius: const Radius.circular(40));
    path_0.lineTo(25 * (1.sw - 105) / 65, 80);
    path_0.arcToPoint(Offset(20 * (1.sw - 105) / 65, 75),
        radius: const Radius.circular(40));
    path_0.lineTo(15 * (1.sw - 105) / 65, 60);
    path_0.lineTo(30, 60);
    path_0.arcToPoint(const Offset(30, 0), radius: const Radius.circular(15));
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    Paint shadowPaint = Paint()
      ..color = const Color.fromRGBO(255, 184, 0, 0.23)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 50);

    canvas.drawPath(path_0, shadowPaint);
  }

  @override
  bool shouldRepaint(MapInfoShape oldDelegate) {
    return false;
  }
}
