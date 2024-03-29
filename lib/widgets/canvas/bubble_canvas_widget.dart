import 'package:demo/model/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BubbleCanvasWidget extends CustomPainter {
  List<BubbleModel> list;
  Color color;

  BubbleCanvasWidget({required this.list, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    canvas.drawColor(color, BlendMode.src);
    for (var ball in list) {
      paint.color = ball.color;
      canvas.drawCircle(ball.offset!, ball.radius, paint);
    }
  }

  @override
  bool shouldRepaint(BubbleCanvasWidget oldDelegate) =>
      !listEquals(list, oldDelegate.list) || color != oldDelegate.color;
}
