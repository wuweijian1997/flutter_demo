import 'dart:math';

import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

/// 路径图形绘制
class PathGraphicsDrawing extends StatefulWidget {
  @override
  _PathGraphicsDrawingState createState() => _PathGraphicsDrawingState();
}

class _PathGraphicsDrawingState extends State<PathGraphicsDrawing> {
  var list = <ListPageModel>[];

  @override
  void initState() {
    list = [
      ListPageModel(
        title: "moveTo和lineTo",
        page: BasicCustomPaint(drawMoveToLineTo),
      ),
      ListPageModel(
        title: "relativeMoveTo和relativeLineTo",
        page: BasicCustomPaint(drawRelativeMoveToRelativeLineTo),
      ),
      ListPageModel(
        title: "arcTo: 圆弧",
        page: BasicCustomPaint(drawArcTo),
      ),
      ListPageModel(
        title: "arcToPoint: 点定弧",
        page: BasicCustomPaint(drawArcToPoint),
      ),
      ListPageModel(
        title: "conicTo: 圆锥曲线",
        page: BasicCustomPaint(drawConicTo),
      ),
      ListPageModel(
        title: "quadraticBezierTo: 二阶贝塞尔",
        page: BasicCustomPaint(drawQuadraticBezierTo),
      ),
      ListPageModel(
        title: "cubicTo: 三阶贝塞尔",
        page: BasicCustomPaint(drawCubicTo),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }

  /// moveTo 相当于提起落到纸上的 位置坐标，且坐标以画布原点为参考系。
  /// lineTo 相当于从落笔点画直线到期望的坐标点，且坐标以画布原点为参考系。
  drawMoveToLineTo(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.deepPurpleAccent
      ..style = PaintingStyle.fill;

    path
      ..moveTo(0, 0)
      ..lineTo(60, 60)
      ..lineTo(60, 0)
      ..lineTo(0, -80)
      ..close();

    /// 闭合路径
    canvas.drawPath(path, paint);

    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    path
      ..moveTo(0, 0)
      ..lineTo(-60, 60)
      ..lineTo(-60, 0)
      ..lineTo(0, -80)
      ..close();
    canvas.drawPath(path, paint);
  }

  /// 相对画线
  drawRelativeMoveToRelativeLineTo(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(100, 120)
      ..relativeLineTo(-10, -60)
      ..relativeLineTo(60, -10)
      ..close();

    canvas.drawPath(path, paint);
    path.reset();

    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.green
      ..strokeWidth = 2;
    path
      ..relativeMoveTo(0, -200)
      ..relativeLineTo(100, 120)
      ..relativeLineTo(-10, -60)
      ..relativeLineTo(60, -10)
      ..close();
    canvas.drawPath(path, paint);
  }

  /// 绘制圆弧路径
  /// forceMoveTo: 是否强行移动，如果为true，绘制圆弧时会先移动到起点。
  drawArcTo(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromCenter(center: Offset.zero, width: 160, height: 100);
    path
      ..lineTo(30, 30)
      ..arcTo(rect, 0, pi * 1.5, true);
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(0, 200);
    path.lineTo(30, 30);
    path.arcTo(rect, 0, pi * 1.5, false);
    canvas.drawPath(path, paint);
  }

  /// clockwise: 是否是顺时针
  /// relativeArcToPoint方法即使用相对位置来加入圆弧路径，参数含义与上面一致。
  drawArcToPoint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    /// 绘制中间
    path
      ..lineTo(80, -40)
      ..arcToPoint(Offset(40, 40), radius: Radius.circular(60), largeArc: false)
      ..close();
    canvas.drawPath(path, paint);
    path.reset();

    /// 绘制上面
    canvas.translate(0, -200);
    path.lineTo(80, -40);
    path
      ..arcToPoint(Offset(40, 40),
          radius: Radius.circular(60), largeArc: true, clockwise: false)
      ..close();
    canvas.drawPath(path, paint);
    path.reset();

    /// 绘制下面
    canvas.translate(0, 400);
    path.lineTo(80, -40);
    path
      ..arcToPoint(Offset(40, 40), radius: Radius.circular(60), largeArc: true)
      ..close();

    canvas.drawPath(path, paint);
  }

  /// 绘制圆锥曲线
  /// weight： 权重，
  /// < 1 时，圆锥曲线是椭圆线
  /// = 1 时，圆锥曲线是抛物线
  /// > 1 时，圆锥曲线是双曲线
  /// relativeConicTo方法即使用相对位置来加入圆锥曲线路径，参数含义与上面一致。
  drawConicTo(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    final Offset p1 = Offset(80, -100);
    final Offset p2 = Offset(160, 0);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    /// 抛物线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1);
    canvas.drawPath(path, paint);
    path.reset();

    /// 椭圆线
    canvas.translate(0, -200);
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, .5);
    canvas.drawPath(path, paint);
    path.reset();

    /// 双曲线
    canvas.translate(0, 400);
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1.5);
    canvas.drawPath(path, paint);
  }

  /// 二阶贝塞尔
  drawQuadraticBezierTo(Canvas canvas, Size size) {
    canvas.translate(20, size.height / 2);

    ///控制点
    final Offset p1 = Offset(100, -100);

    /// 结束点
    final Offset p2 = Offset(160, 50);
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    /// 相对位置绘制二阶拜塞尔曲线
    path.relativeQuadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    canvas.drawPath(path, paint);
  }

  ///三阶贝塞尔曲线
  drawCubicTo(Canvas canvas, Size size) {
    canvas.translate(50, size.height /2);
    final Offset p1 = Offset.zero;
    final Offset p2 = Offset(80, -100);
    final Offset p3 = Offset(80, 50);
    Path path = Path();
    Paint paint = Paint();
    paint..color = Colors.purpleAccent..strokeWidth = 2..style = PaintingStyle.stroke;
    path.cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);
    path.relativeCubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);
    canvas.drawPath(path, paint);
  }
}
