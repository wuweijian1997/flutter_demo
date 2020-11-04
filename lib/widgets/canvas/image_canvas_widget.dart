import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/material.dart';

class ImageCanvasWidget extends CustomPainter {
  ui.Image image;

  ImageCanvasWidget({this.image});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        Rect.fromLTWH(0, 0, size.width, size.height),
        paint);
    TextSpan span = TextSpan(
      text: 'Kafka',
      style: TextStyle(fontSize: 25, color: Colors.black),
    );
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(size.width - 100, size.height - 50));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
