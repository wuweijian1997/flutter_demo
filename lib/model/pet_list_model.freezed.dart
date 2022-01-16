// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pet_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PetListModel _$PetListModelFromJson(Map<String, dynamic> json) {
  return _PetListModel.fromJson(json);
}

/// @nodoc
class _$PetListModelTearOff {
  const _$PetListModelTearOff();

  _PetListModel call({required List<PetDetails> petList}) {
    return _PetListModel(
      petList: petList,
    );
  }

  PetListModel fromJson(Map<String, Object?> json) {
    return PetListModel.fromJson(json);
  }
}

/// @nodoc
const $PetListModel = _$PetListModelTearOff();

/// @nodoc
mixin _$PetListModel {
  List<PetDetails> get petList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PetListModelCopyWith<PetListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetListModelCopyWith<$Res> {
  factory $PetListModelCopyWith(
          PetListModel value, $Res Function(PetListModel) then) =
      _$PetListModelCopyWithImpl<$Res>;
  $Res call({List<PetDetails> petList});
}

/// @nodoc
class _$PetListModelCopyWithImpl<$Res> implements $PetListModelCopyWith<$Res> {
  _$PetListModelCopyWithImpl(this._value, this._then);

  final PetListModel _value;
  // ignore: unused_field
  final $Res Function(PetListModel) _then;

  @override
  $Res call({
    Object? petList = freezed,
  }) {
    return _then(_value.copyWith(
      petList: petList == freezed
          ? _value.petList
          : petList // ignore: cast_nullable_to_non_nullable
              as List<PetDetails>,
    ));
  }
}

/// @nodoc
abstract class _$PetListModelCopyWith<$Res>
    implements $PetListModelCopyWith<$Res> {
  factory _$PetListModelCopyWith(
          _PetListModel value, $Res Function(_PetListModel) then) =
      __$PetListModelCopyWithImpl<$Res>;
  @override
  $Res call({List<PetDetails> petList});
}

/// @nodoc
class __$PetListModelCopyWithImpl<$Res> extends _$PetListModelCopyWithImpl<$Res>
    implements _$PetListModelCopyWith<$Res> {
  __$PetListModelCopyWithImpl(
      _PetListModel _value, $Res Function(_PetListModel) _then)
      : super(_value, (v) => _then(v as _PetListModel));

  @override
  _PetListModel get _value => super._value as _PetListModel;

  @override
  $Res call({
    Object? petList = freezed,
  }) {
    return _then(_PetListModel(
      petList: petList == freezed
          ? _value.petList
          : petList // ignore: cast_nullable_to_non_nullable
              as List<PetDetails>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PetListModel implements _PetListModel {
  _$_PetListModel({required this.petList});

  factory _$_PetListModel.fromJson(Map<String, dynamic> json) =>
      _$$_PetListModelFromJson(json);

  @override
  final List<PetDetails> petList;

  @override
  String toString() {
    return 'PetListModel(petList: $petList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PetListModel &&
            const DeepCollectionEquality().equals(other.petList, petList));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(petList));

  @JsonKey(ignore: true)
  @override
  _$PetListModelCopyWith<_PetListModel> get copyWith =>
      __$PetListModelCopyWithImpl<_PetListModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PetListModelToJson(this);
  }
}

abstract class _PetListModel implements PetListModel {
  factory _PetListModel({required List<PetDetails> petList}) = _$_PetListModel;

  factory _PetListModel.fromJson(Map<String, dynamic> json) =
      _$_PetListModel.fromJson;

  @override
  List<PetDetails> get petList;
  @override
  @JsonKey(ignore: true)
  _$PetListModelCopyWith<_PetListModel> get copyWith =>
      throw _privateConstructorUsedError;
}
