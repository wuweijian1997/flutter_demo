import 'package:demo/model/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BubbleCanvasWidget extends CustomPainter {
  List<BubbleModel> list;
  Color color;

  BubbleCanvasWidget({this.list, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    canvas.drawColor(color, BlendMode.src);
    list.forEach((ball) {
      paint..color = ball.color;
      canvas.drawCircle(ball.offset, ball.radius, paint);
    });
  }

  @override
  bool shouldRepaint(BubbleCanvasWidget oldDelegate) =>
      !listEquals(list, oldDelegate.list) || color != oldDelegate.color;
}
