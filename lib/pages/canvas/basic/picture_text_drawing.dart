import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class PictureTextDrawing extends StatefulWidget {
  @override
  _PictureTextDrawingState createState() => _PictureTextDrawingState();
}

class _PictureTextDrawingState extends State<PictureTextDrawing> {
  var list = <ListPageModel>[];
  @override
  void initState() {
    super.initState();
    list = [
      ListPageModel(title: "图片绘制", page: PictureDrawing()),
      ListPageModel(title: "文字绘制", page: TextDrawing()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}
