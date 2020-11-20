import 'package:flutter/material.dart';
import 'delegate/index.dart';

class LightPainter extends CustomPainter {
  final Offset touchOffset;
  final FlashlightDelegate delegate;

  LightPainter({
    this.touchOffset = Offset.zero,
    this.delegate = const DefaultFlashlightDelegate(),
  });

  @override
  void paint(Canvas canvas, Size size) {
    delegate.paint(canvas, touchOffset);
  }

  @override
  bool shouldRepaint(LightPainter oldDelegate) {
    return touchOffset != oldDelegate.touchOffset ||
        delegate != oldDelegate.delegate;
  }
}
