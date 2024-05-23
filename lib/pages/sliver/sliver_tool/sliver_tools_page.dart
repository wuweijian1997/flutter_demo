import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class SliverToolsPage extends StatefulWidget {
  static const String rName = 'SliverTools';

  const SliverToolsPage({super.key});

  @override
  State<SliverToolsPage> createState() => _SliverToolsPageState();
}

class _SliverToolsPageState extends State<SliverToolsPage> {
  List<ListPageModel> list = [
    ListPageModel(
      page: const MultiSliverDemo(),
      title: MultiSliverDemo.rName,
    ),
    ListPageModel(
      page: const SliverClipDemo(),
      title: SliverClipDemo.rName,
    ),
    ListPageModel(
      page: const SliverStackDemo(),
      title: SliverStackDemo.rName,
    ),
    ListPageModel(
      page: const SliverCrossAxisConstrainedDemo(),
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
