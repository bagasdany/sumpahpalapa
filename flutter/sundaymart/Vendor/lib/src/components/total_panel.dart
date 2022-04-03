import 'package:flutter/material.dart';
import 'package:vendor/src/helpers/hex_color.dart';

class TotalPanel extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var rect = Offset.zero & size;
    paint.shader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        HexColor("#FFB300"),
        HexColor("#FEB101"),
        HexColor("#FF38AB"),
        HexColor("#FE0000"),
      ],
    ).createShader(rect);

    Paint shadowPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          HexColor("#FF6B00"),
          HexColor("#FF38AB"),
          HexColor("#FE0000"),
        ],
      ).createShader(rect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 15);

    canvas.drawPath(
        Path()
          ..addRect(Rect.fromPoints(Offset(20, size.height - 10),
              Offset(size.width - 20, size.height)))
          ..fillType = PathFillType.evenOdd,
        shadowPaint);

    var path = Path();
    path.moveTo(15, 0);
    path.lineTo(size.width / 4 - 10, 0);
    path.arcToPoint(Offset(size.width / 4, 5),
        radius: const Radius.circular(15));
    path.lineTo(size.width / 4 + 5, 10);
    path.arcToPoint(Offset(size.width / 4 + 10, 15),
        clockwise: false, radius: const Radius.circular(15));
    path.lineTo(size.width * 3 / 4 - 10, 15);
    path.arcToPoint(Offset(size.width * 3 / 4 - 5, 10),
        clockwise: false, radius: const Radius.circular(15));
    path.lineTo(size.width * 3 / 4, 5);
    path.arcToPoint(Offset(size.width * 3 / 4 + 10, 0),
        radius: const Radius.circular(15));
    path.lineTo(size.width - 15, 0);
    path.arcToPoint(Offset(size.width, 15), radius: const Radius.circular(15));
    path.lineTo(size.width, 15);
    path.lineTo(size.width, size.height - 15);
    path.arcToPoint(Offset(size.width - 15, size.height),
        radius: const Radius.circular(15));
    path.lineTo(size.width - 15, size.height);
    path.lineTo(15, size.height);
    path.arcToPoint(Offset(0, size.height - 15),
        radius: const Radius.circular(15));
    path.lineTo(0, size.height - 15);
    path.lineTo(0, 15);
    path.arcToPoint(const Offset(15, 0), radius: const Radius.circular(15));
    path.lineTo(15, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
