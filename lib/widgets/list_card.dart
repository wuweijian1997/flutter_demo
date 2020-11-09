import 'dart:math';
import 'dart:ui';

import 'package:demo/model/index.dart';
import 'package:demo/navigator_util.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final List<PageRouteModel> list;

  ListCard({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      itemCount: list?.length ?? 0,
      itemBuilder: (_, index) {
        return _ListItem(model: list[index],);
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final PageRouteModel model;
  final Color color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  final Color shadowColor = Colors.primaries[Random().nextInt(Colors.primaries.length)];

  _ListItem({this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorUtil.getInstance().pushNamed(model.page, model.arguments),
      child: Card(
        shadowColor: shadowColor,
        elevation: 10,
        margin: EdgeInsets.only(top: 10),
        color: color,
        child: Container(
          height: 100,
          alignment: Alignment.center,
          child: Text(model?.title ?? "unKnow", style: TextStyle(fontSize: 24),),
        ),
      ),
    );
  }
}
