import 'package:flutter/material.dart';

typedef CanvasPaint = void Function(Canvas canvas, Size size);

class BasicCustomPaint extends StatelessWidget {
  final CanvasPaint onPaint;

  BasicCustomPaint(this.onPaint);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BasicCustomPainter(onPaint),
      child: Container(),
    );
  }
}

class _BasicCustomPainter extends CustomPainter {
  final CanvasPaint onPaint;

  _BasicCustomPainter(this.onPaint);

  @override
  void paint(Canvas canvas, Size size) {
    onPaint.call(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
