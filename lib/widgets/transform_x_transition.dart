import 'dart:math';

import 'package:flutter/widgets.dart';

class TransformXTransition extends AnimatedWidget {

  const TransformXTransition({
    Key key,
    @required Animation<double> turns,
    this.alignment = Alignment.center,
    this.child,
    this.minValue,
    this.maxValue
  }) : assert(turns != null),
        super(key: key, listenable: turns);

  Animation<double> get turns => listenable as Animation<double>;

  final Alignment alignment;

  final Widget child;

  final double minValue;
  final double maxValue;

  @override
  Widget build(BuildContext context) {
    double turnsValue = turns.value;
    if(minValue != null) {
      turnsValue = max(minValue, turnsValue);
    }
    if(maxValue != null) {
      turnsValue = min(maxValue, turnsValue);
    }
    final Matrix4 transform = Matrix4.translationValues(turnsValue, 0, 0);
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}
