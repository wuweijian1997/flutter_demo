// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PetListModel _$$_PetListModelFromJson(Map<String, dynamic> json) =>
    _$_PetListModel(
      petList: (json['petList'] as List<dynamic>)
          .map((e) => PetDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PetListModelToJson(_$_PetListModel instance) =>
    <String, dynamic>{
      'petList': instance.petList,
    };
