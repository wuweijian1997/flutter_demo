
import 'package:demo/effect/index.dart';

extension FixInt on int {
  double get px {
    return SizeFit.fitWidth(toDouble());
  }
}
