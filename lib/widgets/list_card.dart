import 'dart:ui';

import 'package:demo/model/index.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final List<CloneListItemModel> list;

  ListCard({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 50),
      itemCount: list?.length ?? 0,
      itemBuilder: (_, index) {
        return _ListItem(model: list[index],);
      },
    );
  }
}

class _ListItem extends StatelessWidget {
  final CloneListItemModel model;

  _ListItem({this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: model?.onPress,
      child: Card(
        shadowColor: Colors.pink,
        elevation: 10,
        margin: EdgeInsets.only(top: 10),
        color: Colors.blue,
        child: Container(
          height: 100,
          alignment: Alignment.center,
          child: Text(model?.title ?? "unKnow", style: TextStyle(fontSize: 24),),
        ),
      ),
    );
  }
}
