import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Chart extends CustomPainter {
  final double? delivered;

  Chart({this.delivered});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 0.18.sw;

    var paint = Paint()
      ..color = const Color.fromRGBO(255, 184, 0, 1)
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var paint2 = Paint()
      ..color = const Color.fromRGBO(243, 237, 222, 1)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        (math.pi + 0.4) / 2,
        math.pi * 2 * (delivered! < 0.92 ? delivered! : 1),
        false,
        paint);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        (math.pi - 0.1) / 2, -math.pi * 2 * (0.92 - delivered!), false, paint2);
  }

  @override
  bool shouldRepaint(Chart oldDelegate) {
    return false;
  }
}
