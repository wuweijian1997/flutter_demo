import 'dart:math';
import 'dart:ui';

import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart' hide Gradient;

class PathCurvePage extends StatefulWidget {
  const PathCurvePage({Key? key}) : super(key: key);

  @override
  _PathCurvePageState createState() => _PathCurvePageState();
}

class _PathCurvePageState extends State<PathCurvePage> {
  List<ListPageModel> list = [];

  @override
  void initState() {
    list = [
      ListPageModel(
        title: "使用点线绘制曲线",
        page: BasicCustomPaint(drawDotLineCurve),
      ),
      ListPageModel(
        title: "绘制极坐标的点",
        page: BasicCustomPaint(drawDotCoordinatesCurve),
      ),
      ListPageModel(
        title: "使用Path绘制函数曲线",
        page: BasicCustomPaint(drawPathCurve),
      ),
      ListPageModel(
        title: "曲线运动",
        page: AnimatedCustomPaint(drawCurvilinearMotion),
      ),
      ListPageModel(
        title: "曲线运动生成",
        page: AnimatedCustomPaint(drawCurvilinearMotionRun),
      ),
    ];
    super.initState();
  }

  /// 使用点线绘制曲线
  drawDotLineCurve(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    const double step = 1;
    const double min = -240;
    const double max = 240;

    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2;
    final List<Offset> points = [];
    for (double x = min; x <= max; x += step) {
      points.add(Offset(x, -x * x / 200 + 100));
    }
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  /// 绘制极坐标的点.
  drawDotCoordinatesCurve(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    double step = 3;
    double min = 0;
    double max = 360 * 3.0;
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2;
    final List<Offset> points = [];
    for (double i = min; i <= max; i += step) {
      /// 角度转化为弧度
      double thta = (pi / 180 * i);
      // var p = 10 * thta;
      // var p = 100 * (1-cos(thta));
      var p = 150 * sin(4 * thta);
      points.add(Offset(p * cos(thta), p * sin(thta)));
    }
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  /// 使用Path绘制函数曲线
  drawPathCurve(Canvas canvas, Size size) {
    const double step = 60;
    const double min = -240, max = 240;
    final List<Offset> points = [];
    for (double x = min; x < max; x += step) {
      points.add(Offset(x, -x * x / 200 + 100));
    }
    points.add(const Offset(max, -max * max / 200 + 100));

    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Offset p1 = points[0];
    Path path = Path()..moveTo(p1.dx, p1.dy);
    for (int i = 1; i < points.length - 1; i++) {
      double xc = (points[i].dx + points[i + 1].dx) / 2;
      double yc = (points[i].dy + points[i + 1].dy) / 2;
      Offset p2 = points[i];
      path.quadraticBezierTo(p2.dx, p2.dy, xc, yc);
    }
    canvas.drawPath(path, paint);
  }

  ///曲线运动
  drawCurvilinearMotion(
      Canvas canvas, Size size, Animation<double>? animation) {
    canvas.translate(size.width / 2, size.height / 2);
    Path path = Path();
    Paint paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.deepPurpleAccent
      ..style = PaintingStyle.stroke
      ..shader = Gradient.radial(
        Offset.zero,
        25,
        [Colors.lightBlueAccent, Colors.pink],
        [0, 1],
        TileMode.clamp,
      );

    path
      ..moveTo(0, 0)
      ..lineTo(60, 60)
      ..lineTo(60, 0)
      ..lineTo(0, -80)
      ..close();
    canvas.drawPath(path, paint);
    PathMetrics pms = path.computeMetrics();
    for (var pm in pms) {
      Tangent? tangent =
          pm.getTangentForOffset(pm.length * (animation?.value ?? 0));
      if (tangent != null) {
        canvas.drawCircle(tangent.position, 5, Paint()..color = Colors.red);
      }
    }
  }

  void drawCurvilinearMotionRun(
      Canvas canvas, Size size, Animation<double>? animation) {
    canvas.translate(size.width / 2, size.height / 2);
    Path path = Path();
    Paint paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.deepPurpleAccent
      ..style = PaintingStyle.stroke
      ..shader = Gradient.radial(
        Offset.zero,
        25,
        [Colors.lightBlueAccent, Colors.pink],
        [0, 1],
        TileMode.clamp,
      );

    path
      ..moveTo(0, 0)
      ..lineTo(60, 60)
      ..lineTo(60, 0)
      ..lineTo(0, -80)
      ..close();

    PathMetrics pms = path.computeMetrics();
    for (var pm in pms) {
      Tangent? tangent =
          pm.getTangentForOffset(pm.length * (animation?.value ?? 0));
      if (tangent != null) {
        canvas.drawPath(
            pm.extractPath(0, pm.length * (animation?.value ?? 0)), paint);
        canvas.drawCircle(tangent.position, 5, Paint()..color = Colors.blue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}
