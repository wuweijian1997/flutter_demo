part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {
  final Weather weather;

  WeatherState(this.weather);
}

class WeatherInitial extends WeatherState {
  WeatherInitial() : super(null);
}

class WeatherLoading extends WeatherState {
  WeatherLoading() : super(null);
}

class WeatherLoaded extends WeatherState {
  WeatherLoaded(weather) : super(weather);
}
