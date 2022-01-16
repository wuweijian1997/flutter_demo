import 'package:freezed_annotation/freezed_annotation.dart';
import 'pet_details.dart';

part 'pet_list_model.freezed.dart';
part 'pet_list_model.g.dart';

@freezed
class PetListModel with _$PetListModel{
  factory PetListModel({
    required List<PetDetails> petList,
  }) = _PetListModel;

  factory PetListModel.fromJson(Map<String, dynamic> json) => _$PetListModelFromJson(json);
}

