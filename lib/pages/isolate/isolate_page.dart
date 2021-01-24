import 'package:demo/model/index.dart';
import 'package:demo/pages/isolate/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class IsolatePage extends StatelessWidget {
  static const String rName = "Isolate";

  final List<PageRouteModel> list = [
    PageRouteModel(page: ComputePage.rName),
    PageRouteModel(page: InfiniteProcessPage.rName),
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
