import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperatureCelsius;
  final double temperatureFahrenheit;

  Weather({required this.cityName, required this.temperatureCelsius, this.temperatureFahrenheit = 0});

  factory Weather.fromJson(Map<String, dynamic> json) =>
      Weather(cityName: json['cityName'], temperatureCelsius: json['temperature']);

  Map<String, dynamic> toJson() =>
      {'cityName': cityName, 'temperature': temperatureCelsius};

  @override
  List<Object> get props => [
        cityName,
        temperatureCelsius,
        temperatureFahrenheit,
      ];
}
