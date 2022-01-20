import 'package:demo/model/index.dart';
import 'package:demo/weather/cubit/weather/weather_cubit.dart';
import 'package:demo/weather/data/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'weather_demo.dart';

class WeatherCubitDemo extends StatelessWidget {
  const WeatherCubitDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<WeatherCubit>(
        create: (BuildContext context) => WeatherCubit(FakeWeatherRepository()),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
              if (state is WeatherError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, WeatherState state) {
              if (state is WeatherLoading) {
                return buildLoading();
              } else if (state is WeatherLoaded) {
                return buildColumnWithData(context, state.weather);
              } else {
                return buildInitialInput(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Column buildColumnWithData(BuildContext context, Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          weather.cityName,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        Text(
          '${weather.temperatureCelsius} oC',
          style: const TextStyle(fontSize: 80),
        ),
        buildInitialInput(context),
      ],
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildInitialInput(BuildContext context) {
    return CityInputField(
      submitCityName: (String cityName) {
        context.read<WeatherCubit>().getWeather(cityName);
      },
    );
  }
}
