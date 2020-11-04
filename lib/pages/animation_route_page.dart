import 'dart:math';

import 'package:demo/pages/index.dart';
import 'package:demo/widgets/index.dart';
import 'package:flutter/material.dart';

class AnimationRoutePage extends StatefulWidget {
  static const rName = 'AnimationRoute';

  @override
  _AnimationRoutePageState createState() => _AnimationRoutePageState();
}

class _AnimationRoutePageState extends State<AnimationRoutePage> {
  onAnimationPage(BuildContext context, Offset offset) {
    Navigator.of(context).push(
        CircularClipRoute(
            offset: offset,
            builder: (ctx) {
              return ConstDemo();
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (_, index) => SizedBox(
          height: 10,
        ),
        itemCount: 10,
        itemBuilder: (_, index) {
          Color color = Colors.accents[Random().nextInt(Colors.accents.length)];
          return GestureDetector(
            onTapDown: (detail) {
              onAnimationPage(context, detail.globalPosition);
            },
            child: Container(
              height: 200,
              color: color,
            ),
          );
        },
      ),
    );
  }
}
