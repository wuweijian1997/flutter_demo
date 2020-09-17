import 'dart:ui';

import 'package:flutter/material.dart';

class OvalCanvasWidget extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..strokeWidth = 10..color = Colors.pink..style=PaintingStyle.stroke;
    canvas.drawOval(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}