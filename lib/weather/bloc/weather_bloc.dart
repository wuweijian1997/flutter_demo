import 'dart:async';
import 'dart:math';

import 'package:demo/model/index.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends HydratedBloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(const WeatherInitial());


  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeather) {
      yield const WeatherLoading();
      Weather weather = await _fetchWeatherFromFakeApi(event.cityName);
      yield WeatherLoaded(weather);
    }
  }

  Future<Weather> _fetchWeatherFromFakeApi(String cityName) {
    return Future.delayed(const Duration(seconds: 1), () {
      return Weather(
        cityName: cityName,
        temperatureCelsius: 20.0 + Random().nextInt(15),
      );
    });
  }

  @override
  WeatherState? fromJson(Map<String, dynamic> json) {
    try {
      final weather = Weather.fromJson(json);
      return WeatherLoaded(weather);
    } catch(_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(WeatherState state) {
      return state.weather?.toJson();
  }
}
