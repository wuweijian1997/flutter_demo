import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class PathDrawing extends StatefulWidget {
  @override
  _PathDrawingState createState() => _PathDrawingState();
}

class _PathDrawingState extends State<PathDrawing> {
  var list = <ListPageModel>[];
  @override
  void initState() {
    super.initState();
    list = [
      ListPageModel(title: "路径的图形添加", page: PathGraphicsDrawing()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}
