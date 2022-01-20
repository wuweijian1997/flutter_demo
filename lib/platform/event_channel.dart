import 'package:flutter/services.dart';

class FlutterEventChannel {
  static const _eventChannel =
      EventChannel("flutter_demo/event_channel");

  static Stream<int> get stream {
    return _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => event);
  }
}
