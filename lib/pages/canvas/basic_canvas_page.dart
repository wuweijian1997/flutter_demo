import 'package:demo/model/index.dart';
import 'package:demo/pages/canvas/basic/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class BasicCanvasPage extends StatefulWidget {
  @override
  _BasicCanvasPageState createState() => _BasicCanvasPageState();
}

class _BasicCanvasPageState extends State<BasicCanvasPage> {
  final List<ListPageModel> list = [
    ListPageModel(title: "画笔的属性", page: PaintPage()),
    ListPageModel(title: "画布绘制", page: CanvasDrawingPage()),
    ListPageModel(title: "路径绘制", page: PathDrawing()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListPage(list),
      ),
    );
  }
}
