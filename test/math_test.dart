import 'package:demo/test/math_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('test math util file', () {
    test('math_util_file_text', () {
      final result = sum(20, 30);
      expect(result, 50);
    });

    test('math_util_mul_text', () {
      final result = mul(20, 30);
      expect(result, 600);
    });
  });
}