import 'package:flutter/material.dart';

class AnimatedLineBorder extends StatefulWidget {
  final Widget child;

  AnimatedLineBorder({this.child, Key key}) : super(key: key);

  @override
  _AnimatedLineBorderState createState() => _AnimatedLineBorderState();
}

class _AnimatedLineBorderState extends State<AnimatedLineBorder> {
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        child: widget.child,
        foregroundPainter: AnimatedLineBorderPainter(),
      ),
    );
  }
}

class AnimatedLineBorderPainter extends CustomPainter {
  final double progress;
  double lineProgress = 0.5;

  AnimatedLineBorderPainter({this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    double perimeter = size.width * 2 + size.height * 2;
    double lineLength = perimeter * lineProgress;
    double startingPointLength = perimeter * progress;
    Offset startingPoint = calculateStartingPoint(size,startingPointLength);
  }

  Offset calculateStartingPoint(Size size, double startingPointLength) {
    double width = size.width;
    double height = size.height;
    double rightBottom = width + height;
    double leftBottom = width * 2 + height;
    double leftTop = (width + height) * 2;
    assert(startingPointLength <= leftTop);
    if (startingPointLength <= width) {
      return Offset(startingPointLength, 0);
    } else if (startingPointLength <= rightBottom) {
      return Offset(width, rightBottom - startingPointLength);
    } else if(startingPointLength <= leftBottom) {
      return Offset(startingPointLength - rightBottom, height);
    } else {
      return Offset(0, leftTop - startingPointLength);
    }
  }

  @override
  bool shouldRepaint(AnimatedLineBorderPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
