import 'package:demo/bloc/index.dart';
import 'package:demo/model/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherDemo extends StatefulWidget {
  const WeatherDemo({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: BlocListener<WeatherBloc, WeatherState>(
            listener: (BuildContext context, WeatherState state) {
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

  Column buildColumnWithData(Weather? weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          weather?.cityName ?? '',
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        Text(
          '${weather?.temperatureCelsius} oC',
          style: const TextStyle(fontSize: 80),
        ),
        buildInitialInput(),
      ],
    );
  }

  submitCityName(cityName) {
    context.read<WeatherBloc>().add(GetWeather(cityName));
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildInitialInput() {
    return CityInputField(
      submitCityName: submitCityName,
    );
  }
}

class CityInputField extends StatefulWidget {
  final ValueChanged<String> submitCityName;

  const CityInputField({Key? key, required this.submitCityName}) : super(key: key);

  @override
  _CityInputFieldState createState() => _CityInputFieldState();
}

class _CityInputFieldState extends State<CityInputField> {
  ValueChanged<String> get submitCityName => widget.submitCityName;

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
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
