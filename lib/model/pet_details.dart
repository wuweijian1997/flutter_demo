import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'pet_details.freezed.dart';
part 'pet_details.g.dart';

@freezed
class PetDetails  with _$PetDetails {

  const factory PetDetails({required String petType, required String breed}) = _PetDetails;

  factory PetDetails.fromJson(Map<String, dynamic> json) =>
      _$PetDetailsFromJson(json);
}
