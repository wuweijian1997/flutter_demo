import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class ArcCanvasWidget extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.pink
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 10; i++) {
      paint.color = Colors.pink.withOpacity(1 - i / 10);
      canvas.drawArc(
          Rect.fromCenter(
              center: size.center(Offset.zero),
              width: size.width / 10 * i,
              height: size.width / 10 * i),
          -pi / 4 * 3, pi / 2, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
