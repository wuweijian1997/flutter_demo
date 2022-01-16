// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'pet_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PetDetails _$PetDetailsFromJson(Map<String, dynamic> json) {
  return _PetDetails.fromJson(json);
}

/// @nodoc
class _$PetDetailsTearOff {
  const _$PetDetailsTearOff();

  _PetDetails call({required String petType, required String breed}) {
    return _PetDetails(
      petType: petType,
      breed: breed,
    );
  }

  PetDetails fromJson(Map<String, Object?> json) {
    return PetDetails.fromJson(json);
  }
}

/// @nodoc
const $PetDetails = _$PetDetailsTearOff();

/// @nodoc
mixin _$PetDetails {
  String get petType => throw _privateConstructorUsedError;
  String get breed => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PetDetailsCopyWith<PetDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetDetailsCopyWith<$Res> {
  factory $PetDetailsCopyWith(
          PetDetails value, $Res Function(PetDetails) then) =
      _$PetDetailsCopyWithImpl<$Res>;
  $Res call({String petType, String breed});
}

/// @nodoc
class _$PetDetailsCopyWithImpl<$Res> implements $PetDetailsCopyWith<$Res> {
  _$PetDetailsCopyWithImpl(this._value, this._then);

  final PetDetails _value;
  // ignore: unused_field
  final $Res Function(PetDetails) _then;

  @override
  $Res call({
    Object? petType = freezed,
    Object? breed = freezed,
  }) {
    return _then(_value.copyWith(
      petType: petType == freezed
          ? _value.petType
          : petType // ignore: cast_nullable_to_non_nullable
              as String,
      breed: breed == freezed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$PetDetailsCopyWith<$Res> implements $PetDetailsCopyWith<$Res> {
  factory _$PetDetailsCopyWith(
          _PetDetails value, $Res Function(_PetDetails) then) =
      __$PetDetailsCopyWithImpl<$Res>;
  @override
  $Res call({String petType, String breed});
}

/// @nodoc
class __$PetDetailsCopyWithImpl<$Res> extends _$PetDetailsCopyWithImpl<$Res>
    implements _$PetDetailsCopyWith<$Res> {
  __$PetDetailsCopyWithImpl(
      _PetDetails _value, $Res Function(_PetDetails) _then)
      : super(_value, (v) => _then(v as _PetDetails));

  @override
  _PetDetails get _value => super._value as _PetDetails;

  @override
  $Res call({
    Object? petType = freezed,
    Object? breed = freezed,
  }) {
    return _then(_PetDetails(
      petType: petType == freezed
          ? _value.petType
          : petType // ignore: cast_nullable_to_non_nullable
              as String,
      breed: breed == freezed
          ? _value.breed
          : breed // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PetDetails with DiagnosticableTreeMixin implements _PetDetails {
  const _$_PetDetails({required this.petType, required this.breed});

  factory _$_PetDetails.fromJson(Map<String, dynamic> json) =>
      _$$_PetDetailsFromJson(json);

  @override
  final String petType;
  @override
  final String breed;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PetDetails(petType: $petType, breed: $breed)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PetDetails'))
      ..add(DiagnosticsProperty('petType', petType))
      ..add(DiagnosticsProperty('breed', breed));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PetDetails &&
            const DeepCollectionEquality().equals(other.petType, petType) &&
            const DeepCollectionEquality().equals(other.breed, breed));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(petType),
      const DeepCollectionEquality().hash(breed));

  @JsonKey(ignore: true)
  @override
  _$PetDetailsCopyWith<_PetDetails> get copyWith =>
      __$PetDetailsCopyWithImpl<_PetDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PetDetailsToJson(this);
  }
}

abstract class _PetDetails implements PetDetails {
  const factory _PetDetails({required String petType, required String breed}) =
      _$_PetDetails;

  factory _PetDetails.fromJson(Map<String, dynamic> json) =
      _$_PetDetails.fromJson;

  @override
  String get petType;
  @override
  String get breed;
  @override
  @JsonKey(ignore: true)
  _$PetDetailsCopyWith<_PetDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
