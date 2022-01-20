import 'package:bloc/bloc.dart';
import 'package:demo/model/index.dart';
import 'package:demo/weather/data/weather_repository.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  WeatherCubit(this._weatherRepository) : super(const WeatherInitial());

  Future<void> getWeather(String name) async {
    try {
      emit(const WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(name);
      emit(WeatherLoaded(weather));
    } on NetworkException {
      emit(const WeatherError("Couldn't fetch weather. Is the device online?"));
    }
  }
}
