import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

@freezed
abstract class Weather with _$Weather {
  const factory Weather({required String cityName, required double temperatureCelsius,  @Default(0) double temperatureFahrenheit}) = _Weather;
  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
}