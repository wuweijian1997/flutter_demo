import 'package:demo/effect/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomTapGesture extends StatelessWidget {
  final GestureTapCallback onTap;
  final Widget child;
  final bool disable;
  final String log;

  CustomTapGesture({@required this.onTap, this.child, this.disable = false, this.log});

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        CustomTapGestureRecognizer:
        GestureRecognizerFactoryWithHandlers<CustomTapGestureRecognizer>(
                () => CustomTapGestureRecognizer(disable: disable, log: log),
                (CustomTapGestureRecognizer recognizer) {
              recognizer.onTap = onTap;
            })
      },
      child: child,
    );
  }
}

