import 'package:demo/model/index.dart';
import 'package:demo/pages/sliver/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class SliverPage extends StatefulWidget {
  static const String rName = "Sliver";

  @override
  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  List<PageRouteModel> list = [
    PageRouteModel(page: SliverOverlapInjectorDemo.rName),
    PageRouteModel(page: RefreshPage.rName),
    PageRouteModel(page: SliverPersistentHeaderDelegatePage.rName),
    PageRouteModel(page: WeChatHomeDropDown.rName),
    PageRouteModel(page: SliverGeometryTestPage.rName),
    PageRouteModel(page: SliverToolsPage.rName),
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
