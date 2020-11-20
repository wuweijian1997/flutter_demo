import 'dart:ui';
import 'package:flutter/material.dart';
import 'index.dart';

class DefaultFlashlightDelegate extends FlashlightDelegate {
  final double radius;

  const DefaultFlashlightDelegate({this.radius = 50});

  @override
  void paint(Canvas canvas, Offset touchOffset) {
    if (touchOffset != null) {
      Rect rect = Rect.fromCircle(center: touchOffset, radius: radius / 2);
      Paint paint = Paint()
        ..style = PaintingStyle.fill
        ..shader = RadialGradient(
          radius: 1,
          colors: [
            Colors.white,
            Colors.white.withOpacity(.8),
            Colors.transparent,
          ],
        ).createShader(rect);
      canvas.drawCircle(touchOffset, radius, paint);
    }
  }
}
