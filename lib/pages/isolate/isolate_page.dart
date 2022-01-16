import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class IsolatePage extends StatelessWidget {
  static const String rName = "Isolate";

  final List<ListPageModel> list = [
    ListPageModel(title: ComputePage.rName, page: ComputePage()),
    ListPageModel(
        title: InfiniteProcessPage.rName, page: InfiniteProcessPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListPage(list),
    );
  }
}
