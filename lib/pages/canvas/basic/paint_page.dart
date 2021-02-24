import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';
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
        page: BasicCustomPaint(drawStyleStrokeWidth),
      ),
      ListPageModel(
        title: "StrokeCap",
        page: BasicCustomPaint(drawStrokeCap),
      ),
      ListPageModel(
        title: "StrokeJoin",
        page: BasicCustomPaint(drawStrokeJoin),
      ),
      ListPageModel(
        title: "StrokeMiterLimit",
        page: BasicCustomPaint(drawStrokeMiterLimit),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListPage(list),
    );
  }

  // 测试 style 和 strokeWidth 属性
  void drawStyleStrokeWidth(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 10;

    ///线条
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(100, 150), 50, paint..style);

    ///填充
    paint.style = PaintingStyle.fill;
    canvas.drawCircle(Offset(250.0, 150), 50, paint);
    canvas.drawLine(
        Offset(0, 97.5),
        Offset(400, 97.5),
        paint
          ..color = Colors.blue
          ..strokeWidth = 5);
  }

  /// 测试线帽类型
  void drawStrokeCap(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;

    /// 不出头
    paint.strokeCap = StrokeCap.butt;
    canvas.drawLine(Offset(50, 50), Offset(50, 150), paint);

    /// 圆头
    paint.strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(100, 50), Offset(100, 150), paint);

    /// 方头
    paint.strokeCap = StrokeCap.square;
    canvas.drawLine(Offset(150, 50), Offset(150, 150), paint);
  }

  /// 测试线接类型
  void drawStrokeJoin(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    Path path = Path();
    void draw(double x, StrokeJoin strokeJoin, {double y = 50}) {
      path.moveTo(x, y);
      path.lineTo(x, y + 100);
      path.relativeLineTo(100, -50);
      path.relativeLineTo(0, 100);
      canvas.drawPath(path, paint..strokeJoin = strokeJoin);
      path.reset();
    }

    /// 斜角
    draw(50, StrokeJoin.bevel);

    /// 锐角
    draw(200, StrokeJoin.miter);

    /// 圆角
    draw(100, StrokeJoin.round, y: 300);
  }

  /// 斜接限制
  void drawStrokeMiterLimit(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeJoin = StrokeJoin.miter
      ..strokeWidth = 10;

    /// 数字越大,尖角越尖
    paint.strokeMiterLimit = 2;
    for (int i = 0; i < 4; i++) {
      path.reset();
      path.moveTo(50, 50 + 150.0 * i);
      path.lineTo(50, 150 + 150.0 * i);
      path.relativeLineTo(100, -(40.0 * i + 20));
      canvas.drawPath(path, paint);
    }

    /// 数字越大,尖角越尖
    paint.strokeMiterLimit = 3;
    for (int i = 0; i < 4; i++) {
      path.reset();
      path.moveTo(250, 50 + 150.0 * i);
      path.lineTo(250, 150 + 150.0 * i);
      path.relativeLineTo(100, -(40.0 * i + 20));
      canvas.drawPath(path, paint);
    }
  }
}
