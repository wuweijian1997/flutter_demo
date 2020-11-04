import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class PointCanvasWidget extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.red..strokeWidth = 20;
    canvas.drawPoints(PointMode.points, [Offset(50, 50)], paint);
    ///圆点
    paint..strokeCap=StrokeCap.round..color = Colors.blue;
    canvas.drawPoints(PointMode.points, [Offset(100, 50)], paint);

    for(int i = 0; i< 10; i++) {
      for(int j = 0; j<10; j++) {
        var opacity = max((5.0 - i).abs(), (5.0 - j).abs()) / 5;
        paint.color = Colors.pink.withOpacity(opacity);
        canvas.drawPoints(PointMode.points, [Offset(50.0 + i* 30, 100.0 + j*30)], paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}