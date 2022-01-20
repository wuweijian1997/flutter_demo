import 'package:demo/model/index.dart';
import 'package:demo/pages/bloc/index.dart';
import 'package:demo/pages/bloc/weather_demo.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class BlocPage extends StatelessWidget {
  static const String rName = 'BlocPage';
  final List<ListPageModel> list = [
    ListPageModel(title: 'Custom Bloc', page: const CustomBlocDemo()),
    ListPageModel(title: 'Flutter Bloc', page: const FlutterBlocDemo()),
    ListPageModel(title: 'Weather Bloc', page: const WeatherDemo()),
    ListPageModel(title: 'Theme Bloc', page: const ThemeBlocDemo()),
    ListPageModel(title: 'Weather Cubit', page: const WeatherCubitDemo()),
  ];

  BlocPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}
