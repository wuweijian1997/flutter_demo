import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AllowMultipleGesture extends StatelessWidget {
  final GestureTapCallback onTap;
  final Widget child;

  AllowMultipleGesture({@required this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        _AllowMultipleGestureRecognizer:
        GestureRecognizerFactoryWithHandlers<_AllowMultipleGestureRecognizer>(
                () => _AllowMultipleGestureRecognizer(),
                (_AllowMultipleGestureRecognizer recognizer) {
              recognizer.onTap = onTap;
            })
      },
      child: child,
    );
  }
}

class _AllowMultipleGestureRecognizer extends TapGestureRecognizer {

  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}