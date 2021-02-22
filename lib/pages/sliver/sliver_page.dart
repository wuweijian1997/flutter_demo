import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/pages/sliver/index.dart';
import 'package:flutter/material.dart';

class SliverPage extends StatefulWidget {
  static const String rName = "Sliver";

  @override
  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  List<ListPageModel> list = [
    ListPageModel(page: SliverOverlapInjectorDemo(),title: SliverOverlapInjectorDemo.rName),
    ListPageModel(page: RefreshPage(),title: RefreshPage.rName),
    ListPageModel(page: SliverPersistentHeaderDelegatePage(),title: SliverPersistentHeaderDelegatePage.rName),
    ListPageModel(page: WeChatHomeDropDown(),title: WeChatHomeDropDown.rName),
    ListPageModel(page: SliverGeometryTestPage(),title: SliverGeometryTestPage.rName),
    ListPageModel(page: SliverToolsPage(),title: SliverToolsPage.rName),
    ListPageModel(page: SliverConstraintsOverlapPage(),title: SliverConstraintsOverlapPage.rName),
    ListPageModel(page: SliverTestPage(),title: SliverTestPage.rName),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListPage(list),
    );
  }
}
