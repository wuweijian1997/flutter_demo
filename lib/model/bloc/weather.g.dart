// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Weather _$$_WeatherFromJson(Map<String, dynamic> json) => _$_Weather(
      cityName: json['cityName'] as String,
      temperatureCelsius: (json['temperatureCelsius'] as num).toDouble(),
      temperatureFahrenheit:
          (json['temperatureFahrenheit'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$_WeatherToJson(_$_Weather instance) =>
    <String, dynamic>{
      'cityName': instance.cityName,
      'temperatureCelsius': instance.temperatureCelsius,
      'temperatureFahrenheit': instance.temperatureFahrenheit,
    };
