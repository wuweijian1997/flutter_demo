import 'dart:math';

import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/basic_custom_paint.dart';
import 'package:flutter/material.dart';

/// 路径的形状添加
class PathShapeDrawing extends StatefulWidget {
  @override
  _PathShapeDrawingState createState() => _PathShapeDrawingState();
}

class _PathShapeDrawingState extends State<PathShapeDrawing> {
  var list = <ListPageModel>[];

  @override
  void initState() {
    list = [
      ListPageModel(title: "添加类矩形", page: BasicCustomPaint(drawPathAddRect)),
      ListPageModel(title: "添加类圆形", page: BasicCustomPaint(drawPathAddOval)),
      ListPageModel(
          title: "添加多边形路径和路径", page: BasicCustomPaint(drawPathAndPolygon)),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }

  /// 路径添加类矩形
  drawPathAddRect(Canvas canvas, Size size) {
    canvas.translate(100, size.height / 2);
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromPoints(Offset(100, 100), Offset(160, 160));
    path
      ..lineTo(100, 100)
      ..addRect(rect)
      ..relativeLineTo(100, -100)
      ..addRRect(RRect.fromRectXY(rect.translate(100, -100), 10, 10));
    canvas.drawPath(path, paint);
  }

  ///添加类圆形
  drawPathAddOval(Canvas canvas, Size size) {
    canvas.translate(50, size.height / 2);
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromPoints(Offset(100, 100), Offset(160, 140));
    path
      ..lineTo(100, 100)
      ..addOval(rect)
      ..relativeLineTo(100, -100)
      ..addArc(rect.translate(100 + 60, -100), 0, pi);
    canvas.drawPath(path, paint);
  }

  ///添加多边形路径和路径
  drawPathAndPolygon(Canvas canvas, Size size) {
    canvas.translate(size.width / 2 - 125, size.height / 2);
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    var p0 = Offset(100, 100);
    path
      ..lineTo(100, 100)
      ..addPolygon([
        p0,
        p0.translate(20, -20),
        p0.translate(40, -20),
        p0.translate(60, 0),
        p0.translate(60, 20),
        p0.translate(40, 40),
        p0.translate(20, 40),
        p0.translate(0, 20),
      ], true)
      ..addPath(
          Path()..relativeQuadraticBezierTo(125, -100, 260, 0), Offset.zero)
      ..lineTo(160, 100);
    canvas.drawPath(path, paint);
  }
}
