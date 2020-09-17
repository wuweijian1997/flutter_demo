import 'dart:ui';

import 'package:flutter/material.dart';

class ColorCanvasWidget extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.pink, BlendMode.src);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}