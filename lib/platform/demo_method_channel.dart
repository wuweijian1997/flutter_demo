import 'package:flutter/services.dart';

class DemoMethodChannel {
  static const MethodChannel _methodChannel = const MethodChannel('flutter_demo/method_channel');

  static Future<int> increment(int value) async {
    final result = await _methodChannel
        .invokeMethod<int>('increment', {'count': value});
    return result;
  }

  static Future<bool> startCountdown(int value) async {
    final result = await _methodChannel
        .invokeMethod<bool>('start_countdown', {'count': value});
    return result;
  }
}