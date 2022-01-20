import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class BasicCanvasPage extends StatefulWidget {
  const BasicCanvasPage({Key? key}) : super(key: key);

  @override
  _BasicCanvasPageState createState() => _BasicCanvasPageState();
}

class _BasicCanvasPageState extends State<BasicCanvasPage> {
  final List<ListPageModel> list = [
    ListPageModel(title: "画笔的属性", page: const PaintPage()),
    ListPageModel(title: "画布绘制", page: const CanvasDrawingPage()),
    ListPageModel(title: "路径绘制", page: const PathDrawing()),
    ListPageModel(title: "颜色绘制", page: const ColorDrawing()),
    ListPageModel(title: "曲线", page: CurvePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListPage(list),
    );
  }
}
