import 'package:demo/effect/index.dart';

extension FixDouble on double {
  double get px {
    return SizeFit.fitWidth(this);
  }
}
