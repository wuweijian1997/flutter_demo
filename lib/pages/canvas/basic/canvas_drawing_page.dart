import 'dart:math';

import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/basic_custom_paint.dart';
import 'package:flutter/material.dart';

class CanvasDrawingPage extends StatefulWidget {
  @override
  _CanvasDrawingPageState createState() => _CanvasDrawingPageState();
}

class _CanvasDrawingPageState extends State<CanvasDrawingPage> {
  List<ListPageModel> list = [];

  @override
  void initState() {
    super.initState();
    list = [
      ListPageModel(
          title: '画布变化和状态', page: BasicCustomPaint(drawTranslateAndState)),
    ];
  }

  ///画布变化和状态
  drawTranslateAndState(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    print(size);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(Offset(0, 0), 50, paint);
    canvas.drawLine(
        Offset(20, 20),
        Offset(50, 50),
        paint
          ..color = Colors.red
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);

    drawGrid(canvas, size);
    drawRotateDot(canvas, size);
  }

  /// 画网格
  drawGrid(Canvas canvas, Size size) {
    drawBottomRightGrid(canvas, size);
    canvas.save();

    /// 沿x轴镜像
    canvas.scale(1, -1);
    drawBottomRightGrid(canvas, size, color: Colors.red);
    canvas.restore();

    /// 沿y轴镜像
    canvas.save();
    canvas.scale(-1, 1);
    drawBottomRightGrid(canvas, size, color: Colors.blue);
    canvas.restore();

    ///沿圆点镜像
    canvas.save();
    canvas.scale(-1, -1);
    drawBottomRightGrid(canvas, size, color: Colors.green);
    canvas.restore();
  }

  /// 画右下角网格
  drawBottomRightGrid(Canvas canvas, Size size, {Color color = Colors.grey}) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5
      ..color = color;
    var step = 20;
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), paint);
      canvas.translate(0, step.toDouble());
    }
    canvas.restore();
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), paint);
      canvas.translate(step.toDouble(), 0);
    }
    canvas.restore();
  }

  drawRotateDot(Canvas canvas, Size size) {
    final int count = 12;
    Paint paint = Paint()
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = Colors.orange
      ..style = PaintingStyle.fill;
    canvas.save();
    for (int i = 0; i < count; i++) {
      var step = 2 * pi / count;
      canvas.drawLine(Offset(40, 0), Offset(50, 0), paint);
      canvas.rotate(step);
    }
    canvas.restore();
  }

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}
