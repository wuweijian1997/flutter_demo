import 'package:demo/model/index.dart';
import 'package:demo/pages/sliver/sliver_tool/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class SliverToolsPage extends StatefulWidget {
  static const String rName = 'SliverTools';
  @override
  _SliverToolsPageState createState() => _SliverToolsPageState();
}

class _SliverToolsPageState extends State<SliverToolsPage> {
  List<PageRouteModel> list = [
    PageRouteModel(
      page: MultiSliverDemo.rName,
    ),
    PageRouteModel(
      page: SliverClipDemo.rName,
    ),
    PageRouteModel(
      page: SliverStackDemo.rName,
    ),
    PageRouteModel(
      page: SliverCrossAxisConstrainedDemo.rName,
    )
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
