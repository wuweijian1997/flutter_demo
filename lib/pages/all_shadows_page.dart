import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

/// 使用不同的方法实现widget
class AllShadowsPage extends StatefulWidget {
  static const String rName = "AllShadows";

  const AllShadowsPage({Key? key}) : super(key: key);

  @override
  _AllShadowsPageState createState() => _AllShadowsPageState();
}

class _AllShadowsPageState extends State<AllShadowsPage> {
  List<ListPageModel> list = [
    ListPageModel(title: "Decorated Box", page: const ShadowDecoratedBox()),
  ];

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}
