import 'package:flutter/material.dart';
import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';

class RenderObjectPage extends StatefulWidget {
  static const String rName = "RenderObject";

  @override
  _RenderObjectPageState createState() => _RenderObjectPageState();
}

class _RenderObjectPageState extends State<RenderObjectPage> {
  static final String page = WidgetDetailPage.rName;
  List<PageRouteModel> list = [
    PageRouteModel(
      page: page,
      arguments: CustomPadding(
        padding: EdgeInsets.all(20),
        child: Container(
          color: Colors.red,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListCard(
        list: list,
      ),
    );
  }
}
