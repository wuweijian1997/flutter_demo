import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

/// 使用不同的方法实现widget
class AllShadowsPage extends StatefulWidget {
  static final String rName = "AllShadows";

  @override
  _AllShadowsPageState createState() => _AllShadowsPageState();
}

class _AllShadowsPageState extends State<AllShadowsPage> {
  List<ListPageModel> list = [
    ListPageModel(title: "Decorated Box", page: ShadowDecoratedBox()),
  ];

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}
