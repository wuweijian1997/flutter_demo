import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class RenderObjectPage extends StatefulWidget {
  static const String rName = "RenderObject";

  @override
  _RenderObjectPageState createState() => _RenderObjectPageState();
}

class _RenderObjectPageState extends State<RenderObjectPage> {
  final List<ListPageModel> list = [
    ListPageModel(
      title: 'Padding',
      page: Container(
        color: Colors.blue,
        child: CustomPadding(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(0),
          child: Container(
            color: Colors.red,
          ),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListPage(list),
    );
  }
}
