import 'package:demo/model/index.dart';
import 'package:demo/pages/canvas/index.dart';
import 'package:flutter/material.dart';


class CanvasPage extends StatefulWidget {
  static const rName = 'Canvas';

  @override
  _CanvasPageState createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  List<PageModel> list = [
    PageModel(
      code: '',
      title: 'Basic',
      page: BasicCanvasPage(),
    ),
    PageModel(
      code: '',
      title: 'Bubble',
      page: LayoutBuilder(
        builder: (_, constraints) => BubblePage(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (_, index) {
          return _ListItem(pageModel: list[index], index: index,);
        },
        itemCount: list.length,
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final PageModel pageModel;
  final int index;

  _ListItem({this.pageModel, this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(CanvasDemoPage.rName, arguments: pageModel);
      },
      child: Container(
        height: 200,
        width: double.infinity,
        alignment: Alignment.center,
        color: Colors.blue[(index + 1) * 100],
        child: Text(pageModel.title),
      ),
    );
  }
}