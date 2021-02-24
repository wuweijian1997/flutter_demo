import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/basic_custom_paint.dart';
import 'package:flutter/material.dart';

class CanvasDrawingPage extends StatefulWidget {

  @override
  _CanvasDrawingPageState createState() => _CanvasDrawingPageState();
}

class _CanvasDrawingPageState extends State<CanvasDrawingPage> {
  List<ListPageModel> list = [];

  @override
  void initState() {
    super.initState();
    list = [
      ListPageModel(title: '画布变化和状态', page: BasicCustomPaint(drawTransformAndState))
    ];
  }

  ///画布变化和状态
  drawTransformAndState(Canvas canvas, Size size) {

  }

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}

