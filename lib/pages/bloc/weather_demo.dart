import 'package:demo/bloc/index.dart';
import 'package:demo/model/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherDemo extends StatefulWidget {
  @override
  _WeatherDemoState createState() => _WeatherDemoState();
}

class _WeatherDemoState extends State<WeatherDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<WeatherBloc>(
        create: (BuildContext context) => WeatherBloc(),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: BlocListener<WeatherBloc, WeatherState>(
            listener: (BuildContext context, WeatherState state) {
              if(state is WeatherLoaded) {
                print('Loaded: ${state.weather.cityName}');
              }
            },
            child: BlocBuilder<WeatherBloc, WeatherState>(
              builder: (_, WeatherState state) {
                if (state is WeatherInitial) {
                  return buildInitialInput();
                } else if (state is WeatherLoading) {
                  return buildLoading();
                } else {
                  return buildColumnWithData(state.weather);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          weather?.cityName ?? '',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        MultiBlocProvider(
          providers: [
            BlocProvider(create: null),
          ],
        ),
        Text(
          '${weather.temperature} oC',
          style: TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildInitialInput() {
    return CityInputField();
  }
}

class CityInputField extends StatefulWidget {
  @override
  _CityInputFieldState createState() => _CityInputFieldState();
}

class _CityInputFieldState extends State<CityInputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: submitCityName,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Enter a city',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(String cityName) {
    context.read<WeatherBloc>().add(GetWeather(cityName));
  }
}
