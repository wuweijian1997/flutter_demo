import 'dart:math';

import 'package:flutter/material.dart';

class LineBorderWidget extends StatefulWidget {
  final Widget child;
  final LineBorderController? controller;
  final bool disable;

  LineBorderWidget({
    required this.child,
    Key? key,
    this.controller,
    this.disable = false,
  }) : super(key: key);

  @override
  _LineBorderWidgetState createState() => _LineBorderWidgetState();
}

class _LineBorderWidgetState extends State<LineBorderWidget>
    with SingleTickerProviderStateMixin {
  late LineBorderController _controller;

  bool get disable => widget.disable;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        LineBorderController(
          ticker: this,
          duration: Duration(seconds: 1),
        );
    _controller.addListener(() {
      setState(() {});
    });
  }

  onTap() {
      _controller.start();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = RepaintBoundary(
      child: CustomPaint(
        foregroundPainter: LineBorderPainter(progress: _controller.value),
        child: widget.child,
      ),
    );
    if(disable == true) return child;
    return GestureDetector(
      onTap: onTap,
      child: child,
    );
  }
}

class LineBorderPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;

  LineBorderPainter({
    required this.progress,
    this.strokeWidth = 5,
    this.color = Colors.blue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square
      ..color = color;

    double width = size.width;
    double height = size.height;

    double percent = progress;
    double percent2 = sqrt(3.38 - (percent - 1.7) * (percent - 1.7)) - 0.7;

    /// 左上角
    Offset topLeft = Offset(0, 0);
    Offset topRight = Offset(width, 0);
    Offset bottomRight = Offset(width, height);
    Offset bottomLeft = Offset(0, height);

    Offset p1 = Offset(width * percent2, topRight.dy);
    canvas.drawLine(p1, topRight, paint);

    Offset p2 = Offset(topRight.dx, height * percent);
    canvas.drawLine(topRight, p2, paint);

    Offset p3 = Offset(width, height * percent2);
    canvas.drawLine(p3, bottomRight, paint);

    Offset p4 = Offset(width * (1 - percent), height);
    canvas.drawLine(bottomRight, p4, paint);

    Offset p5 = Offset(width * (1 - percent2), height);
    canvas.drawLine(p5, bottomLeft, paint);

    Offset p6 = Offset(0, height * (1 - percent));
    canvas.drawLine(bottomLeft, p6, paint);

    Offset p7 = Offset(0, height * (1 - percent2));
    canvas.drawLine(p7, topLeft, paint);

    Offset p8 = Offset(width * percent, 0);
    canvas.drawLine(topLeft, p8, paint);
  }

  @override
  bool shouldRepaint(LineBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class LineBorderController {
  late AnimationController _controller;

  double get value => _controller.value;

  LineBorderController({
    required TickerProvider ticker,
    Duration duration = const Duration(seconds: 1),
  }) {
    _controller = AnimationController(vsync: ticker, duration: duration);
  }

  start() {
    double from = _controller.isAnimating ? _controller.value : 0;
    _controller.forward(from: from);
  }

  void addListener(VoidCallback listener) {
    _controller.addListener(listener);
  }

  void dispose() {
    _controller.dispose();
  }
}