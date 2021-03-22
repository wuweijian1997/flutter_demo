import 'dart:math';

import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/util/index.dart';
import 'package:demo/widgets/basic_custom_paint.dart';
import 'package:flutter/material.dart';

class PathMethodDrawing extends StatefulWidget {
  @override
  _PathMethodDrawingState createState() => _PathMethodDrawingState();
}

class _PathMethodDrawingState extends State<PathMethodDrawing> {
  var list = <ListPageModel>[];

  @override
  void initState() {
    list = [
      ListPageModel(
        title: "close,reset, shift",
        page: BasicCustomPaint(drawCloseResetShift),
      ),
      ListPageModel(
        title: "getBounds contains",
        page: BasicCustomPaint(drawGetBoundsContains),
      ),
      ListPageModel(
        title: "Transform 变换",
        page: BasicCustomPaint(drawPathTransform),
      ),
      ListPageModel(
        title: "combine 路径联合",
        page: BasicCustomPaint(drawPathCombine),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }

  ///close: 用于将路径尾点和起点进行路径封闭
  ///reset: 用于将路径进行重置，清除路径内容
  ///shift: 指定点Offset将路径平移，且返回一条新的路径
  drawCloseResetShift(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    path
      ..lineTo(100, 100)
      ..relativeLineTo(0, -50)
      ..close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path.shift(Offset(0, -100)), paint);
    canvas.drawPath(path.shift(Offset(0, 100)), paint);
  }

  ///contains: 判断点Offset在不在路径之内。
  ///getBounds: 获取当前路径所在的矩形区域。
  drawGetBoundsContains(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;

    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();

    canvas.drawPath(path, paint);
    var o1 = Offset(20, 20);
    var o2 = Offset(0, 20);
    Log.info("$o1: ${path.contains(o1)}", StackTrace.current);
    Log.info("$o2: ${path.contains(o2)}", StackTrace.current);
    Rect bounds = path.getBounds();

    canvas.drawRect(
        bounds,
        Paint()
          ..color = Colors.orange
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);
  }

  /// 路径变换
  drawPathTransform(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;

    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();

    for (int i = 0; i < 8; i++) {
      canvas.drawPath(
        path.transform(Matrix4.rotationZ(i * pi / 4).storage),
        paint,
      );
    }
  }

  /// 路径联合
  drawPathCombine(Canvas canvas, Size size) {
    canvas.translate(100, 300);
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;

    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();

    var pathOval = Path()
      ..addOval(Rect.fromCenter(center: Offset(0, 0), width: 60, height: 60));

    /// difference
    canvas.drawPath(
      Path.combine(PathOperation.difference, path, pathOval),
      paint..color = Colors.red,
    );
    canvas.save();
    canvas.translate(0, -100);

    /// intersect 相交
    canvas.drawPath(
      Path.combine(PathOperation.intersect, path, pathOval),
      paint..color = Colors.blue,
    );
    canvas.restore();

    canvas.save();
    canvas.translate(0, 200);

    /// union
    canvas.drawPath(
      Path.combine(PathOperation.union, path, pathOval),
      paint..color = Colors.green,
    );
    canvas.restore();

    canvas.translate(200, 0);

    /// reverseDifference
    canvas.drawPath(
      Path.combine(PathOperation.reverseDifference, path, pathOval),
      paint..color = Colors.pink,
    );

    canvas.translate(0, 100);

    /// xor
    canvas.drawPath(
      Path.combine(PathOperation.xor, path, pathOval),
      paint..color = Colors.orange,
    );
  }
}
