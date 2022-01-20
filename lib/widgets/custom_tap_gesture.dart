import 'package:demo/effect/index.dart';
import 'package:flutter/material.dart';

class CustomTapGesture extends StatelessWidget {
  final GestureTapCallback onTap;
  final Widget child;
  final bool disable;
  final String log;

  const CustomTapGesture({
    Key? key,
    required this.onTap,
    required this.child,
    this.disable = false,
    this.log = 'log',
  }) : super(key: key);

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
