import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class BasicPage extends StatefulWidget {
  @override
  _BasicPageState createState() => _BasicPageState();
}

class _BasicPageState extends State<BasicPage> {
  final List<ListPageModel> list = [ListPageModel(title: "画笔的属性", page: PaintPage())];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListPage(list),
      ),
    );
  }
}
