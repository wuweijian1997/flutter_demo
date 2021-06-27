import 'package:demo/model/index.dart';
import 'package:demo/pages/canvas/demo/index.dart';
import 'package:demo/pages/canvas/index.dart';
import 'package:demo/pages/index.dart';
import 'package:flutter/material.dart';


class CanvasPage extends StatelessWidget {
  static const rName = 'Canvas';

  final List<ListPageModel> list = [
    ListPageModel(
      title: 'Basic',
      page: BasicCanvasPage(),
    ),
    ListPageModel(
      title: 'Bubble',
      page: LayoutBuilder(
        builder: (_, constraints) => BubblePage(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
        ),
      ),
    ),
    ListPageModel(
      title: 'Bean Man',
      page: BeanMan(),
    ),
    ListPageModel(
      title: 'Gesture Drawing',
      page: GestureDrawing(),
    ),
    ListPageModel(
      title: 'Ruler Chooser',
      page: RulerChooser(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListPage(list);
  }
}