import 'package:flutter/services.dart';

class FlutterEventChannel {
  static const _eventChannel =
      const EventChannel("flutter_demo/event_channel");

  static Stream<int> get stream {
    return _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => event);
  }
}
