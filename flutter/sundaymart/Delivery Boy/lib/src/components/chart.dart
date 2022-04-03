import 'dart:math' as math;
import 'package:flutter/material.dart';

class Chart extends CustomPainter {
  final double? delivered;

  Chart({this.delivered});

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width / 15.0;
    final center = Offset(size.width / 2, size.height / 2);
    final shadowCenter = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    var paint = Paint()
      ..color = const Color.fromRGBO(69, 165, 36, 1)
      ..strokeWidth = 40
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var shadowPaint = Paint()
      ..color = const Color.fromRGBO(69, 165, 36, 0.8)
      ..strokeWidth = 40
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    var paint2 = Paint()
      ..color = const Color.fromRGBO(222, 31, 54, 1)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
        Rect.fromCircle(center: shadowCenter, radius: radius),
        (math.pi + 0.4) / 2,
        math.pi * 2 * (delivered! < 0.92 ? delivered! : 1),
        false,
        shadowPaint);

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
