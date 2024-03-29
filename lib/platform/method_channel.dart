import 'package:flutter/services.dart';

class FlutterMethodChannel {
  static const MethodChannel methodChannel = MethodChannel('flutter_demo/method_channel');

  static Future<int?> increment(int value) async {
    final result = await methodChannel.invokeMethod<int>('increment', {'count': value});
    return result;
  }

  static Future<int?> decrement(int value) async {
    final result = await methodChannel.invokeMethod<int>('decrement', {'count': value});
    return result;
  }

  static Future<bool?> startCountdown(int value) async {
    final result = await methodChannel.invokeMethod<bool>('start_countdown', {'count': value});
    return result;
  }
}
