import 'package:json_annotation/json_annotation.dart';

class Weather {
  final String cityName;
  final double temperature;

  Weather({this.cityName, this.temperature});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      Weather(cityName: json['cityName'], temperature: json['temperature']);

  Map<String, dynamic> toJson() =>
      {'cityName': cityName, 'temperature': temperature};
}
