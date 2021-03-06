import 'dart:typed_data';

import 'package:flutter/services.dart';

class FlutterBasicMessageChannel {
  static final _basicMessageChannel = const BasicMessageChannel<dynamic>(
      'flutter_demo/basic_message_channel', StandardMessageCodec());

  static Future<Uint8List> assets(String asset) async {
    return await _basicMessageChannel.send(asset) as Uint8List;
  }
}
