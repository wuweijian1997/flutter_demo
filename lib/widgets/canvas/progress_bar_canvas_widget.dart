import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProgressBarCanvasWidget extends CustomPainter {
  double progress;
  double radius;
  double width;

  List<Color> colors;

  ProgressBarCanvasWidget({required this.progress, this.radius = 140, this.width = 20, colors})
      : colors = colors ?? [Colors.pink.withOpacity(0), Colors.pink];

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(endAngle: 2 * pi, colors: colors).createShader(rect);
    double star = asin(width / 2 / radius);
    canvas.drawArc(rect, star, 2 * pi * progress, false, paint);
  }

  @override
  bool shouldRepaint(ProgressBarCanvasWidget oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.radius != radius ||
      oldDelegate.width != width ||
      !listEquals(oldDelegate.colors, colors);
}
