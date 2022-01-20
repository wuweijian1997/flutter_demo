import 'package:flutter/material.dart';

typedef AnimatedCanvasPaint = void Function(
    Canvas canvas, Size size, Animation<double>? animation);

class AnimatedCustomPaint extends StatefulWidget {
  final AnimatedCanvasPaint onPaint;

  ///double? min, double? max, bool reverse = false, Duration? period
  final double min;
  final double max;
  final bool reverse;
  final Duration period;

  const AnimatedCustomPaint(
    this.onPaint, {Key? key,
    this.min = 0,
    this.max = 1,
    this.reverse = false,
    this.period = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  State<AnimatedCustomPaint> createState() => _AnimatedCustomPaintState();
}

class _AnimatedCustomPaintState extends State<AnimatedCustomPaint>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this)
      ..repeat(
        min: widget.min,
        max: widget.max,
        reverse: widget.reverse,
        period: widget.period,
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BasicCustomPainter(widget.onPaint, _controller?.view),
      child: Container(),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

class _BasicCustomPainter extends CustomPainter {
  final AnimatedCanvasPaint onPaint;
  final Animation<double>? animation;

  _BasicCustomPainter(this.onPaint, this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    onPaint.call(canvas, size, animation);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
