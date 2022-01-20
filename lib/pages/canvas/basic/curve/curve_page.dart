import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class CurvePage extends StatelessWidget {
  final List<ListPageModel> list = [
    ListPageModel(title: "Path与曲线", page: const PathCurvePage())
  ];

  CurvePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}
