import 'dart:convert';

import 'package:demo/model/index.dart';
import 'package:flutter/services.dart';

class PetListMessageChannel {
  static final jsonMessageCodecChannel = BasicMessageChannel<dynamic>(
    'flutter_demo/json_message_channel',
    JSONMessageCodec(),
  );

  static final binaryCodecChannel = BasicMessageChannel(
    'flutter_demo/binary_message_channel',
    BinaryCodec(),
  );

  static void addPetDetails(PetDetails petDetails) {
    jsonMessageCodecChannel.send(petDetails.toJson());
  }

  static Future<void> removePet(int index) async {
    final uInt8List = utf8.encoder.convert(index.toString());
    final replay = await binaryCodecChannel.send(uInt8List.buffer.asByteData());
    if (replay == null) {
      throw PlatformException(
        code: "INVALID INDEX",
        message: "Failed to delete pet details",
        details: null,
      );
    }
  }
}
