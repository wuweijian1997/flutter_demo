import 'dart:math';

class Utils {
  static final Random _random = Random();

  static double randomDoubleValue(double minValue, double maxValue) {
    assert(maxValue >= minValue);
    return _random.nextDouble() * (maxValue - minValue) + minValue;
  }

  static double randomMoveX(double value) {
    return _random.nextBool() ? value : -value;
  }
}
