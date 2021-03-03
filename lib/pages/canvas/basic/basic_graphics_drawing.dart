import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

/// 基础图形绘制
class BasicGraphicsDrawing extends StatefulWidget {
  @override
  _BasicGraphicsDrawingState createState() => _BasicGraphicsDrawingState();
}

class _BasicGraphicsDrawingState extends State<BasicGraphicsDrawing> {
  List<ListPageModel> list = [];
  final List<Offset> points = [
    Offset(-120, -20),
    Offset(-80, -80),
    Offset(-40, -40),
    Offset(0, -100),
    Offset(40, -140),
    Offset(80, -160),
    Offset(120, -100),
  ];

  @override
  void initState() {
    super.initState();
    list = [
      ListPageModel(
        title: '点绘制',
        page: BasicCustomPaint(drawPoints),
      ),
      ListPageModel(
        title: '线绘制',
        page: BasicCustomPaint(drawLine),
      ),
      ListPageModel(
        title: '矩形绘制',
        page: BasicCustomPaint(drawRect),
      ),
      ListPageModel(
        title: '圆角矩形绘制',
        page: BasicCustomPaint(drawRRect),
      ),
      ListPageModel(
        title: '绘制两个圆角矩形差域',
        page: BasicCustomPaint(drawDRRect),
      ),
      ListPageModel(
        title: '绘制类圆',
        page: BasicCustomPaint(drawCircle),
      ),
      ListPageModel(
        title: '绘制阴影',
        page: BasicCustomPaint(drawShadow),
      ),
    ];
  }

  /// 点绘制
  drawPoints(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    /// 点模式
    drawPointsWithPoints(canvas, size);

    /// 线段模式
    drawPointsWithLines(canvas, size);

    /// 多边形连线模式
    drawPointsWithPolygon(canvas, size);

    /// 点集
    drawRawPoints(canvas, size);
  }

  /// 点模式 PointMode.points
  drawPointsWithPoints(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.save();
    canvas.translate(0, -100);
    canvas.drawPoints(PointMode.points, points, paint);
    canvas.restore();
  }

