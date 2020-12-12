import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperatureCelsius;
  final double temperatureFahrenheit;

  Weather({this.cityName, this.temperatureCelsius, this.temperatureFahrenheit});

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
