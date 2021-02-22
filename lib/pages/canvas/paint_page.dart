import 'package:flutter/material.dart';

class PaintPage extends StatefulWidget {
  static const rName = 'Paint';
  @override
  _PaintPageState createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: PaintCustomPainter(),
        child: Container(),
      ),
    );
  }
}

class PaintCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    drawStyleStrokeWidth(canvas);
  }

  // 测试 style 和 strokeWidth 属性
  void drawStyleStrokeWidth(Canvas canvas) {
    Paint paint = Paint()..color = Colors.red..strokeWidth = 50;
    canvas.drawCircle(Offset(180, 180), 150, paint..style=PaintingStyle.stroke);
    canvas.drawCircle(Offset(180 + 360.0, 180), 150, paint..style=PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}