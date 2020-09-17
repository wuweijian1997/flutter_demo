import 'dart:ui';

import 'package:flutter/material.dart';

class LineCanvasWidget extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.red..strokeWidth = 10;
    for(int i = 0;i<10;i++) {
      var opacity = (5.0 - i).abs() / 5;
      paint.color = Colors.pink.withOpacity(opacity);
      canvas.drawLine(Offset(0, size.height / 10 * i  ), Offset(size.width, size.height / 10 * i), paint);
      canvas.drawLine(Offset(size.width / 10 * i, 0), Offset(size.width / 10 * i, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}