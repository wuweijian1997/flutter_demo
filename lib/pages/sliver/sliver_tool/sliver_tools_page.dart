import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class SliverToolsPage extends StatefulWidget {
  static const String rName = 'SliverTools';

  @override
  _SliverToolsPageState createState() => _SliverToolsPageState();
}

class _SliverToolsPageState extends State<SliverToolsPage> {
  List<ListPageModel> list = [
    ListPageModel(
      page: MultiSliverDemo(),
      title: MultiSliverDemo.rName,
    ),
    ListPageModel(
      page: SliverClipDemo(),
      title: SliverClipDemo.rName,
    ),
    ListPageModel(
      page: SliverStackDemo(),
      title: SliverStackDemo.rName,
    ),
    ListPageModel(
      page: SliverCrossAxisConstrainedDemo(),
      title: SliverCrossAxisConstrainedDemo.rName,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListPage(list),
    );
  }
}
