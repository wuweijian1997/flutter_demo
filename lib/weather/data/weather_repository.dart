import 'dart:math';

import 'package:demo/model/index.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository {
  @override
  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(const Duration(seconds: 1), () {
      final random = Random();
      if(random.nextBool()) {
        throw NetworkException();
      }
      return Weather(
        temperatureCelsius: 20.0 + random.nextInt(15),
        cityName: cityName,
      );
    });
  }

}

class NetworkException implements Exception {

}