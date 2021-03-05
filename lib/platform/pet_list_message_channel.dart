import 'dart:convert';

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

class PetListModel {
  PetListModel({
    required this.petList,
  });

  final List<PetDetails> petList;

  factory PetListModel.fromJson(String jsonString) {
    final jsonData = json.decode(jsonString) as Map<String, dynamic>;
    return PetListModel(petList: List.from(
        (jsonData['petList'] as List).map<PetDetails>((
            dynamic petDetailsMap) =>
            PetDetails.fromMap(petDetailsMap as Map<String, dynamic>),)),);
  }
}

class PetDetails {
  final String petType;
  final String breed;

  PetDetails({required this.petType, required this.breed});

  factory PetDetails.fromMap(Map<String, dynamic> map) =>
      PetDetails(
        petType: map['petType'] as String,
        breed: map['breed'] as String,
      );

  Map<String, String> toJson() =>
      <String, String>{
        'petType': petType,
        'breed': breed,
      };
}
