part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {
  final Weather? weather;

  const WeatherState(this.weather);
}

class WeatherInitial extends WeatherState {
  const WeatherInitial() : super(null);
}

class WeatherLoading extends WeatherState {
  const WeatherLoading() : super(null);
}

class WeatherLoaded extends WeatherState {
  const WeatherLoaded(weather) : super(weather);
}
