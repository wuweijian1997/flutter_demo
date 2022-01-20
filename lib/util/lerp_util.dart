class LerpUtil {
  static double lerpDouble(num a, num b, double t) {
    if (a == b || (a.isNaN == true) && (b.isNaN == true)) {
      return a.toDouble();
    }
    return a * (1.0 - t) + b * t;
  }
}