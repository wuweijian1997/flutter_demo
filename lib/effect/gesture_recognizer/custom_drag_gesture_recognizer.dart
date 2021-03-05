import 'package:demo/util/index.dart';
import 'package:flutter/gestures.dart';

class CustomDragGestureRecognizer extends DragGestureRecognizer{
  final bool disable;
  final String log;

  CustomDragGestureRecognizer({this.disable = false, this.log = 'log'});

  @override
  String get debugDescription => 'horizontal drag';

  @override
  bool isFlingGesture(VelocityEstimate estimate, PointerDeviceKind kind) {
    final double minVelocity = minFlingVelocity ?? kMinFlingVelocity;
    final double minDistance = minFlingDistance ?? computeHitSlop(kind);
    return estimate.pixelsPerSecond.dx.abs() > minVelocity && estimate.offset.dx.abs() > minDistance;
  }

  @override
  void rejectGesture(int pointer) {
    Log.info('rejectGesture: $log, $pointer', StackTrace.current);
    if(!disable) {
      acceptGesture(pointer);
    }
  }

  @override
  void acceptGesture(int pointer) {
    Log.info('acceptGesture: $log, $pointer', StackTrace.current);
    if(disable) {
      rejectGesture(pointer);
    } else {
      super.acceptGesture(pointer);
    }
  }
}