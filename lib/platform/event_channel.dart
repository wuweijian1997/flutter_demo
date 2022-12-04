import 'package:flutter/services.dart';

class FlutterEventChannel {
  static const _eventChannel =
      EventChannel("flutter_demo/event_channel");

  static Stream<AccelerometerReadings> get stream {
    return _eventChannel
        .receiveBroadcastStream()
        .map((dynamic event) => AccelerometerReadings(event[0] as double, event[1] as double, event[2] as double));
  }
}

class AccelerometerReadings {
  final double x;
  final double y;
  final double z;
  AccelerometerReadings(this.x, this.y, this.z);
}