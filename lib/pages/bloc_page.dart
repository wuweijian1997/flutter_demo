import 'package:demo/model/index.dart';
import 'package:demo/pages/bloc/index.dart';
import 'package:demo/pages/bloc/weather_demo.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class BlocPage extends StatelessWidget {
  static final String rName = 'BlocPage';
  final List<PageRouteModel> list = [
    PageRouteModel(page: 'Custom Bloc', arguments: CustomBlocDemo()),
    PageRouteModel(page: 'Flutter Bloc', arguments: FlutterBlocDemo()),
    PageRouteModel(page: 'Weather Bloc', arguments: WeatherDemo()),
    PageRouteModel(page: 'Theme Bloc', arguments: ThemeBlocDemo()),
  ];

  @override
  Widget build(BuildContext context) {
    return PageList(list: list);
  }
}

