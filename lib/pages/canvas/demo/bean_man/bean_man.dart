import 'dart:math';

import 'package:demo/pages/canvas/demo/bean_man/color_double_tween.dart';
import 'package:flutter/material.dart';

/// 吃豆人
class BeanMan extends StatefulWidget {
  @override
  _BeanManState createState() => _BeanManState();
}

class _BeanManState extends State<BeanMan> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: _BeanManPainter(
          repaint: _controller,
        ),
        child: SizedBox(
          width: 100,
          height: 100,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _BeanManPainter extends CustomPainter {
  final Animation<double> repaint;

  /// 创建ColorDoubleTween
  final ColorDoubleTween tween = ColorDoubleTween(
    begin: ColorDouble(color: Colors.red, value: 10),
    end: ColorDouble(color: Colors.blue, value: 40),
  );

  _BeanManPainter({required this.repaint}) : super(repaint: repaint);

  Paint _paint = Paint();

  double get angle => tween.evaluate(repaint).value;

  Color get color => tween.evaluate(repaint).color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    final double radius = size.width / 2;
    canvas.translate(radius, size.height / 2);

    _drawHead(canvas, size);
    _drawEye(canvas, radius);
  }

  @override
  bool shouldRepaint(_BeanManPainter oldBean) => repaint != oldBean.repaint;

  /// 绘制头
  void _drawHead(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(
      center: Offset.zero,
      width: size.width,
      height: size.height,
    );
    var a = angle / 180 * pi;
    canvas.drawArc(rect, a, 2 * pi - a.abs() * 2, true, _paint..color = color);
  }

  void _drawEye(Canvas canvas, double radius) {
    canvas.drawCircle(
      Offset(radius * 0.15, -radius * 0.6),
      radius * 0.12,
      _paint..color = Colors.white,
    );
  }
}
