import 'package:demo/model/index.dart';
import 'package:demo/pages/bloc/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class BlocPage extends StatelessWidget {
  static final String rName = 'BlocPage';
  final List<PageRouteModel> list = [
    PageRouteModel(page: 'CustomBlocDemo', arguments: CustomBlocDemo()),
    PageRouteModel(page: 'FlutterBlocDemo', arguments: FlutterBlocDemo()),
  ];

  @override
  Widget build(BuildContext context) {
    return PageList(list: list);
  }
}

