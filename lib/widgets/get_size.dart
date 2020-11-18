import 'package:flutter/material.dart';

class GetSize extends StatelessWidget {
  final ValueChanged<Size> onSize;
  final Widget child;

  GetSize({
    Key key,
    this.child,
    this.onSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _SizePaint(
            onSize: onSize
        ),
        child: child,
      ),
    );
  }
}

class _SizePaint extends CustomPainter {
  Size _size = Size.zero;
  final ValueChanged<Size> onSize;
  final Key key;

  _SizePaint({this.onSize, this.key});

  @override
  void paint(Canvas canvas, Size size) {
    if (size != _size) {
      onSize.call(size);
    }
  }

  @override
  bool shouldRepaint(_SizePaint oldDelegate) {
    return key != oldDelegate.key;
  }
}
