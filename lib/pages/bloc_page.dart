import 'package:demo/model/index.dart';
import 'package:demo/pages/bloc/index.dart';
import 'package:demo/pages/bloc/weather_demo.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class BlocPage extends StatelessWidget {
  static final String rName = 'BlocPage';
  final List<ListPageModel> list = [
    ListPageModel(title: 'Custom Bloc', page: CustomBlocDemo()),
    ListPageModel(title: 'Flutter Bloc', page: FlutterBlocDemo()),
    ListPageModel(title: 'Weather Bloc', page: WeatherDemo()),
    ListPageModel(title: 'Theme Bloc', page: ThemeBlocDemo()),
    ListPageModel(title: 'Weather Cubit', page: WeatherCubitDemo()),
  ];

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}
