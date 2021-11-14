import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double _kDefaultSpringHeight = 100; //弹簧默认高度
const double _kRateOfMove = 1.5; //移动距离与形变量比值

class SpringWidget extends StatefulWidget {
  const SpringWidget({Key? key}) : super(key: key);

  @override
  State<SpringWidget> createState() => _SpringWidgetState();
}

class _SpringWidgetState extends State<SpringWidget>
    with SingleTickerProviderStateMixin {
  ValueNotifier<double> height = ValueNotifier(_kDefaultSpringHeight);
  late AnimationController _ctrl;
  double s = 0;
  double laseMoveLen = 0;

  @override
  void initState() {
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addListener(_updateHeightByAnim);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _updateHeight,
      onVerticalDragEnd: _animateToDefault,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.grey.withAlpha(11),
        child: CustomPaint(painter: SpringPainter(height: height)),
      ),
    );
  }

  double get dx => -s / _kRateOfMove;

  void _updateHeight(DragUpdateDetails details) {
    s += details.delta.dy;
    height.value = _kDefaultSpringHeight + dx;
  }

  void _animateToDefault(DragEndDetails details) {
    laseMoveLen = s;
    _ctrl.forward(from: 0);
  }

  void _updateHeightByAnim() {
    s = laseMoveLen * (1 - _ctrl.value);
    height.value = _kDefaultSpringHeight + dx;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    height.dispose();
    super.dispose();
  }
}

class SpringPainter extends CustomPainter {
  final int count;
  final ValueListenable<double> height;

  SpringPainter({this.count = 20, required this.height})
      : super(repaint: height);

  final double _kSpringWidth = 30;
  Paint _paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2 + _kSpringWidth / 2, size.height);
    Path springPath = Path();
    springPath.relativeLineTo(-_kSpringWidth, 0);
    double space = height.value / (count - 1);
    for (int i = 1; i < count; i++) {
      if (i % 2 == 1) {
        springPath.relativeLineTo(_kSpringWidth, -space);
      } else {
        springPath.relativeLineTo(-_kSpringWidth, -space);
      }
    }
    springPath.relativeLineTo(count.isOdd ? _kSpringWidth : -_kSpringWidth, 0);
    canvas.drawPath(springPath, _paint);
  }

  @override
  bool shouldRepaint(SpringPainter oldDelegate) =>
      oldDelegate.count != count || oldDelegate.height != height;
}
