import 'package:flutter/material.dart';
import 'dart:math';


class GestureDrawing extends StatefulWidget {
  const GestureDrawing({Key? key}) : super(key: key);

  @override
  _GestureDrawingState createState() => _GestureDrawingState();
}

class _GestureDrawingState extends State<GestureDrawing> {
  final ValueNotifier<Offset> _offset = ValueNotifier(Offset.zero);
  double size = 200;
  double handleRadius = 20;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onPanUpdate: onUpdate,
        onPanEnd: onReset,
        child: CustomPaint(
          size: Size(size, size),
          painter: _HandlePainter(handleR: handleRadius, offset: _offset, color: Colors.red),
        ),
      ),
    );
  }

  void onUpdate(DragUpdateDetails details) {
    final offset = details.localPosition;
    double dx = 0.0;
    double dy = 0.0;
    dx = offset.dx - size / 2;
    dy = offset.dy - size / 2;
    var rad = atan2(dx, dy);
    if (dx < 0) {
      rad += 2 * pi;
    }
    var bgR = size / 2 - handleRadius;
    var thta = rad - pi / 2; //旋转坐标系90度
    var d = sqrt(dx * dx + dy * dy);
    if (d > bgR) {
      dx = bgR * cos(thta);
      dy = -bgR * sin(thta);
    }
    _offset.value = Offset(dx, dy);
  }

  void onReset(DragEndDetails details) {
    _offset.value = Offset.zero;
  }
}

class _HandlePainter extends CustomPainter {
  final double handleR;
  final _paint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.fill
    ..isAntiAlias = true;
  final ValueNotifier<Offset> offset;
  final Color color;

  _HandlePainter(
      {required this.handleR, required this.offset, this.color = Colors.blue})
      : super(repaint: offset);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    final bgR = size.width / 2 - handleR;
    canvas.translate(size.width / 2, size.height / 2);
    _paint.style = PaintingStyle.fill;
    _paint.color = color.withAlpha(100);
    canvas.drawCircle(const Offset(0, 0), bgR, _paint);

    _paint.color = color.withAlpha(150);
    canvas.drawCircle(
        Offset(offset.value.dx, offset.value.dy), handleR, _paint);

    _paint.color = color;
    _paint.style = PaintingStyle.stroke;
    canvas.drawLine(Offset.zero, offset.value, _paint);
  }

  @override
  bool shouldRepaint(_HandlePainter oldDelegate) =>
      handleR != oldDelegate.handleR ||
      color != oldDelegate.color ||
      offset != oldDelegate.offset;
}
