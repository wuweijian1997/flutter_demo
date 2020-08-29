
import 'package:demo/shared/index.dart';

extension FixDouble on double {
  double get px {
    return SizeFit.fitWidth(this);
  }
}
