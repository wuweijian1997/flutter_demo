import 'package:flutter/services.dart';

class DemoEventChannel {
  static const _countdownEventChannel =
      const EventChannel("flutter_demo/event_channel");

  static Stream<int> get stream {
    return _countdownEventChannel.receiveBroadcastStream().map(
          (dynamic event) => event,
        );
  }
}
