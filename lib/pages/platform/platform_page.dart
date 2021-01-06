import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';


class PlatformPage extends StatelessWidget {
  static const String rName = "Platform";

  final List<PageRouteModel> list = [
    PageRouteModel(page: FlutterToNativePage.rName),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListCard(
        list: list,
      ),
    );
  }
}
