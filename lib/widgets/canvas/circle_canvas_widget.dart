import 'dart:ui';

import 'package:flutter/material.dart';

class CircleCanvasWidget extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..strokeWidth = 10;
    for(int i = 0;i<10;i++) {
      paint.color = Colors.pink.withOpacity(i / 10);
      canvas.drawCircle(size.center(Offset.zero), (size.width - 40) / 2  - i * 20, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}