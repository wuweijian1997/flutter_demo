import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScanCanvas extends CustomPainter {
  double radius;
  double progress;
  List<Color> colors;
  double angle;
  Color lineColor;

  ScanCanvas({
    this.radius = 200,
    required this.progress,
    Color color = Colors.pink,
    this.angle = pi / 4,
    this.lineColor = Colors.pink})
      : colors = [color.withOpacity(0), color.withOpacity(0.1)];

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    final paint = Paint();
    Rect rect = Rect.fromCircle(
        center: center, radius: radius);
    paint
    ///抗锯齿
      ..isAntiAlias = true
    ///颜色渲染模式的质量
      ..filterQuality= FilterQuality.high
      ..strokeWidth = 1
    ///颜色
      ..color = lineColor;
//    canvas.drawArc(rect, 0, 2 * pi, false, paint);
//    paint.color = lineColor.withOpacity(0.8);
//    canvas.drawArc(Rect.fromCircle(center: center, radius: radius / 3 * 2 ), 0, 2 * pi, false, paint);
//    paint.color = lineColor.withOpacity(0.6);
//    canvas.drawArc(Rect.fromCircle(center: center, radius: radius / 3 * 1 ), 0, 2 * pi, false, paint);
    paint
    ///填充
      ..style = PaintingStyle.fill
    ///渐变
      ..shader = SweepGradient(startAngle: 0, endAngle: angle, colors: colors)
          .createShader(rect);
    canvas.rotate(progress * 2 * pi);
    canvas.drawArc(rect, 0, angle, true, paint);
  }

  @override
  bool shouldRepaint(ScanCanvas oldDelegate) {
    return oldDelegate.lineColor != lineColor ||
        oldDelegate.progress != progress ||
        oldDelegate.angle != angle ||
        oldDelegate.radius != radius ||
        !listEquals(oldDelegate.colors, colors);
  }
}
