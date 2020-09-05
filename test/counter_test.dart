import 'package:demo/test/counter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('counter class test', () {
    Counter counter;

    //所有测试前会执行的代码
    setUpAll(() {
      counter = Counter();
    });
    
    test('counter default value', () {
      expect(counter.value, 0);
    });
    
    test('counter increment method', () {
      counter.increment();
      expect(counter.value, 1);
    });

    test('counter increment method', () {
      counter.decrement();
      expect(counter.value, 0);
    });
  });
}
