import 'package:demo/model/index.dart';
import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class ClonePage extends StatefulWidget {
  static const String rName = "Clone";

  @override
  _CloneState createState() => _CloneState();
}

class _CloneState extends State<ClonePage> {
  List<PageRouteModel> list = [
    PageRouteModel(title: 'WeChat drop down', page: WeChatHomeDropDown.rName),
    PageRouteModel(title: 'Tb drop down'),
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
