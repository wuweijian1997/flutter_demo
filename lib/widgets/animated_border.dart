import 'package:flutter/material.dart';

class AnimatedBorder extends StatefulWidget {
  final Widget child;
  final double borderPercentage;
  final AnimationController controller;
  final bool disable;

  AnimatedBorder({
    Key key,
    this.disable,
    this.controller,
    @required this.child,
    this.borderPercentage = 1,
  })
      : assert(borderPercentage >= 0 && borderPercentage <= 1),
        super(key: key);

  @override
  _AnimatedBorderState createState() => _AnimatedBorderState();
}

class _AnimatedBorderState extends State<AnimatedBorder>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  bool get disable => widget.disable;

  Widget get child => widget.child;

  AnimationController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    if (disable == false) {
      _controller = controller ??
          AnimationController(
            vsync: this,
          );
      _controller.repeat(min: 0, max: 1, period: Duration(milliseconds: 2000));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return CustomPaint(
          painter: AnimatedBorderPainter(
            progress: _controller.value,

          ),
          child: child,
        );
      },
      child: child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimatedBorderPainter extends CustomPainter {
  double progress;
  double borderPercentage;

  Color startColor;
  Color endColor;

  Size _size;
  double _borderPercentage;
  double borderLength;


  AnimatedBorderPainter({this.progress, this.borderPercentage = .5});

  @override
  void paint(Canvas canvas, Size size) {
    calculateBorderLength(size, borderPercentage);
  }

  void calculateBorderLength(Size size, double borderPercentage) {
    if (_size == size && _borderPercentage == borderPercentage) return;
    _size = size;
    _borderPercentage = _borderPercentage;
    borderLength = (size.width + size.height) * 2 * borderPercentage;
  }

  @override
  bool shouldRepaint(AnimatedBorderPainter old) {
    return progress != old.progress || borderPercentage != old.borderPercentage;
  }
}