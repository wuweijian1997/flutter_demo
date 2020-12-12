part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {
  final String cityName;
  WeatherEvent(this.cityName);
}

class GetWeather extends WeatherEvent {
  final String cityName;
  GetWeather(this.cityName): super(cityName);
}