  /// 线段模式 PointMode.lines
  drawPointsWithLines(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.lines, points, paint);
  }

  ///多边形连线模式 PointModel.polygon
  drawPointsWithPolygon(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.save();
    canvas.translate(0, 100);
    canvas.drawPoints(PointMode.polygon, points, paint);
    canvas.restore();
  }

  /// 绘点集
  drawRawPoints(Canvas canvas, Size size) {
    Float32List pos = Float32List.fromList([
      -120,
      -20,
      -80,
      -80,
      -40,
      -40,
      0,
      -100,
      40,
      -140,
      80,
      -160,
      120,
      -100
    ]);
    Paint paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.save();
    canvas.translate(0, 200);
    canvas.drawRawPoints(PointMode.points, pos, paint);
    canvas.restore();
  }

  /// 线绘制 drawLine
  drawLine(Canvas canvas, Size size) {
    drawPoints(canvas, size);

    Paint paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 1.5;

    /// 绘制水平线
    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), paint);

    /// 绘制水平线箭头
    canvas.drawLine(
        Offset(size.width / 2 - 10, -7), Offset(size.width / 2, 0), paint);
    canvas.drawLine(
        Offset(size.width / 2 - 10, 7), Offset(size.width / 2, 0), paint);

    /// 绘制垂直线
    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), paint);

    /// 绘制垂直线箭头
    canvas.drawLine(
        Offset(-7, size.height / 2 - 10), Offset(0, size.height / 2), paint);
    canvas.drawLine(
        Offset(7, size.height / 2 - 10), Offset(0, size.height / 2), paint);
  }

  /// 绘制矩形.五种绘制方法
  drawRect(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    /// 1. 矩形中心构造
    Rect rectFromCenter =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRect(rectFromCenter, paint);

    /// 2. 矩形上下左右构造
    Rect rectFromLTRB = Rect.fromLTRB(-120, -120, -80, -80);
    canvas.drawRect(rectFromLTRB, paint..color = Colors.red);

    /// 3. 矩形左上宽高绘制
    Rect rectFromLTWH = Rect.fromLTWH(80, -120, 40, 40);
    canvas.drawRect(rectFromLTWH, paint..color = Colors.orange);

    /// 4. 矩形内切圆构造
    Rect reactFromCircle =
        Rect.fromCircle(center: Offset(100, 100), radius: 20);
    canvas.drawRect(reactFromCircle, paint..color = Colors.green);

    /// 5. 矩形两点构造
    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 80), Offset(-80, 120));
    canvas.drawRect(rectFromPoints, paint..color = Colors.yellow);
  }

  /// 绘制圆角矩形
  drawRRect(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1.5;

    /// 1. 圆角矩形fromRectXY构造
    Rect rectFromCenter =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRRect(RRect.fromRectXY(rectFromCenter, 40, 20), paint);

    /// 2. 圆角矩形 fromLTRBXY构造
    canvas.drawRRect(RRect.fromLTRBXY(-120, -120, -80, -80, 10, 10),
        paint..color = Colors.red);

    /// 3. 圆角矩形 fromLTRBR构造
    canvas.drawRRect(RRect.fromLTRBR(80, -120, 120, -80, Radius.circular(10)),
        paint..color = Colors.orange);

    /// 4. 圆角矩形fromLTRBAndCorners构造
    canvas.drawRRect(
      RRect.fromLTRBAndCorners(80, 80, 120, 120,
          bottomRight: Radius.elliptical(10, 10)),
      paint..color = Colors.green,
    );

    /// 5. 圆角矩形 fromRectAndCorners构造
    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 80), Offset(-80, 120));
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        rectFromPoints,
        bottomLeft: Radius.elliptical(10, 10),
      ),
      paint..color = Colors.pink,
    );
  }

  /// 绘制两个圆角矩形差域
  drawDRRect(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue..strokeWidth = 1.5;
    canvas.translate(size.width / 2, size.height / 2);

    Rect outRect = Rect.fromCenter(center: Offset.zero, width: 160, height: 160);
    Rect inRect = Rect.fromCenter(center: Offset.zero, width: 100, height: 100);
    canvas.drawDRRect(RRect.fromRectXY(outRect, 10, 10), RRect.fromRectXY(inRect, 20, 20), paint);

    Rect outRect2 =
    Rect.fromCenter(center: Offset(0, 0), width: 60, height: 60);
    Rect inRect2 =
    Rect.fromCenter(center: Offset(0, 0), width: 40, height: 40);
    canvas.drawDRRect(RRect.fromRectXY(outRect2, 15, 15),
        RRect.fromRectXY(inRect2, 10, 10), paint..color=Colors.green);
  }

  /// 绘制类圆
  drawCircle(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    canvas.save();
    canvas.translate(size.width / 4, size.height / 2);
    canvas.save();
    canvas.translate(0, -200);

    /// 绘制圆
    canvas.drawCircle(Offset.zero, 60, paint);
    canvas.restore();

    /// 绘制椭圆
    var rect = Rect.fromCenter(center: Offset.zero, width: 120, height: 100);
    canvas.drawOval(rect, paint..color = Colors.red);

    canvas.translate(0, 200);
    /// 绘制圆弧
    canvas.drawArc(rect, 0, pi / 2 * 3, true, paint..color = Colors.green);
    canvas.restore();
    canvas.save();
    canvas.translate(size.width * 3 /4, size.height / 2);
    paint..style = PaintingStyle.stroke..strokeWidth = 2;
    canvas.save();
    canvas.translate(0, -200);
    /// 绘制空心圆弧
    canvas.drawArc(Rect.fromCenter(center: Offset.zero, width: 120, height:120), 0, pi / 2 * 3, true, paint);
    canvas.restore();
    /// 绘制空心圆弧，不连中心点。
    canvas.drawArc(Rect.fromCenter(center: Offset.zero, width: 120, height:120), 0, pi / 2 * 3, false, paint);
    canvas.restore();
  }

  /// 绘制阴影
  /// 路径 path
  /// 颜色 color
  /// 影深 elevation
  /// 内部是否显示 transparentOccluder
  drawShadow(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    Path path = Path()..lineTo(80, 80)..lineTo(-80, 80)..close();
    canvas.drawShadow(path, Colors.pink, 3, true);
    canvas.translate(0, 200);
    canvas.drawShadow(path, Colors.pink, 3, false);
    canvas.restore();
  }

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}
