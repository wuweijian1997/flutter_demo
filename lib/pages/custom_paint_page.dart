import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomPaintPage extends StatelessWidget {
  static const rName = 'CustomPaintPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CustomPaint(
            size: Size(300, 300),
            painter: MyPainter(),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;
    Paint paint = Paint()
      ..isAntiAlias = true //抗锯齿
      ..style = PaintingStyle.fill //填充
      ..color = Color(0x77cdb175);
    canvas.drawRect(Offset.zero & size, paint);

    //画棋盘网络
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black87
      ..strokeWidth = 1.0;
    for (int i = 0; i <= 15; ++i) {
      double dy = eHeight * i;
      double dx = eWidth * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    //画圆
    canvas.drawCircle(
        Offset(size.width / 2 - eWidth / 2, size.height / 2 - eHeight / 2),
        min(eWidth / 2, eHeight / 2) - 2,
        paint);

    paint
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      //设置圆形
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(
//        PointMode.points, 画点
        PointMode.polygon, //连线
        [
          Offset(10, 10),
          Offset(20, 20),
          Offset(100, 30),
        ],
        paint);

    //设置填充效果
    paint..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(100, 100);
    path.lineTo(200, 200);
    path.lineTo(250, 200);
    path.lineTo(200, 250);
    //闭合路径
    path.close();
    canvas.drawPath(path, paint);

    //绘制矩形
    Rect rect = Rect.fromCircle(
      center: Offset(size.width / 1.5, size.height / 4),
      radius: 50 //宽度 / 2
    );
    canvas.drawRect(rect, paint);

    //绘制圆角矩形
    Rect rect2 = Rect.fromCircle(
      center: Offset(size.width / 4, size.height / 1.5),
      radius: 50
    );
    RRect rRect = RRect.fromRectAndRadius(rect2, Radius.circular(20));
    canvas.drawRRect(rRect, paint);

//    canvas.recorder
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
