import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class PaintPage extends StatefulWidget {
  static const rName = 'Paint';

  @override
  _PaintPageState createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> {
  var list = <ListPageModel>[];

  @override
  void initState() {
    super.initState();
    list = [
      ListPageModel(
        title: "style | strokeWidth",
        page: CustomPaint(
          painter: _CustomPainter(drawStyleStrokeWidth),
          child: Container(),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListPage(list),
    );
  }

  // 测试 style 和 strokeWidth 属性
  void drawStyleStrokeWidth(Canvas canvas) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 10;
    canvas.drawCircle(
        Offset(100, 150), 50, paint..style = PaintingStyle.stroke);
    canvas.drawCircle(
        Offset(100.0, 350), 50, paint..style = PaintingStyle.fill);
  }
}

class _CustomPainter extends CustomPainter {
  final ValueChanged<Canvas> onPaint;

  _CustomPainter(this.onPaint);

  @override
  void paint(Canvas canvas, Size size) {
    onPaint.call(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
