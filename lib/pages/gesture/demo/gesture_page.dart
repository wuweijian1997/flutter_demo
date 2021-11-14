import 'package:demo/model/index.dart';
import 'package:demo/pages/gesture/demo/spring/spring_page.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';


class GesturePage extends StatelessWidget {
  static const rName = 'Gesture';
  final List<ListPageModel> list = [
    ListPageModel(
      title: 'Spring',
      page: SpringPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}