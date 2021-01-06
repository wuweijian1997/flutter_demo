import 'package:flutter/services.dart';

class CounterChannel {
  static MethodChannel methodChannel = const MethodChannel('flutter_demo/counter');

  static Future<int> increment(int value) async {
    final result = await methodChannel
        .invokeMethod<int>('increment', {'count': value});
    return result;
  }
}