import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class SliverPage extends StatefulWidget {
  static const String rName = "Sliver";

  const SliverPage({Key? key}) : super(key: key);

  @override
  _SliverPageState createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  List<ListPageModel> list = [
    ListPageModel(page: SliverOverlapInjectorDemo(),title: SliverOverlapInjectorDemo.rName),
    ListPageModel(page: const RefreshPage(),title: RefreshPage.rName),
    ListPageModel(page: const SliverPersistentHeaderDelegatePage(),title: SliverPersistentHeaderDelegatePage.rName),
    ListPageModel(page: const WeChatHomeDropDown(),title: WeChatHomeDropDown.rName),
    ListPageModel(page: const SliverGeometryTestPage(),title: SliverGeometryTestPage.rName),
    ListPageModel(page: const SliverToolsPage(),title: SliverToolsPage.rName),
    ListPageModel(page: const SliverConstraintsOverlapPage(),title: SliverConstraintsOverlapPage.rName),
    ListPageModel(page: const SliverTestPage(),title: SliverTestPage.rName),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListPage(list),
    );
  }
}
