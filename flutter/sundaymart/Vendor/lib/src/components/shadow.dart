import 'package:flutter/material.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class CustomBoxShadow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;

    Paint shadowPaint = Paint()
      ..color = const Color.fromRGBO(181, 134, 21, 1)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 15);

    canvas.drawPath(
        Path()
          ..addRect(Rect.fromPoints(Offset(20, size.height - 10),
              Offset(size.width - 20, size.height)))
          ..fillType = PathFillType.evenOdd,
        shadowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
