import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';

class ColorDrawing extends StatefulWidget {
  const ColorDrawing({Key? key}) : super(key: key);

  @override
  _ColorDrawingState createState() => _ColorDrawingState();
}

class _ColorDrawingState extends State<ColorDrawing> {
  var list = <ListPageModel>[];
  @override
  void initState() {
    list = [
      ListPageModel(title: "图片颜色绘制", page: const ImageColorDrawing()),
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}
