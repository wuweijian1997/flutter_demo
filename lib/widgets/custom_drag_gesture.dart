import 'package:demo/effect/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomDragGesture extends StatelessWidget {
  final GestureDragStartCallback onStart;
  final GestureDragUpdateCallback onUpdate;
  final GestureDragEndCallback onEnd;
  final GestureDragDownCallback onDown;
  final GestureDragCancelCallback onCancel;
  final Widget child;
  final bool disable;
  final String log;

  CustomDragGesture({this.onStart,
      this.onUpdate,
      this.onCancel,
      this.onDown,
      this.onEnd,
      this.child,
      this.disable = false,
      this.log});

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        CustomDragGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<CustomDragGestureRecognizer>(
                () => CustomDragGestureRecognizer(disable: disable, log: log),
                (CustomDragGestureRecognizer recognizer) {
          recognizer.onStart = onStart;
          recognizer.onUpdate = onUpdate;
          recognizer.onEnd = onEnd;
          recognizer.onDown = onDown;
          recognizer.onCancel = onCancel;
        })
      },
      child: child,
    );
  }
}
