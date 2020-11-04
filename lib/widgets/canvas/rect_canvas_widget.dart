import 'dart:ui';

import 'package:flutter/material.dart';

class RectCanvasWidget extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.pink
      ..style = PaintingStyle.stroke;
    Offset center = size.center(Offset.zero);
    canvas.drawRect(Rect.fromCenter(center: center, width: 300, height: 300), paint);
    paint.color = Colors.red;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: 250, height: 250), Radius.circular(16)), paint);
    paint.color = Colors.blue;
    canvas.drawDRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: 200, height: 200), Radius.circular(5))
        , RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: 150, height: 150), Radius.circular(30)), paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
