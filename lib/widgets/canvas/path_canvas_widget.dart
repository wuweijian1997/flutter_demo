import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class PathCanvasWidget extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.red..strokeWidth = 10..style=PaintingStyle.stroke;
    Path path = Path();
    path.moveTo(size.width / 2, size.height / 2);
    path.lineTo(size.width / 2 + 100, size.height / 2 + sqrt(30000));
    path.lineTo(size.width / 2 - 100, size.height / 2 + sqrt(30000));
    path.close();
    canvas.drawPath(path, paint);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}