part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {
  final String cityName;
  const WeatherEvent(this.cityName);
}

class GetWeather extends WeatherEvent {
  const GetWeather(String cityName): super(cityName);
}